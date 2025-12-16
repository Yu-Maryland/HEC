// src/runner_parallel.rs
//! Minimal parallel runner: reuse all data structures from `runner.rs`,
//! parallelize only the search phase with Rayon.

use std::fmt::{self, Debug, Formatter};
use std::time::{Duration, Instant};
use rayon::prelude::*;
use log::*;

use crate::*;
use crate::run::{
    StopReason, Report, Iteration, RewriteScheduler,
};

pub struct RunnerMT<L: Language, N: Analysis<L>, IterData = ()> {
    pub egraph: EGraph<L, N>,
    pub iterations: Vec<Iteration<IterData>>,
    pub roots: Vec<Id>,
    pub stop_reason: Option<StopReason>,

    #[allow(clippy::type_complexity)]
    pub hooks: Vec<Box<dyn FnMut(&mut Self) -> Result<(), String>>>,

    // limits
    iter_limit: usize,
    node_limit: usize,
    time_limit: Duration,

    start_time: Option<Instant>,
    scheduler: Box<dyn RewriteScheduler<L, N>>,
}

impl<L, N> Default for RunnerMT<L, N, ()>
where
    L: Language,
    N: Analysis<L> + Default,
{
    fn default() -> Self { Self::new(N::default()) }
}

impl<L, N, IterData> Debug for RunnerMT<L, N, IterData>
where
    L: Language,
    N: Analysis<L>,
    IterData: Debug,
{
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        let RunnerMT {
            egraph,
            iterations,
            roots,
            stop_reason,
            hooks,
            iter_limit,
            node_limit,
            time_limit,
            start_time,
            scheduler: _,
        } = self;

        f.debug_struct("RunnerParallel")
            .field("egraph", egraph)
            .field("iterations", iterations)
            .field("roots", roots)
            .field("stop_reason", stop_reason)
            .field("hooks", &vec![format_args!("<dyn FnMut ..>"); hooks.len()])
            .field("iter_limit", iter_limit)
            .field("node_limit", node_limit)
            .field("time_limit", time_limit)
            .field("start_time", start_time)
            .field("scheduler", &format_args!("<dyn RewriteScheduler ..>"))
            .finish()
    }
}

impl<L, N, IterData> RunnerMT<L, N, IterData>
where
    L: Language,
    N: Analysis<L>,
    IterData: IterationDataMT<L, N>,
{
    pub fn new(analysis: N) -> Self {
        Self {
            iter_limit: 30,
            node_limit: 10_000,
            time_limit: Duration::from_secs(5),

            egraph: EGraph::new(analysis),
            roots: vec![],
            iterations: vec![],
            stop_reason: None,
            hooks: Vec::new(),

            start_time: None,
            scheduler: Box::new(crate::run::BackoffScheduler::default()),
        }
    }

    pub fn with_iter_limit(self, iter_limit: usize) -> Self { Self { iter_limit, ..self } }
    pub fn with_node_limit(self, node_limit: usize) -> Self { Self { node_limit, ..self } }
    pub fn with_time_limit(self, time_limit: Duration) -> Self { Self { time_limit, ..self } }
    pub fn with_time_limit_secs(self, secs: f32) -> Self {
        Self { time_limit: Duration::from_secs_f32(secs), ..self }
    }
    pub fn with_scheduler(self, scheduler: impl RewriteScheduler<L, N> + 'static) -> Self {
        let scheduler = Box::new(scheduler);
        Self { scheduler, ..self }
    }
    pub fn with_hook<F>(mut self, hook: F) -> Self
    where
        F: FnMut(&mut Self) -> Result<(), String> + 'static,
    {
        self.hooks.push(Box::new(hook));
        self
    }
    pub fn with_expr(mut self, expr: &RecExpr<L>) -> Self {
        let id = self.egraph.add_expr(expr);
        self.roots.push(id);
        self
    }
    pub fn with_egraph(self, egraph: EGraph<L, N>) -> Self { Self { egraph, ..self } }

    pub fn with_explanations_enabled(mut self) -> Self {
        self.egraph = self.egraph.with_explanations_enabled(); self
    }
    pub fn without_explanation_length_optimization(mut self) -> Self {
        self.egraph = self.egraph.without_explanation_length_optimization(); self
    }
    pub fn with_explanation_length_optimization(mut self) -> Self {
        self.egraph = self.egraph.with_explanation_length_optimization(); self
    }
    pub fn with_explanations_disabled(mut self) -> Self {
        self.egraph = self.egraph.with_explanations_disabled(); self
    }

    pub fn explain_equivalence(&mut self, left: &RecExpr<L>, right: &RecExpr<L>) -> Explanation<L> {
        self.egraph.explain_equivalence(left, right)
    }
    pub fn explain_existance(&mut self, expr: &RecExpr<L>) -> Explanation<L> {
        self.egraph.explain_existance(expr)
    }
    pub fn explain_existance_pattern(
        &mut self, pattern: &PatternAst<L>, subst: &Subst,
    ) -> Explanation<L> {
        self.egraph.explain_existance_pattern(pattern, subst)
    }
    pub fn explain_matches(
        &mut self, left: &RecExpr<L>, right: &PatternAst<L>, subst: &Subst,
    ) -> Explanation<L> {
        self.egraph.explain_matches(left, right, subst)
    }

    pub fn print_report(&self) { println!("{}", self.report()) }
    pub fn report(&self) -> Report {
        Report {
            stop_reason: self.stop_reason.clone().unwrap(),
            iterations: self.iterations.len(),
            egraph_nodes: self.egraph.total_number_of_nodes(),
            egraph_classes: self.egraph.number_of_classes(),
            memo_size: self.egraph.total_size(),
            rebuilds: self.iterations.iter().map(|i| i.n_rebuilds).sum(),
            search_time: self.iterations.iter().map(|i| i.search_time).sum(),
            apply_time: self.iterations.iter().map(|i| i.apply_time).sum(),
            rebuild_time: self.iterations.iter().map(|i| i.rebuild_time).sum(),
            total_time: self.iterations.iter().map(|i| i.total_time).sum(),
        }
    }

    pub fn run<'a, R>(mut self, rules: R) -> Self
    where
        R: IntoIterator<Item = &'a Rewrite<L, N>>,
        L: 'a + Language + Send + Sync,
        N: 'a + Analysis<L> + Send + Sync,
        <L as Language>::Discriminant: Send + Sync,
        <N as Analysis<L>>::Data: Sync,
    {
        let rules: Vec<&Rewrite<L, N>> = rules.into_iter().collect();
        check_rules(&rules);
        self.egraph.rebuild();

        loop {
            let iter = self.run_one(&rules);
            self.iterations.push(iter);
            let stop_reason = self.iterations.last().unwrap().stop_reason.clone();
            if let Some(stop_reason) = stop_reason.or_else(|| self.check_limits().err()) {
                info!("Stopping: {:?}", stop_reason);
                self.stop_reason = Some(stop_reason);
                break;
            }
        }

        assert!(!self.iterations.is_empty());
        assert!(self.stop_reason.is_some());
        self
    }

    fn run_one(&mut self, rules: &[&Rewrite<L, N>]) -> Iteration<IterData>
    where
        L: Language + Send + Sync,
        N: Analysis<L> + Send + Sync,
        <L as Language>::Discriminant: Send + Sync,
        <N as Analysis<L>>::Data: Sync,
    {
        assert!(self.stop_reason.is_none());
        info!("\nIteration {}", self.iterations.len());
    
        self.try_start();
        let mut result = self.check_limits();
    
        let egraph_nodes = self.egraph.total_size();
        let egraph_classes = self.egraph.number_of_classes();
    
        // ---------- hooks ----------
        let hook_t0 = Instant::now();
        let mut hooks = std::mem::take(&mut self.hooks);
        result = result.and_then(|_| {
            hooks
                .iter_mut()
                .try_for_each(|hook| hook(self).map_err(StopReason::Other))
        });
        self.hooks = hooks;
        let hook_time = hook_t0.elapsed().as_secs_f64();
    
        let egraph_nodes_after_hooks = self.egraph.total_size();
        let egraph_classes_after_hooks = self.egraph.number_of_classes();
    
        let i = self.iterations.len();
        trace!("EGraph {:?}", self.egraph.dump());
    
        let iter_t0 = Instant::now(); // total iteration timer
    
        // ---------- parallel search with scheduler plan/feedback ----------
        let mut matches: Vec<Vec<SearchMatches<L>>> = Vec::new();
        let mut applied = IndexMap::default();
    
        let search_t0 = Instant::now();
        result = result.and_then(|_| {
            // 1) Plan: read-only decision on threshold/whether to disable
            let plans: Vec<Option<usize>> = rules
                .iter()
                .map(|rw| self.scheduler.plan_for_rule(i, rw))
                .collect();
    
            // 2) Parallel search (limit egraph borrowing scope)
            let searched: Vec<(usize, Vec<SearchMatches<L>>)> = {
                let egraph_ref: &EGraph<L, N> = &self.egraph;
                (0..rules.len())
                    .into_par_iter()
                    .filter_map(|idx| {
                        plans[idx].map(|limit| {
                            let ms = rules[idx].search_with_limit(
                                egraph_ref,
                                limit.saturating_add(1),
                            );
                            (idx, ms)
                        })
                    })
                    .collect()
            }; // —— Leave block, end borrowing
    
            // 3) Backfill into vector aligned with rules
            matches = (0..rules.len()).map(|_| Vec::new()).collect();
            for (idx, ms) in searched {
                matches[idx] = ms;
            }
    
            // 4) Serial writeback statistics (ban/threshold backoff update)
            for (idx, rw) in rules.iter().enumerate() {
                if let Some(threshold) = plans[idx] {
                    let total_matches: usize = matches[idx].iter().map(|m| m.substs.len()).sum();
            
                    // Key: discard this round to avoid entering apply
                    if total_matches > threshold {
                        matches[idx].clear();
                    }
            
                    self.scheduler.on_searched(i, rw, total_matches, threshold);
                }
            }
    
            // 5) Unified limit check
            self.check_limits()
        });
        let search_time = search_t0.elapsed().as_secs_f64();
        info!("Search (parallel) time: {:.6}", search_time);
    
        // ---------- apply (serial) ----------
        let apply_t0 = Instant::now();
        result = result.and_then(|_| {
            rules.iter().zip(matches).try_for_each(|(rw, ms)| {
                debug!("applied rule: {}", rw.name);
                let total_matches: usize = ms.iter().map(|m| m.substs.len()).sum();
                debug!("Applying {} {} times", rw.name, total_matches);
    
                let actually_matched = self.scheduler.apply_rewrite(i, &mut self.egraph, rw, ms);
                if actually_matched > 0 {
                    *applied.entry(rw.name.to_owned()).or_insert(0) += actually_matched;
                    debug!("Applied {} {} times", rw.name, actually_matched);
                }
                self.check_limits()
            })
        });
        let apply_time = apply_t0.elapsed().as_secs_f64();
        info!("Apply time: {}", apply_time);
    
        // ---------- rebuild ----------
        let rebuild_t0 = Instant::now();
        let n_rebuilds = self.egraph.rebuild_mt();
        if self.egraph.are_explanations_enabled() {
            debug_assert!(self.egraph.check_each_explain(rules));
        }
        let rebuild_time = rebuild_t0.elapsed().as_secs_f64();
        info!("Rebuild time: {}", rebuild_time);
        info!(
            "Size: n={}, e={}",
            self.egraph.total_size(),
            self.egraph.number_of_classes()
        );
    
        // ---------- saturation check ----------
        let can_be_saturated = applied.is_empty()
            && self.scheduler.can_stop(i)
            && (egraph_nodes == egraph_nodes_after_hooks)
            && (egraph_classes == egraph_classes_after_hooks)
            && (egraph_nodes == self.egraph.total_size())
            && (egraph_classes == self.egraph.number_of_classes());
    
        if can_be_saturated {
            result = result.and(Err(StopReason::Saturated))
        }
    
        Iteration {
            applied,
            egraph_nodes,
            egraph_classes,
            hook_time,
            search_time,
            apply_time,
            rebuild_time,
            n_rebuilds,
            data: IterData::make(self),
            total_time: iter_t0.elapsed().as_secs_f64(),
            stop_reason: result.err(),
        }
    }
    

    fn try_start(&mut self) {
        self.start_time.get_or_insert_with(Instant::now);
    }

    fn check_limits(&self) -> Result<(), StopReason> {
        let elapsed = self.start_time.unwrap().elapsed();
        if elapsed > self.time_limit {
            return Err(StopReason::TimeLimit(elapsed.as_secs_f64()));
        }
        let size = self.egraph.total_size();
        if size > self.node_limit {
            return Err(StopReason::NodeLimit(size));
        }
        if self.iterations.len() >= self.iter_limit {
            return Err(StopReason::IterationLimit(self.iterations.len()));
        }
        Ok(())
    }
}

fn check_rules<L, N>(rules: &[&Rewrite<L, N>]) {
    let mut name_counts = IndexMap::default();
    for rw in rules {
        *name_counts.entry(rw.name).or_default() += 1
    }
    name_counts.retain(|_, count: &mut usize| *count > 1);
    if !name_counts.is_empty() {
        eprintln!("WARNING: Duplicated rule names may affect rule reporting and scheduling.");
        log::warn!("Duplicated rule names may affect rule reporting and scheduling.");
        for (name, &count) in name_counts.iter() {
            assert!(count > 1);
            eprintln!("Rule '{}' appears {} times", name, count);
            log::warn!("Rule '{}' appears {} times", name, count);
        }
    }
}

pub trait IterationDataMT<L, N>: Sized
where
    L: Language,
    N: Analysis<L>,
{
    /// Given the current [`RunnerMT`], make the
    /// data to be put in this [`Iteration`].
    fn make(runner: &RunnerMT<L, N, Self>) -> Self;
}

impl<L, N> IterationDataMT<L, N> for ()
where
    L: Language,
    N: Analysis<L>,
{
    fn make(_: &RunnerMT<L, N, Self>) -> Self {}
}
