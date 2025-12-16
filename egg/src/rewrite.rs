use pattern::apply_pat;
use std::fmt::{self, Debug, Display};
use std::sync::Arc;
use std::collections::VecDeque;

use crate::*;

/// A rewrite that searches for the lefthand side and applies the righthand side.
///
/// The [`rewrite!`] macro is the easiest way to create rewrites.
///
/// A [`Rewrite`] consists principally of a [`Searcher`] (the lefthand
/// side) and an [`Applier`] (the righthand side).
/// It additionally stores a name used to refer to the rewrite and a
/// long name used for debugging.
///
#[derive(Clone)]
#[non_exhaustive]
pub struct Rewrite<L, N> {
    /// The name of the rewrite.
    pub name: Symbol,
    /// The searcher (left-hand side) of the rewrite.
    pub searcher: Arc<dyn Searcher<L, N> + Sync + Send>,
    /// The applier (right-hand side) of the rewrite.
    pub applier: Arc<dyn Applier<L, N> + Sync + Send>,
}

impl<L, N> Debug for Rewrite<L, N>
where
    L: Language + Display + 'static,
    N: Analysis<L> + 'static,
{
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let mut d = f.debug_struct("Rewrite");
        d.field("name", &self.name);

        // if let Some(pat) = Any::downcast_ref::<dyn Pattern<L>>(&self.searcher) {
        if let Some(pat) = self.searcher.get_pattern_ast() {
            d.field("searcher", &DisplayAsDebug(pat));
        } else {
            d.field("searcher", &"<< searcher >>");
        }

        if let Some(pat) = self.applier.get_pattern_ast() {
            d.field("applier", &DisplayAsDebug(pat));
        } else {
            d.field("applier", &"<< applier >>");
        }

        d.finish()
    }
}

impl<L: Language, N: Analysis<L>> Rewrite<L, N> {
    /// Create a new [`Rewrite`]. You typically want to use the
    /// [`rewrite!`] macro instead.
    ///
    pub fn new(
        name: impl Into<Symbol>,
        searcher: impl Searcher<L, N> + Send + Sync + 'static,
        applier: impl Applier<L, N> + Send + Sync + 'static,
    ) -> Result<Self, String> {
        let name = name.into();
        let searcher = Arc::new(searcher);
        let applier = Arc::new(applier);

        let bound_vars = searcher.vars();
        for v in applier.vars() {
            if !bound_vars.contains(&v) {
                return Err(format!("Rewrite {} refers to unbound var {}", name, v));
            }
        }

        Ok(Self {
            name,
            searcher,
            applier,
        })
    }

    /// Call [`search`] on the [`Searcher`].
    ///
    /// [`search`]: Searcher::search()
    pub fn search(&self, egraph: &EGraph<L, N>) -> Vec<SearchMatches<'_, L>> {
        self.searcher.search(egraph)
    }

    /// Call [`search_with_limit`] on the [`Searcher`].
    ///
    /// [`search_with_limit`]: Searcher::search_with_limit()
    pub fn search_with_limit(&self, egraph: &EGraph<L, N>, limit: usize) -> Vec<SearchMatches<'_, L>> {
        self.searcher.search_with_limit(egraph, limit)
    }

    /// Call [`apply_matches`] on the [`Applier`].
    ///
    /// [`apply_matches`]: Applier::apply_matches()
    pub fn apply(&self, egraph: &mut EGraph<L, N>, matches: &[SearchMatches<'_, L>]) -> Vec<Id> {
        self.applier.apply_matches(egraph, matches, self.name)
    }

    /// This `run` is for testing use only. You should use things
    /// from the `egg::run` module
    #[cfg(test)]
    pub(crate) fn run(&self, egraph: &mut EGraph<L, N>) -> Vec<Id> {
        let start = crate::util::Instant::now();

        let matches = self.search(egraph);
        log::debug!("Found rewrite {} {} times", self.name, matches.len());

        let ids = self.apply(egraph, &matches);
        let elapsed = start.elapsed();
        log::debug!(
            "Applied rewrite {} {} times in {}.{:03}",
            self.name,
            ids.len(),
            elapsed.as_secs(),
            elapsed.subsec_millis()
        );

        egraph.rebuild();
        ids
    }
}

/// Searches the given list of e-classes with a limit.
pub(crate) fn search_eclasses_with_limit<'a, I, S, L, N>(
    searcher: &'a S,
    egraph: &EGraph<L, N>,
    eclasses: I,
    mut limit: usize,
) -> Vec<SearchMatches<'a, L>>
where
    L: Language,
    N: Analysis<L>,
    S: Searcher<L, N> + ?Sized,
    I: IntoIterator<Item = Id>,
{
    let mut ms = vec![];
    for eclass in eclasses {
        if limit == 0 {
            break;
        }
        match searcher.search_eclass_with_limit(egraph, eclass, limit) {
            None => continue,
            Some(m) => {
                let len = m.substs.len();
                assert!(len <= limit);
                limit -= len;
                ms.push(m);
            }
        }
    }
    ms
}

/// The lefthand side of a [`Rewrite`].
///
/// A [`Searcher`] is something that can search the egraph and find
/// matching substitutions.
/// Right now the only significant [`Searcher`] is [`Pattern`].
///
pub trait Searcher<L, N>
where
    L: Language,
    N: Analysis<L>,
{
    /// Search one eclass, returning None if no matches can be found.
    /// This should not return a SearchMatches with no substs.
    fn search_eclass(&self, egraph: &EGraph<L, N>, eclass: Id) -> Option<SearchMatches<'_, L>> {
        self.search_eclass_with_limit(egraph, eclass, usize::MAX)
    }

    /// Similar to [`search_eclass`], but return at most `limit` many matches.
    ///
    /// Implementation of [`Searcher`] should implement
    /// [`search_eclass_with_limit`].
    ///
    /// [`search_eclass`]: Searcher::search_eclass
    /// [`search_eclass_with_limit`]: Searcher::search_eclass_with_limit
    fn search_eclass_with_limit(
        &self,
        egraph: &EGraph<L, N>,
        eclass: Id,
        limit: usize,
    ) -> Option<SearchMatches<'_, L>>;

    /// Search the whole [`EGraph`], returning a list of all the
    /// [`SearchMatches`] where something was found.
    /// This just calls [`Searcher::search_with_limit`] with a big limit.
    fn search(&self, egraph: &EGraph<L, N>) -> Vec<SearchMatches<'_, L>> {
        self.search_with_limit(egraph, usize::MAX)
    }

    /// Similar to [`search`], but return at most `limit` many matches.
    ///
    /// [`search`]: Searcher::search
    fn search_with_limit(&self, egraph: &EGraph<L, N>, limit: usize) -> Vec<SearchMatches<'_, L>> {
        search_eclasses_with_limit(self, egraph, egraph.classes().map(|e| e.id), limit)
    }

    /// Returns the number of matches in the e-graph
    fn n_matches(&self, egraph: &EGraph<L, N>) -> usize {
        self.search(egraph).iter().map(|m| m.substs.len()).sum()
    }

    /// For patterns, return the ast directly as a reference
    fn get_pattern_ast(&self) -> Option<&PatternAst<L>> {
        None
    }

    /// Returns a list of the variables bound by this Searcher
    fn vars(&self) -> Vec<Var>;
}

/// The righthand side of a [`Rewrite`].
///
/// An [`Applier`] is anything that can do something with a
/// substitution ([`Subst`]). This allows you to implement rewrites
/// that determine when and how to respond to a match using custom
/// logic, including access to the [`Analysis`] data of an [`EClass`].
///
/// Notably, [`Pattern`] implements [`Applier`], which suffices in
/// most cases.
/// Additionally, `egg` provides [`ConditionalApplier`] to stack
/// [`Condition`]s onto an [`Applier`], which in many cases can save
/// you from having to implement your own applier.
///
/// # Example
/// ```
/// use egg::{rewrite as rw, *};
/// use std::sync::Arc;
///
/// define_language! {
///     enum Math {
///         Num(i32),
///         "+" = Add([Id; 2]),
///         "*" = Mul([Id; 2]),
///         Symbol(Symbol),
///     }
/// }
///
/// type EGraph = egg::EGraph<Math, MinSize>;
///
/// // Our metadata in this case will be size of the smallest
/// // represented expression in the eclass.
/// #[derive(Default)]
/// struct MinSize;
/// impl Analysis<Math> for MinSize {
///     type Data = usize;
///     fn merge(&mut self, to: &mut Self::Data, from: Self::Data) -> DidMerge {
///         merge_min(to, from)
///     }
///     fn make(egraph: &mut EGraph, enode: &Math) -> Self::Data {
///         let get_size = |i: Id| egraph[i].data;
///         AstSize.cost(enode, get_size)
///     }
/// }
///
/// let rules = &[
///     rw!("commute-add"; "(+ ?a ?b)" => "(+ ?b ?a)"),
///     rw!("commute-mul"; "(* ?a ?b)" => "(* ?b ?a)"),
///     rw!("add-0"; "(+ ?a 0)" => "?a"),
///     rw!("mul-0"; "(* ?a 0)" => "0"),
///     rw!("mul-1"; "(* ?a 1)" => "?a"),
///     // the rewrite macro parses the rhs as a single token tree, so
///     // we wrap it in braces (parens work too).
///     rw!("funky"; "(+ ?a (* ?b ?c))" => { Funky {
///         a: "?a".parse().unwrap(),
///         b: "?b".parse().unwrap(),
///         c: "?c".parse().unwrap(),
///         ast: "(+ (+ ?a 0) (* (+ ?b 0) (+ ?c 0)))".parse().unwrap(),
///     }}),
/// ];
///
/// #[derive(Debug, Clone, PartialEq, Eq)]
/// struct Funky {
///     a: Var,
///     b: Var,
///     c: Var,
///     ast: PatternAst<Math>,
/// }
///
/// impl Applier<Math, MinSize> for Funky {
///
///     fn apply_one(&self, egraph: &mut EGraph, matched_id: Id, subst: &Subst, searcher_pattern: Option<&PatternAst<Math>>, rule_name: Symbol) -> Vec<Id> {
///         let a: Id = subst[self.a];
///         // In a custom Applier, you can inspect the analysis data,
///         // which is powerful combination!
///         let size_of_a = egraph[a].data;
///         if size_of_a > 50 {
///             println!("Too big! Not doing anything");
///             vec![]
///         } else {
///             // we're going to manually add:
///             // (+ (+ ?a 0) (* (+ ?b 0) (+ ?c 0)))
///             // to be unified with the original:
///             // (+    ?a    (*    ?b       ?c   ))
///             let b: Id = subst[self.b];
///             let c: Id = subst[self.c];
///             let zero = egraph.add(Math::Num(0));
///             let a0 = egraph.add(Math::Add([a, zero]));
///             let b0 = egraph.add(Math::Add([b, zero]));
///             let c0 = egraph.add(Math::Add([c, zero]));
///             let b0c0 = egraph.add(Math::Mul([b0, c0]));
///             let a0b0c0 = egraph.add(Math::Add([a0, b0c0]));
///             // Don't forget to union the new node with the matched node!
///             if egraph.union(matched_id, a0b0c0) {
///                 vec![a0b0c0]
///             } else {
///                 vec![]
///             }
///         }
///     }
/// }
///
/// let start = "(+ x (* y z))".parse().unwrap();
/// Runner::default().with_expr(&start).run(rules);
/// ```
pub trait Applier<L, N>
where
    L: Language,
    N: Analysis<L>,
{
    /// Apply many substitutions.
    ///
    /// This method should call [`apply_one`] for each match.
    ///
    /// It returns the ids resulting from the calls to [`apply_one`].
    /// The default implementation does this and should suffice for
    /// most use cases.
    ///
    /// [`apply_one`]: Applier::apply_one()
    fn apply_matches(
        &self,
        egraph: &mut EGraph<L, N>,
        matches: &[SearchMatches<L>],
        rule_name: Symbol,
    ) -> Vec<Id> {
        let mut added = vec![];
        for mat in matches {
            let ast = if egraph.are_explanations_enabled() {
                mat.ast.as_ref().map(|cow| cow.as_ref())
            } else {
                None
            };
            for subst in &mat.substs {
                let ids = self.apply_one(egraph, mat.eclass, subst, ast, rule_name);
                added.extend(ids)
            }
        }
        added
    }

    /// For patterns, get the ast directly as a reference.
    fn get_pattern_ast(&self) -> Option<&PatternAst<L>> {
        None
    }

    /// Apply a single substitution.
    ///
    /// An [`Applier`] should add things and union them with `eclass`.
    /// Appliers can also inspect the eclass if necessary using the
    /// `eclass` parameter.
    ///
    /// This should return a list of [`Id`]s of eclasses that
    /// were changed. There can be zero, one, or many.
    /// When explanations mode is enabled, a [`PatternAst`] for
    /// the searcher is provided.
    ///
    /// [`apply_matches`]: Applier::apply_matches()
    fn apply_one(
        &self,
        egraph: &mut EGraph<L, N>,
        eclass: Id,
        subst: &Subst,
        searcher_ast: Option<&PatternAst<L>>,
        rule_name: Symbol,
    ) -> Vec<Id>;

    /// Returns a list of variables that this Applier assumes are bound.
    ///
    /// `egg` will check that the corresponding `Searcher` binds those
    /// variables.
    /// By default this return an empty `Vec`, which basically turns off the
    /// checking.
    fn vars(&self) -> Vec<Var> {
        vec![]
    }
}

/// An [`Applier`] that checks a [`Condition`] before applying.
///
/// A [`ConditionalApplier`] simply calls [`check`] on the
/// [`Condition`] before calling [`apply_one`] on the inner
/// [`Applier`].
///
/// See the [`rewrite!`] macro documentation for an example.
///
/// [`apply_one`]: Applier::apply_one()
/// [`check`]: Condition::check()
#[derive(Clone, Debug)]
pub struct ConditionalApplier<C, A> {
    /// The [`Condition`] to [`check`] before calling [`apply_one`] on
    /// `applier`.
    ///
    /// [`apply_one`]: Applier::apply_one()
    /// [`check`]: Condition::check()
    pub condition: C,
    /// The inner [`Applier`] to call once `condition` passes.
    ///
    pub applier: A,
}

impl<C, A, N, L> Applier<L, N> for ConditionalApplier<C, A>
where
    L: Language,
    C: Condition<L, N>,
    A: Applier<L, N>,
    N: Analysis<L>,
{
    fn get_pattern_ast(&self) -> Option<&PatternAst<L>> {
        self.applier.get_pattern_ast()
    }

    fn apply_one(
        &self,
        egraph: &mut EGraph<L, N>,
        eclass: Id,
        subst: &Subst,
        searcher_ast: Option<&PatternAst<L>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        if self.condition.check(egraph, eclass, subst) {
            self.applier
                .apply_one(egraph, eclass, subst, searcher_ast, rule_name)
        } else {
            vec![]
        }
    }

    fn vars(&self) -> Vec<Var> {
        let mut vars = self.applier.vars();
        vars.extend(self.condition.vars());
        vars
    }
}

/// A condition to check in a [`ConditionalApplier`].
///
/// See the [`ConditionalApplier`] docs.
///
/// Notably, any function ([`Fn`]) that doesn't mutate other state
/// and matches the signature of [`check`] implements [`Condition`].
///
/// [`check`]: Condition::check()
/// [`Fn`]: std::ops::Fn
pub trait Condition<L, N>
where
    L: Language,
    N: Analysis<L>,
{
    /// Check a condition.
    ///
    /// `eclass` is the eclass [`Id`] where the match (`subst`) occured.
    /// If this is true, then the [`ConditionalApplier`] will fire.
    ///
    fn check(&self, egraph: &mut EGraph<L, N>, eclass: Id, subst: &Subst) -> bool;

    /// Returns a list of variables that this Condition assumes are bound.
    ///
    /// `egg` will check that the corresponding `Searcher` binds those
    /// variables.
    /// By default this return an empty `Vec`, which basically turns off the
    /// checking.
    fn vars(&self) -> Vec<Var> {
        vec![]
    }
}

impl<L, F, N> Condition<L, N> for F
where
    L: Language,
    N: Analysis<L>,
    F: Fn(&mut EGraph<L, N>, Id, &Subst) -> bool,
{
    fn check(&self, egraph: &mut EGraph<L, N>, eclass: Id, subst: &Subst) -> bool {
        self(egraph, eclass, subst)
    }
}

/// A [`Condition`] that checks if two terms are equivalent.
///
/// This condition adds its two [`Pattern`] to the egraph and passes
/// if and only if they are equivalent (in the same eclass).
///
#[derive(Debug)]
pub struct ConditionEqual<L> {
    p1: Pattern<L>,
    p2: Pattern<L>,
}

impl<L: Language> ConditionEqual<L> {
    /// Create a new [`ConditionEqual`] condition given two patterns.
    pub fn new(p1: Pattern<L>, p2: Pattern<L>) -> Self {
        ConditionEqual { p1, p2 }
    }
}

impl<L: FromOp> ConditionEqual<L> {
    /// Create a ConditionEqual by parsing two pattern strings.
    ///
    /// This panics if the parsing fails.
    pub fn parse(a1: &str, a2: &str) -> Self {
        Self {
            p1: a1.parse().unwrap(),
            p2: a2.parse().unwrap(),
        }
    }
}

impl<L, N> Condition<L, N> for ConditionEqual<L>
where
    L: Language,
    N: Analysis<L>,
{
    fn check(&self, egraph: &mut EGraph<L, N>, _eclass: Id, subst: &Subst) -> bool {
        let mut id_buf_1 = vec![0.into(); self.p1.ast.as_ref().len()];
        let mut id_buf_2 = vec![0.into(); self.p2.ast.as_ref().len()];
        let a1 = apply_pat(&mut id_buf_1, self.p1.ast.as_ref(), egraph, subst);
        let a2 = apply_pat(&mut id_buf_2, self.p2.ast.as_ref(), egraph, subst);
        a1 == a2
    }

    fn vars(&self) -> Vec<Var> {
        let mut vars = self.p1.vars();
        vars.extend(self.p2.vars());
        vars
    }
}

#[cfg(test)]
mod tests {

    use crate::{SymbolLang as S, *};
    use std::str::FromStr;

    type EGraph = crate::EGraph<S, ()>;

    #[test]
    fn conditional_rewrite() {
        crate::init_logger();
        let mut egraph = EGraph::default();

        let x = egraph.add(S::leaf("x"));
        let y = egraph.add(S::leaf("2"));
        let mul = egraph.add(S::new("*", vec![x, y]));

        let true_pat = Pattern::from_str("TRUE").unwrap();
        egraph.add(S::leaf("TRUE"));

        let pow2b = Pattern::from_str("(is-power2 ?b)").unwrap();
        let mul_to_shift = rewrite!(
            "mul_to_shift";
            "(* ?a ?b)" => "(>> ?a (log2 ?b))"
            if ConditionEqual::new(pow2b, true_pat)
        );

        println!("rewrite shouldn't do anything yet");
        egraph.rebuild();
        let apps = mul_to_shift.run(&mut egraph);
        assert!(apps.is_empty());

        println!("Add the needed equality");
        egraph.union_instantiations(
            &"(is-power2 2)".parse().unwrap(),
            &"TRUE".parse().unwrap(),
            &Default::default(),
            "direct-union".to_string(),
        );

        println!("Should fire now");
        egraph.rebuild();
        let apps = mul_to_shift.run(&mut egraph);
        assert_eq!(apps, vec![egraph.find(mul)]);
    }

    #[test]
    fn fn_rewrite() {
        crate::init_logger();
        let mut egraph = EGraph::default();

        let start = RecExpr::from_str("(+ x y)").unwrap();
        let goal = RecExpr::from_str("xy").unwrap();

        let root = egraph.add_expr(&start);

        fn get(egraph: &EGraph, id: Id) -> Symbol {
            egraph[id].nodes[0].op
        }

        #[derive(Debug)]
        struct Appender {
            _rhs: PatternAst<S>,
        }

        impl Applier<SymbolLang, ()> for Appender {
            fn apply_one(
                &self,
                egraph: &mut EGraph,
                eclass: Id,
                subst: &Subst,
                searcher_ast: Option<&PatternAst<SymbolLang>>,
                rule_name: Symbol,
            ) -> Vec<Id> {
                let a: Var = "?a".parse().unwrap();
                let b: Var = "?b".parse().unwrap();
                let a = get(egraph, subst[a]);
                let b = get(egraph, subst[b]);
                let s = format!("{}{}", a, b);
                if let Some(ast) = searcher_ast {
                    let (id, did_something) = egraph.union_instantiations(
                        ast,
                        &PatternAst::from_str(&s).unwrap(),
                        subst,
                        rule_name,
                    );
                    if did_something {
                        vec![id]
                    } else {
                        vec![]
                    }
                } else {
                    let added = egraph.add(S::leaf(&s));
                    if egraph.union(added, eclass) {
                        vec![eclass]
                    } else {
                        vec![]
                    }
                }
            }
        }

        let fold_add = rewrite!(
            "fold_add"; "(+ ?a ?b)" => { Appender { _rhs: "?a".parse().unwrap()}}
        );

        egraph.rebuild();
        fold_add.run(&mut egraph);
        assert_eq!(egraph.equivs(&start, &goal), vec![egraph.find(root)]);
    }
}

#[derive(Clone, Copy, Debug)]
enum Num {
    Int(i64),
    Flt(f64),
}

impl Num {
    fn from_leaf_sym(sym: &str) -> Option<Self> {
        if let Ok(i) = sym.parse::<i64>() {
            return Some(Num::Int(i));
        }
        if let Ok(f) = sym.parse::<f64>() {
            return Some(Num::Flt(f));
        }
        None
    }

    fn promote2(a: Num, b: Num) -> (Num, Num) {
        match (a, b) {
            (Num::Flt(x), Num::Int(y)) => (Num::Flt(x), Num::Flt(y as f64)),
            (Num::Int(x), Num::Flt(y)) => (Num::Flt(x as f64), Num::Flt(y)),
            (x, y) => (x, y),
        }
    }

    fn to_string(self) -> String {
        match self {
            Num::Int(i) => i.to_string(),
            Num::Flt(f) => {
                if f.fract() == 0.0 { (f as i64).to_string() } else { f.to_string() }
            }
        }
    }
}

fn pick_numeric_in_eclass<L: Language + std::fmt::Display, N: Analysis<L>>(
    egraph: &EGraph<L, N>,
    class_id: Id,
) -> Option<Num> {
    let cid = egraph.find(class_id);
    let class = &egraph[cid];
    for n in &class.nodes {
        if n.children().is_empty() {
            let s = n.to_string();
            if let Some(num) = Num::from_leaf_sym(&s) {
                return Some(num);
            }
        }
    }
    None
}

#[derive(Clone)]
struct ConstFoldApplier {
    /// Operator name, such as "+", "-", "*", "/", "mod", "floordiv", "ceildiv", "inv"
    op: &'static str,
    /// Number of arguments: 1 (inv) or 2 (others)
    arity: usize,
}

impl<L, N> Applier<L, N> for ConstFoldApplier
where
    L: Language + From<SymbolLang> + Into<SymbolLang> + std::fmt::Display,
    N: Analysis<L>,
    <L as Language>::Discriminant: From<<SymbolLang as Language>::Discriminant>,
{
    fn apply_one(
        &self,
        egraph: &mut EGraph<L, N>,
        eclass: Id,
        subst: &Subst,
        _searcher_ast: Option<&PatternAst<L>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        // For simplicity, we rely on the Searcher pattern to name children variables properly (see rule construction part)
        // Variable naming convention: unary inv uses ?x; binary uses ?a, ?b

        // Collect numeric values of sub-expressions
        let res_num: Option<Num> = match (self.op, self.arity) {
            ("inv", 1) => {
                let var = "?x".parse().unwrap();
                let x_id = egraph.find(subst[var]);
                pick_numeric_in_eclass(egraph, x_id).and_then(|x| {
                    Some(match x {
                        Num::Int(i) => Num::Int(-i),
                        Num::Flt(f) => Num::Flt(-f),
                    })
                })
            }
            (op, 2) => {
                let va = "?a".parse().unwrap();
                let vb = "?b".parse().unwrap();
                let a_id = egraph.find(subst[va]);
                let b_id = egraph.find(subst[vb]);
                let (a, b) = match (pick_numeric_in_eclass(egraph, a_id),
                                    pick_numeric_in_eclass(egraph, b_id)) {
                    (Some(a), Some(b)) => (a, b),
                    _ => return vec![],
                };

                match op {
                    "+" => {
                        let (a, b) = Num::promote2(a, b);
                        Some(match (a, b) {
                            (Num::Int(x), Num::Int(y)) => Num::Int(x + y),
                            (Num::Flt(x), Num::Flt(y)) => Num::Flt(x + y),
                            _ => unreachable!(),
                        })
                    }
                    "-" => {
                        let (a, b) = Num::promote2(a, b);
                        Some(match (a, b) {
                            (Num::Int(x), Num::Int(y)) => Num::Int(x - y),
                            (Num::Flt(x), Num::Flt(y)) => Num::Flt(x - y),
                            _ => unreachable!(),
                        })
                    }
                    "*" => {
                        let (a, b) = Num::promote2(a, b);
                        Some(match (a, b) {
                            (Num::Int(x), Num::Int(y)) => Num::Int(x * y),
                            (Num::Flt(x), Num::Flt(y)) => Num::Flt(x * y),
                            _ => unreachable!(),
                        })
                    }
                    "/" => {
                        // Allow floating point; skip folding on division by zero
                        let (a, b) = Num::promote2(a, b);
                        match (a, b) {
                            (_, Num::Int(0)) | (_, Num::Flt(0.0)) => None,
                            (Num::Flt(x), Num::Flt(y)) => Some(Num::Flt(x / y)),
                            _ => unreachable!(),
                        }
                    }
                    "floordiv" => {
                        match (a, b) {
                            (Num::Int(x), Num::Int(y)) if y != 0 => {
                                // Integer division with floor rounding
                                // Rust's x.div_euclid(y) rounds down "to the nearest non-negative remainder",
                                // floor(x/y) can be achieved via f64 floor or manual implementation; here using floor division:
                                let xf = x as f64;
                                let yf = y as f64;
                                Some(Num::Int((xf / yf).floor() as i64))
                            }
                            _ => None,
                        }
                    }
                    "ceildiv" => {
                        match (a, b) {
                            (Num::Int(x), Num::Int(y)) if y != 0 => {
                                let xf = x as f64;
                                let yf = y as f64;
                                Some(Num::Int((xf / yf).ceil() as i64))
                            }
                            _ => None,
                        }
                    }
                    "div" => {
                        match (a, b) {
                            (Num::Int(x), Num::Int(y)) if y != 0 && x % y == 0 => {
                                Some(Num::Int(x / y))
                            }
                            _ => None,
                        }
                    }
                    // "mod" => {
                    //     match (a, b) {
                    //         (Num::Int(x), Num::Int(y)) if y > 0 => {
                    //             if x < 0 { None }
                    //             else     { Some(Num::Int(x.rem_euclid(y))) }
                    //         }
                    //         _ => None,
                    //     }
                    // }
                    // "floordiv" => {
                    //     match (a, b) {
                    //         (Num::Int(x), Num::Int(y)) if y > 0 => {
                    //             if x < 0 { Some(Num::Int(0)) }
                    //             else {
                    //                 let xf = x as f64;
                    //                 let yf = y as f64;
                    //                 Some(Num::Int((xf / yf).floor() as i64))
                    //             }
                    //         }
                    //         _ => None,
                    //     }
                    // }
                    // "ceildiv" => {
                    //     match (a, b) {
                    //         (Num::Int(x), Num::Int(y)) if y > 0 => {
                    //             if x < 0 { Some(Num::Int(0)) }
                    //             else {
                    //                 let xf = x as f64;
                    //                 let yf = y as f64;
                    //                 Some(Num::Int((xf / yf).ceil() as i64))
                    //             }
                    //         }
                    //         _ => None,
                    //     }
                    // }
                    // "div" => {
                    //     match (a, b) {
                    //         (Num::Int(x), Num::Int(y)) if y > 0 => {
                    //             if x < 0 {
                    //                 Some(Num::Int(0))
                    //             } else if x % y == 0 {
                    //                 Some(Num::Int(x / y)) // Only fold when divisible
                    //             } else {
                    //                 None
                    //             }
                    //         }
                    //         _ => None,
                    //     }
                    // }
                    _ => None,
                }
            }
            _ => None,
        };

        if let Some(val) = res_num {
            // Generate result leaf and union to current eclass
            let leaf = SymbolLang::leaf(&val.to_string());
            let leaf_id_l: Id = egraph.add(leaf.into());
            // Record as rule proof (if explanations enabled)
            if egraph.union_trusted(leaf_id_l, eclass, rule_name) {
                vec![egraph.find(leaf_id_l)]
            } else {
                vec![]
            }
        } else {
            vec![]
        }
    }
}

/// Convenience function: generate all constant folding Rewrites (SymbolLang specific)
/// Usage: put all rules from the returned Vec into Runner
pub fn const_folding_rewrites<N>() -> Vec<Rewrite<SymbolLang, N>>
where
    N: Analysis<SymbolLang> + Default,
{
    let mk2 = |op: &'static str| {
        Rewrite::new(
            format!("const-fold-{}", op),
            // Search pattern (written in S-expression style): (op ?a ?b)
            format!("({} ?a ?b)", op).parse::<Pattern<SymbolLang>>().unwrap(),
            ConstFoldApplier { op, arity: 2 },
        )
        .unwrap()
    };
    let mk1 = |op: &'static str, var: &str| {
        Rewrite::new(
            format!("const-fold-{}", op),
            format!("({} {})", op, var).parse::<Pattern<SymbolLang>>().unwrap(), // (inv ?x)
            ConstFoldApplier { op, arity: 1 },
        )
        .unwrap()
    };

    let rules = vec![
        mk2("+"),
        mk2("-"),
        mk2("*"),
        mk2("/"),
        mk2("mod"),
        mk2("floordiv"),
        mk2("ceildiv"),
        mk2("div"),
        mk1("inv", "?x"),
    ];
    rules
}


#[derive(Clone)]
pub struct CommutativeSearcher {
    op: &'static str,
}

impl<N: Analysis<SymbolLang>> Searcher<SymbolLang, N> for CommutativeSearcher {
    fn search_eclass_with_limit(
        &self,
        egraph: &EGraph<SymbolLang, N>,
        eclass: Id,
        limit: usize,
    ) -> Option<SearchMatches<'_, SymbolLang>> {
        if limit == 0 { return None; }
        let class = &egraph[eclass];
        let found = class.nodes.iter().any(|n| {
            let is_leaf = n.children().is_empty();
            !is_leaf && n.op.as_str() == self.op && n.children().len() >= 2
        });
        if found {
            // No variables needed; return 1 empty substitution to indicate "this eclass has commutative nodes"
            Some(SearchMatches {
                eclass,
                substs: vec![Subst::default()],
                ast: None,
            })
        } else {
            None
        }
    }

    fn vars(&self) -> Vec<Var> { vec![] }
}

// —— Commutative Applier: generate permuted equivalent nodes and union —— //

#[derive(Clone)]
pub struct CommutativeApplier {
    op: &'static str,
    max_variants: usize, // When arity > 4, maximum number of different permutations to generate
}

impl CommutativeApplier {
    // Full permutation (n<=4) or limited sampling (n>4)
    fn gen_permutations_limited(ids: &[Id], max_variants: usize) -> Vec<Vec<Id>> {
        let n = ids.len();
        if n <= 1 { return vec![]; }

        // Small scale: give all permutations (remove those identical to original order)
        if n <= 4 {
            let mut res = Vec::new();
            let mut a = ids.to_vec();
            Self::permute_all(0, &mut a, &mut res);
            res.into_iter().filter(|p| p != ids).collect()
        } else {
            // Large scale: give no more than max_variants representative permutations (deterministic, no randomness)
            let mut res: Vec<Vec<Id>> = Vec::new();
            let mut seen: HashSet<Vec<Id>> = HashSet::default();

            let push = |v: Vec<Id>, res: &mut Vec<Vec<Id>>, seen: &mut HashSet<Vec<Id>>| {
                if !seen.contains(&v) {
                    seen.insert(v.clone());
                    res.push(v);
                }
            };

            // 1) Reverse
            let mut rev = ids.to_vec(); rev.reverse();
            if rev != ids { push(rev, &mut res, &mut seen); }
            if res.len() >= max_variants { return res; }

            // 2) Rotation (1..n-1)
            for r in 1..n {
                let mut rot = Vec::with_capacity(n);
                rot.extend_from_slice(&ids[r..]);
                rot.extend_from_slice(&ids[..r]);
                if rot != ids { push(rot, &mut res, &mut seen); }
                if res.len() >= max_variants { return res; }
            }

            // 3) Adjacent swap (i <-> i+1)
            for i in 0..n-1 {
                let mut sw = ids.to_vec();
                sw.swap(i, i+1);
                if sw != ids { push(sw, &mut res, &mut seen); }
                if res.len() >= max_variants { return res; }
            }

            // 4) Further binary swap (i <-> j)
            'outer: for i in 0..n {
                for j in (i+1)..n {
                    let mut sw = ids.to_vec();
                    sw.swap(i, j);
                    if sw != ids { push(sw, &mut res, &mut seen); }
                    if res.len() >= max_variants { break 'outer; }
                }
            }

            res
        }
    }

    fn permute_all(k: usize, a: &mut [Id], out: &mut Vec<Vec<Id>>) {
        if k == a.len() {
            out.push(a.to_vec());
            return;
        }
        for i in k..a.len() {
            a.swap(k, i);
            Self::permute_all(k + 1, a, out);
            a.swap(k, i);
        }
    }
}

impl<N: Analysis<SymbolLang>> Applier<SymbolLang, N> for CommutativeApplier {
    fn apply_one(
        &self,
        egraph: &mut EGraph<SymbolLang, N>,
        eclass: Id,
        _subst: &Subst,
        _searcher_ast: Option<&PatternAst<SymbolLang>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        // Find any (op children...) in this eclass as "baseline", generate permutations based on its children
        let class = &egraph[eclass];
        let mut changed: Vec<Id> = Vec::new();

        // To avoid duplicate work on different equivalent nodes with same children, simply use only the first matched node
        if let Some(base) = class.nodes.iter().find(|n| {
            !n.children().is_empty() && n.op.as_str() == self.op && n.children().len() >= 2
        }).cloned() {
            let children = base.children().to_vec();
            let n = children.len();
            let limit = if n > 4 { self.max_variants } else { usize::MAX };
            let variants = Self::gen_permutations_limited(&children, limit);

            for chs in variants {
                let new_node = SymbolLang::new(self.op, chs);
                let added = egraph.add(new_node);
                if egraph.union_trusted(added, eclass, rule_name) {
                    changed.push(egraph.find(added));
                }
            }
        }

        changed
    }

    fn vars(&self) -> Vec<Var> { vec![] }
}

// —— External convenience function: commutative("+", 10) generates a Rewrite —— //

pub fn commutative<N>(op: &'static str, max_variants: usize) -> Rewrite<SymbolLang, N>
where
    N: Analysis<SymbolLang> + 'static,
{
    Rewrite::new(
        format!("commutative-{}", op),
        CommutativeSearcher { op },
        CommutativeApplier { op, max_variants },
    ).unwrap()
}


#[derive(Clone)]
pub struct ACSearcher {
    op: &'static str,
}

impl<N: Analysis<SymbolLang>> Searcher<SymbolLang, N> for ACSearcher {
    fn search_eclass_with_limit(
        &self,
        egraph: &EGraph<SymbolLang, N>,
        eclass: Id,
        limit: usize,
    ) -> Option<SearchMatches<'_, SymbolLang>> {
        if limit == 0 { return None; }
        let class = &egraph[eclass];
        let found = class.nodes.iter().any(|n| {
            !n.children().is_empty() && n.op.as_str() == self.op && n.children().len() >= 2
        });
        if found {
            Some(SearchMatches {
                eclass,
                substs: vec![Subst::default()], // No variables need to be bound
                ast: None,
            })
        } else {
            None
        }
    }

    fn vars(&self) -> Vec<Var> { vec![] }
}

// ===== AC Applier: flatten + sort ——> generate canonical form and union =====

#[derive(Clone)]
pub struct ACApplier {
    op: &'static str,
}

impl ACApplier {
    fn flatten_collect<N: Analysis<SymbolLang>>(
        &self,
        egraph: &EGraph<SymbolLang, N>,
        base: &SymbolLang,
    ) -> Vec<Id> {
        let mut args: Vec<Id> = Vec::new();
        let mut stack: Vec<Id> = base.children().to_vec();
        let mut seen: HashSet<Id> = HashSet::default();

        while let Some(id) = stack.pop() {
            let cid = egraph.find(id);

            // Prevent cycles from forming in e-graph in extreme cases
            if !seen.insert(cid) {
                args.push(cid);
                continue;
            }

            let child_class = &egraph[cid];
            // If the child eclass contains nodes with the same op, continue to "unpack" downward to achieve flattening
            if let Some(opnode) = child_class.nodes.iter().find(|n|
                !n.children().is_empty() && n.op.as_str() == self.op
            ) {
                for &ch in opnode.children() {
                    stack.push(ch);
                }
            } else {
                args.push(cid);
            }
        }

        // Commutativity: sort by eclass Id to form deterministic canonical order
        args.sort_unstable_by_key(|id| usize::from(*id));
        args
    }
}

impl<N: Analysis<SymbolLang>> Applier<SymbolLang, N> for ACApplier {
    fn apply_one(
        &self,
        egraph: &mut EGraph<SymbolLang, N>,
        eclass: Id,
        _subst: &Subst,
        _searcher_ast: Option<&PatternAst<SymbolLang>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        // Find a (op ...) in this eclass as "baseline" for flattening
        let base = {
            let class = &egraph[eclass];
            class.nodes.iter().find(|n|
                !n.children().is_empty() && n.op.as_str() == self.op && n.children().len() >= 2
            ).cloned()
        };

        if let Some(base) = base {
            let flat_children = self.flatten_collect(egraph, &base);
            // Construct canonical form (op <sorted children...>)
            let canonical = SymbolLang::new(self.op, flat_children);
            let canonical_id = egraph.add(canonical);

            // Merge with original eclass to establish AC equivalence
            if egraph.union_trusted(canonical_id, eclass, rule_name) {
                vec![egraph.find(canonical_id)]
            } else {
                vec![]
            }
        } else {
            vec![]
        }
    }

    fn vars(&self) -> Vec<Var> { vec![] }
}

// ===== External convenience functions: ac_closure("+") / ac_closure("*") etc. =====

pub fn ac_closure<N>(op: &'static str) -> Rewrite<SymbolLang, N>
where
    N: Analysis<SymbolLang> + 'static,
{
    Rewrite::new(
        format!("ac-closure-{}", op),
        ACSearcher { op },
        ACApplier { op },
    ).unwrap()
}


// Flatten only, no sorting Searcher + Applier
#[derive(Clone)]
struct FlattenOnly {
    op: Symbol,
}

impl<N> Searcher<SymbolLang, N> for FlattenOnly
where
    N: Analysis<SymbolLang>,
{
    fn search_eclass_with_limit(
        &self,
        egraph: &EGraph<SymbolLang, N>,
        eclass: Id,
        _limit: usize,
    ) -> Option<SearchMatches<'_, SymbolLang>> {
        let class = &egraph[eclass];
        // As long as this eclass has an op node, and one of its children's eclass also has the same op node, trigger
        let mut found = false;
        'outer: for n in &class.nodes {
            if n.children().is_empty() || n.op != self.op { continue; }
            for &ch in n.children() {
                let cc = egraph.find(ch);
                if egraph[cc].nodes.iter().any(|m| !m.children().is_empty() && m.op == self.op) {
                    found = true;
                    break 'outer;
                }
            }
        }
        if found {
            Some(SearchMatches {
                eclass,
                substs: vec![Subst::default()], // This rule doesn't use variables
                ast: None,
            })
        } else {
            None
        }
    }

    fn vars(&self) -> Vec<Var> { vec![] }
}

impl<N> Applier<SymbolLang, N> for FlattenOnly
where
    N: Analysis<SymbolLang>,
{
    fn apply_one(
        &self,
        egraph: &mut EGraph<SymbolLang, N>,
        eclass: Id,
        _subst: &Subst,
        _searcher_ast: Option<&PatternAst<SymbolLang>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        // Clone node list to avoid mutable borrowing conflicts
        let nodes = egraph[eclass].nodes.clone();
        let mut changed = vec![];

        for n in nodes {
            if n.op != self.op || n.children().is_empty() { continue; }

            // Traverse children in original order; if a child eclass has op nodes, merge its children (preserve order)
            let mut flat: Vec<Id> = Vec::new();
            let mut did_flatten = false;

            for &cid in n.children() {
                let cc = egraph.find(cid);
                if let Some(kid) = egraph[cc].nodes.iter().find(|m| !m.children().is_empty() && m.op == self.op) {
                    flat.extend_from_slice(kid.children()); // Concatenate in original order
                    did_flatten = true;
                } else {
                    flat.push(cc);
                }
            }

            if did_flatten {
                // Generate flat node (no sorting, no deduplication)
                let new_node = SymbolLang::new(self.op, flat);
                let new_id = egraph.add(new_node);
                // Union to current eclass
                if egraph.union_trusted(new_id, eclass, rule_name) {
                    changed.push(egraph.find(new_id));
                }
            }
        }

        changed
    }
}

pub fn flatten_only<N>(op_str: &str) -> Rewrite<SymbolLang, N>
where
    N: Analysis<SymbolLang> + 'static,
{
    Rewrite::new(
        format!("flatten-only-{}", op_str),
        FlattenOnly { op: op_str.into() },
        FlattenOnly { op: op_str.into() },
    ).unwrap()
}


// =======================
// replace(?p, ?r, ?t) rule
// Rewrite (replace p r t) to t[p := r], only do structural matching replacement in the t tree
// =======================

#[derive(Clone, Debug)]
struct ReplaceApplierByClass {
    p: Var, // ?p
    r: Var, // ?r
    t: Var, // ?t
}

impl<N: Analysis<SymbolLang>> Applier<SymbolLang, N> for ReplaceApplierByClass {
    fn apply_one(
        &self,
        eg: &mut EGraph<SymbolLang, N>,
        matched_id: Id,              // e-class where (replace ?p ?r ?t) is located
        subst: &Subst,
        _searcher_ast: Option<&PatternAst<SymbolLang>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        // Directly get "class" at e-graph level
        let p_cls = eg.find(subst[self.p]); // Class to be replaced
        let r_cls = eg.find(subst[self.r]); // Use this class to replace (entire class, not representative expression)
        let t_id  = eg.find(subst[self.t]); // Root being replaced

        // Use your existing class-level copy + replacement
        let mut memo     = HashMap::default();
        let mut visiting = HashSet::default();
        let new_root = clone_with_subst(eg, t_id, p_cls, r_cls, &mut memo, &mut visiting);

        // "No hit = identity": if new_root and t are already equivalent, then (replace ... ) ≡ ?t
        let new_c = eg.find(new_root);
        let old_c = eg.find(t_id);

        let target = if new_c == old_c { old_c } else { new_c };
        let did = eg.union_trusted(matched_id, target, rule_name);

        if did { vec![eg.find(target)] } else { vec![] }
    }

    fn vars(&self) -> Vec<Var> { vec![self.p, self.r, self.t] }
}

pub fn replace_rule<N>() -> Rewrite<SymbolLang, N>
where
    N: Analysis<SymbolLang> + 'static,
{
    let pat: Pattern<SymbolLang> = "(replace ?p ?r ?t)".parse().unwrap();
    Rewrite::new(
        "replace-eclass",
        pat,
        ReplaceApplierByClass {
            p: "?p".parse().unwrap(),
            r: "?r".parse().unwrap(),
            t: "?t".parse().unwrap(),
        },
    ).unwrap()
}


// —— Tool 1: Find a leaf like "...forargN" in an eclass and construct N-1 —— //
// Returns the Id of the new leaf (eg.add will automatically reuse existing eclass)
fn dec_forarg_leaf_in_class<N: Analysis<SymbolLang>>(
    eg: &mut EGraph<SymbolLang, N>,
    d_cls: Id,
) -> Option<Id> {
    let cid = eg.find(d_cls);
    for n in &eg[cid].nodes {
        if !n.children().is_empty() { continue; }
        let s = n.to_string();                  // e.g. "variable%forarg5" or "%forarg5"
        if let Some(pos) = s.rfind("forarg") {
            let digits_start = pos + "forarg".len();
            let mut digits_end = digits_start;
            while digits_end < s.len() && s.as_bytes()[digits_end].is_ascii_digit() {
                digits_end += 1;
            }
            if digits_end == digits_start { continue; } // No digits
            let n_str = &s[digits_start..digits_end];
            if let Ok(n_val) = n_str.parse::<usize>() {
                if n_val == 0 { return None; }
                let next = format!("{}{}{}", &s[..digits_start], n_val - 1, &s[digits_end..]);
                return Some(eg.add(SymbolLang::leaf(&next)));
            }
        }
    }
    None
}

// —— Tool 2: Collect all forcontrol "classes" in t's reachable subgraph, sorted from outer to inner —— //
fn collect_fc_classes_outer_to_inner<N: Analysis<SymbolLang>>(
    eg: &EGraph<SymbolLang, N>,
    root: Id,
) -> Vec<(Id, usize)> {
    let mut out: Vec<(Id, usize)> = Vec::new();
    let mut visited: HashSet<Id> = HashSet::default();
    let mut q: VecDeque<(Id, usize)> = VecDeque::new();

    let root = eg.find(root);
    q.push_back((root, 0));
    visited.insert(root);

    let sym_fc = Symbol::from("forcontrol");

    while let Some((cid, d)) = q.pop_front() {
        // If this class has appeared forcontrol enode, record it (outer layer d is smaller)
        if eg[cid].nodes.iter().any(|n| n.op == sym_fc && n.children().len() == 2) {
            out.push((cid, d));
        }
        // Push downstream: traverse all child eclasses of all enodes in this class
        for n in &eg[cid].nodes {
            for &ch in n.children() {
                let cc = eg.find(ch);
                if visited.insert(cc) {
                    q.push_back((cc, d + 1));
                }
            }
        }
    }

    // Outer→inner: depth ascending order
    out.sort_by_key(|&(_, d)| d);
    out
}

// ===========================
// replacereducevariable(?p ?r ?t)
// Step1: t[p:=r] (by e-class)
// Step2: In all forcontrol in t₁, do (forargN -> forargN-1) and do a local replacement (fv -> fv') in each body (outer→inner order)
// ===========================
#[derive(Clone, Debug)]
struct ReplaceReduceVarApplier {
    p: Var, // ?p
    r: Var, // ?r
    t: Var, // ?t
}

impl<N: Analysis<SymbolLang>> Applier<SymbolLang, N> for ReplaceReduceVarApplier {
    fn apply_one(
        &self,
        eg: &mut EGraph<SymbolLang, N>,
        matched_id: Id, // eclass where (replacereducevariable ?p ?r ?t) is located
        subst: &Subst,
        _searcher_ast: Option<&PatternAst<SymbolLang>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        // Get the "classes" where the three are located
        let p_cls = eg.find(subst[self.p]);
        let r_cls = eg.find(subst[self.r]);
        let t_id  = eg.find(subst[self.t]);

        // ---- Step 1: class-level replacement (same as replace) ----
        let mut memo = HashMap::default();
        let mut visiting = HashSet::default();
        let mut root_cur = clone_with_subst(eg, t_id, p_cls, r_cls, &mut memo, &mut visiting);

        let changed_step1 = eg.find(root_cur) != eg.find(t_id);

        // ---- Step 2: Do "variable minus 1 + local replacement" on all forcontrol in root_cur, outer→inner ----
        let fc_list = collect_fc_classes_outer_to_inner(eg, root_cur);
        let sym_block = Symbol::from("block");

        let mut changed_step2 = false;

        for (fc_cls, _depth) in fc_list {
            // Do a single-point replacement based on "current root" to avoid mutual interference
            // 1) Decompose forcontrol
            let (fv_id, body_id) = match decompose_forcontrol(eg, fc_cls) {
                Some(x) => x,
                None => continue, // This class is marked as forcontrol but didn't get the shape, skip
            };

            // body must be block (class has appeared block enode is sufficient)
            if !eg[eg.find(body_id)].nodes.iter().any(|n| n.op == sym_block) {
                continue;
            }

            // 2) Decompose forvalue, get (a,b,c,d)
            let (a, b, c, d) = match decompose_forvalue(eg, fv_id) {
                Some(x) => x,
                None => continue,
            };

            // 3) d must be forargN (N>0), construct d' = forarg(N-1)
            let d_prime = match dec_forarg_leaf_in_class(eg, d) {
                Some(x) => x,
                None => continue, // No forargN or N==0
            };

            // 4) Construct fv', and locally replace fv -> fv' in body
            let fv_prime = eg.add(SymbolLang::new("forvalue", vec![a, b, c, d_prime]));

            let mut memo_body = HashMap::default();
            let mut visiting2 = HashSet::default();
            let body_prime = clone_with_subst(eg, body_id, fv_id, fv_prime, &mut memo_body, &mut visiting2);

            // 5) Assemble fc', and replace fc class with fc' in "current root"
            let fc_prime = eg.add(SymbolLang::new("forcontrol", vec![fv_prime, body_prime]));

            let mut memo_root = HashMap::default();
            let mut visiting3 = HashSet::default();
            let next_root = clone_with_subst(eg, root_cur, fc_cls, fc_prime, &mut memo_root, &mut visiting3);

            if eg.find(next_root) != eg.find(root_cur) {
                root_cur = next_root;
                changed_step2 = true;
            }
        }

        // ---- Write back: if step1/step2 haven't changed, then replacereducevariable ≡ ?t; otherwise ≡ root_cur ----
        let target = if !changed_step1 && !changed_step2 { eg.find(t_id) } else { eg.find(root_cur) };
        let did = eg.union_trusted(matched_id, target, rule_name);

        if did { vec![eg.find(target)] } else { vec![] }
    }

    fn vars(&self) -> Vec<Var> { vec![self.p, self.r, self.t] }
}

// Factory
pub fn replacereducevariable_rule<N>() -> Rewrite<SymbolLang, N>
where
    N: Analysis<SymbolLang> + 'static,
{
    Rewrite::new(
        "replacereducevariable",
        "(replacereducevariable ?p ?r ?t)".parse::<Pattern<SymbolLang>>().unwrap(),
        ReplaceReduceVarApplier {
            p: "?p".parse().unwrap(),
            r: "?r".parse().unwrap(),
            t: "?t".parse().unwrap(),
        },
    ).unwrap()
}

#[derive(Clone)]
pub struct CancelNaryApplier {
    /// e.g. "+" or "*"
    pub flat: Symbol,
    /// e.g. "-" or "/"
    pub cancel: Symbol,
    /// Identity element used when minuend/dividend is "emptied" (+→"0", *→"1"). If none, don't generate empty head.
    pub flat_identity_if_empty: Option<Symbol>,
}

impl<N: Analysis<SymbolLang>> Applier<SymbolLang, N> for CancelNaryApplier {
    fn apply_one(
        &self,
        egraph: &mut EGraph<SymbolLang, N>,
        matched_id: Id,
        _subst: &Subst,
        _searcher_ast: Option<&PatternAst<SymbolLang>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        // Snapshot to avoid borrowing conflicts
        let nodes_snapshot = egraph[matched_id].nodes.clone();

        // Find nodes like (cancel (flat ...) tail...) in the current equivalence class
        for node in &nodes_snapshot {
            if node.op != self.cancel { continue; }
            let ch = node.children();
            if ch.len() < 2 { continue; }

            let head_id = egraph.find(ch[0]);
            let tail_ids: Vec<Id> = ch[1..].iter().map(|&x| egraph.find(x)).collect();

            // Find a (flat …) head
            let maybe_flat = egraph[head_id].nodes.iter().find(|n| n.op == self.flat).cloned();
            let flat_node = match maybe_flat { Some(n) => n, None => continue };

            // Normalize head's children list
            let head_children: Vec<Id> =
                flat_node.children().iter().map(|&c| egraph.find(c)).collect();

            // Count the multiset of tail to be deleted
            use std::collections::HashMap;
            let mut need_rm: HashMap<Id, usize> = HashMap::default();
            for t in &tail_ids {
                *need_rm.entry(*t).or_insert(0) += 1;
            }

            // Calculate "unmatched" tail (not found in head)
            let mut need_rm_left = need_rm.clone();

            // Delete from head_children in original order
            let mut new_head_children = Vec::with_capacity(head_children.len());
            for &c in &head_children {
                if let Some(cnt) = need_rm_left.get_mut(&c) {
                    if *cnt > 0 {
                        *cnt -= 1; // Delete once
                        continue;
                    }
                }
                new_head_children.push(c);
            }

            // Collect tail that hasn't been deleted (those that didn't appear in head)
            let mut leftover_tail = Vec::new();
            for (id, mut k) in need_rm_left {
                while k > 0 {
                    leftover_tail.push(id);
                    k -= 1;
                }
            }

            // Construct new head
            let new_head_id: Option<Id> = match new_head_children.len() {
                0 => {
                    if let Some(id_sym) = self.flat_identity_if_empty {
                        Some(egraph.add(SymbolLang::leaf(id_sym.as_str())))
                    } else {
                        // No identity element, give up this transformation
                        None
                    }
                }
                1 => Some(new_head_children[0]),
                _ => Some(egraph.add(SymbolLang::new(self.flat.as_str(), new_head_children))),
            };

            if let Some(hid) = new_head_id {
                // If there are remaining tail, keep cancel; otherwise use new_head directly
                let new_id = if leftover_tail.is_empty() {
                    hid
                } else {
                    let mut ch = Vec::with_capacity(1 + leftover_tail.len());
                    ch.push(hid);
                    ch.extend(leftover_tail);
                    egraph.add(SymbolLang::new(self.cancel.as_str(), ch))
                };
                if egraph.union_trusted(matched_id, new_id, rule_name) {
                    return vec![egraph.find(new_id)];
                }
            }
        }

        vec![]
    }
}

/// Factory: generate rewrite "do n-ary cancellation on flat"
pub fn cancel_pair<N>(
    flat: &str,
    cancel: &str,
    id_if_empty_flat: Option<&str>, // "+"→Some("0"), "*"→Some("1")
) -> Rewrite<SymbolLang, N>
where
    N: Analysis<SymbolLang>,
{
    Rewrite::new(
        format!("cancel-nary-over-{}-{}", flat, cancel),
        // Use wildcard pattern to match any eclass; real filtering is done in applier
        "?r".parse::<Pattern<SymbolLang>>().unwrap(),
        CancelNaryApplier {
            flat: Symbol::from(flat),
            cancel: Symbol::from(cancel),
            flat_identity_if_empty: id_if_empty_flat.map(Symbol::from),
        },
    )
    .unwrap()
}


// ======================= New: Z3 verification module (can be placed anywhere in rewrite.rs, usually at the end) =======================
pub fn verify_unroll_with_z3_k<N: Analysis<SymbolLang>>(
    egraph: &EGraph<SymbolLang, N>,
    a1: Id,  // Start point
    k:  Id,  // k = b1 = a2
    c1: Id,  // Step size 1
    b2: Id,  // Right segment end point
    c2: Id,  // Step size 2
) -> bool {
    use z3::{ast::{Ast, Bool, Int}, Config, Context, SatResult, Solver};

    // —— helpers —— //
    fn addn<'ctx>(ctx: &'ctx Context, terms: &[Int<'ctx>]) -> Int<'ctx> {
        let refs: Vec<&Int<'ctx>> = terms.iter().collect();
        Int::add(ctx, &refs)
    }
    fn ceildiv<'ctx>(ctx: &'ctx Context, x: &Int<'ctx>, y: &Int<'ctx>) -> Int<'ctx> {
        let one = Int::from_i64(ctx, 1);
        let y_minus_1 = Int::sub(ctx, &[y, &one]);
        let x_plus     = Int::add(ctx, &[x, &y_minus_1]);
        Int::div(&x_plus, y)
    }
    fn relu<'ctx>(ctx: &'ctx Context, x: &Int<'ctx>) -> Int<'ctx> {
        let zero = Int::from_i64(ctx, 0);
        x.ge(&zero).ite(x, &zero)
    }

    // —— Get ASTSize best representative (if it's an integer constant, return the constant directly) —— //
    fn best_const_i64_in_class<N: Analysis<SymbolLang>>(eg: &EGraph<SymbolLang, N>, id: Id) -> Option<i64> {
        let ex = Extractor::new(eg, AstSize);
        let (_, expr) = ex.find_best(id);
        expr.to_string().parse::<i64>().ok()
    }
    fn z3_int_from_best_or_sym<'ctx, N: Analysis<SymbolLang>>(
        ctx: &'ctx Context, eg: &EGraph<SymbolLang, N>, id: Id, sym: &str
    ) -> Int<'ctx> {
        if let Some(v) = best_const_i64_in_class(eg, id) {
            Int::from_i64(ctx, v)
        } else {
            Int::new_const(ctx, sym)
        }
    }

    // —— Z3 ctx —— //
    let mut cfg = Config::new();
    cfg.set_model_generation(true);
    let ctx    = Context::new(&cfg);
    let solver = Solver::new(&ctx);

    // Use "best representative" to generate variables/constants
    let a1z = z3_int_from_best_or_sym(&ctx, egraph, a1, "a1");
    let kz  = z3_int_from_best_or_sym(&ctx, egraph, k,  "k");
    let c1z = z3_int_from_best_or_sym(&ctx, egraph, c1, "c1");
    let b2z = z3_int_from_best_or_sym(&ctx, egraph, b2, "b2");
    let c2z = z3_int_from_best_or_sym(&ctx, egraph, c2, "c2");

    // Constraint domain
    let zero = Int::from_i64(&ctx, 0);
    solver.assert(&c1z.gt(&zero));
    solver.assert(&c2z.gt(&zero));
    // c1 = q * c2, q >= 1
    let q = Int::new_const(&ctx, "q");
    solver.assert(&c1z._eq(&Int::mul(&ctx, &[&q, &c2z])));
    solver.assert(&q.ge(&Int::from_i64(&ctx, 1)));
    // Monotonic direction: k >= a1, b2 >= k
    solver.assert(&kz.ge(&a1z));
    solver.assert(&b2z.ge(&kz));
    // First segment boundary alignment: ∃m>=0, k = a1 + m*c1
    let m = Int::new_const(&ctx, "m");
    solver.assert(&m.ge(&zero));
    solver.assert(&kz._eq(&Int::add(&ctx, &[&a1z, &Int::mul(&ctx, &[&m, &c1z])])));

    // Goal: relu(ceil((k-a1)/c1))*(c1/c2) + relu(ceil((b2-k)/c2)) == relu(ceil((b2-a1)/c2))
    let t1 = relu(&ctx, &ceildiv(&ctx, &Int::sub(&ctx, &[&kz, &a1z]), &c1z));
    let c1_div_c2 = Int::div(&c1z, &c2z);
    let t1_mul = Int::mul(&ctx, &[&t1, &c1_div_c2]);

    let t2 = relu(&ctx, &ceildiv(&ctx, &Int::sub(&ctx, &[&b2z, &kz]), &c2z));

    let lhs = addn(&ctx, &[t1_mul, t2]);
    let rhs = relu(&ctx, &ceildiv(&ctx, &Int::sub(&ctx, &[&b2z, &a1z]), &c2z));
    let eq: Bool = lhs._eq(&rhs);

    // Counterexample search: unsat(¬eq) means identity holds
    solver.assert(&eq.not());
    match solver.check() {
        SatResult::Unsat => true,
        _ => false,
    }
}




#[derive(Clone)]
pub struct CancelInsideFlatApplier {
    pub flat: Symbol,
    pub cancel: Symbol,
    pub flat_identity_if_empty: Option<Symbol>,
}

impl<N: Analysis<SymbolLang>> Applier<SymbolLang, N> for CancelInsideFlatApplier {
    fn apply_one(
        &self,
        egraph: &mut EGraph<SymbolLang, N>,
        matched_id: Id,
        _subst: &Subst,
        _searcher_ast: Option<&PatternAst<SymbolLang>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        let nodes_snapshot = egraph[matched_id].nodes.clone();

        'try_all_nodes: for flat_node in nodes_snapshot {
            if flat_node.op != self.flat { continue; }
            let flat_children_orig: Vec<Id> = flat_node.children().to_vec();
            if flat_children_orig.len() < 2 { continue; }
            let child_cids: Vec<Id> = flat_children_orig
                .iter()
                .map(|&id| egraph.find(id))
                .collect();

            for (i, &ci) in child_cids.iter().enumerate() {
                let cancel_cands: Vec<_> = egraph[ci].nodes
                    .iter()
                    .filter(|n| n.op == self.cancel)
                    .cloned()
                    .collect();
                if cancel_cands.is_empty() { continue; }

                let siblings_except_i: Vec<(usize, Id)> = child_cids
                    .iter()
                    .enumerate()
                    .filter(|(j, _)| *j != i)
                    .map(|(j, &cid)| (j, cid))
                    .collect();

                for cancel_node in cancel_cands {
                    let cch = cancel_node.children().to_vec();
                    if cch.len() < 2 { continue; }
                    let head_cid = egraph.find(cch[0]);
                    let mut tails_cids: Vec<Id> = cch[1..].iter().map(|&x| egraph.find(x)).collect();

                    let mut use_sibling_j: Option<usize> = None;
                    if !tails_cids.is_empty() {
                        'find_pair: for (j, sib_cid) in siblings_except_i.iter() {
                            if let Some(pos) = tails_cids.iter().position(|t| *t == *sib_cid) {
                                // Remove one matching item from tails
                                tails_cids.remove(pos);
                                use_sibling_j = Some(*j);
                                break 'find_pair;
                            }
                        }
                    }
                    if use_sibling_j.is_none() {
                        continue;
                    }
                    let j_remove = use_sibling_j.unwrap();
                    let new_cancel_id: Id = if tails_cids.is_empty() {
                        head_cid
                    } else {
                        let mut ch = Vec::with_capacity(1 + tails_cids.len());
                        ch.push(head_cid);
                        ch.extend(tails_cids);
                        egraph.add(SymbolLang::new(self.cancel.as_str(), ch))
                    };

                    let mut new_flat_children: Vec<Id> = Vec::with_capacity(flat_children_orig.len());
                    for (idx, &orig_child) in flat_children_orig.iter().enumerate() {
                        if idx == i {
                            new_flat_children.push(new_cancel_id);
                        } else if idx == j_remove {
                        } else {
                            new_flat_children.push(egraph.find(orig_child));
                        }
                    }

                    let new_id: Id = match new_flat_children.len() {
                        0 => {
                            if let Some(id_sym) = self.flat_identity_if_empty {
                                egraph.add(SymbolLang::leaf(id_sym.as_str()))
                            } else {
                                continue 'try_all_nodes;
                            }
                        }
                        1 => new_flat_children[0],
                        _ => egraph.add(SymbolLang::new(self.flat.as_str(), new_flat_children)),
                    };

                    if egraph.union_trusted(matched_id, new_id, rule_name) {
                        return vec![egraph.find(new_id)];
                    }
                } // end for cancel_cands
            } // end for each child
        } // end for nodes_snapshot

        vec![]
    }
}

pub fn cancel_inside_flat<N>(
    flat: &str,
    cancel: &str,
    id_if_empty_flat: Option<&str>,
) -> Rewrite<SymbolLang, N>
where
    N: Analysis<SymbolLang>,
{
    Rewrite::new(
        format!("cancel-inside-flat-{}-{}", flat, cancel),
        "?r".parse::<Pattern<SymbolLang>>().unwrap(),
        CancelInsideFlatApplier {
            flat: Symbol::from(flat),
            cancel: Symbol::from(cancel),
            flat_identity_if_empty: id_if_empty_flat.map(Symbol::from),
        },
    )
    .unwrap()
}

fn sym(s: &str) -> Symbol { Symbol::from(s) }

// Find an enode with op=target in eclass
fn find_node_with_op<N: Analysis<SymbolLang>>(
    eg: &EGraph<SymbolLang, N>,
    id: Id,
    op: &str,
) -> Option<SymbolLang> {
    let cid = eg.find(id);
    let want = sym(op);
    eg[cid].nodes.iter().find(|n| n.op == want).cloned()
}

fn decompose_forcontrol<N: Analysis<SymbolLang>>(
    eg: &EGraph<SymbolLang, N>,
    id: Id,
) -> Option<(Id, Id)> {
    let n = find_node_with_op(eg, id, "forcontrol")?;
    let ch = n.children();
    if ch.len() == 2 { Some((ch[0], ch[1])) } else { None }
}

fn decompose_forvalue<N: Analysis<SymbolLang>>(
    eg: &EGraph<SymbolLang, N>,
    id: Id,
) -> Option<(Id, Id, Id, Id)> {
    let n = find_node_with_op(eg, id, "forvalue")?;
    let ch = n.children();
    if ch.len() == 4 { Some((ch[0], ch[1], ch[2], ch[3])) } else { None }
}

fn block_children<N: Analysis<SymbolLang>>(
    eg: &EGraph<SymbolLang, N>,
    id: Id,
) -> Option<Vec<Id>> {
    let n = find_node_with_op(eg, id, "block")?;
    Some(n.children().to_vec())
}

// Find an integer leaf in an equivalence class
fn as_i64_in_class<N: Analysis<SymbolLang>>(
    eg: &EGraph<SymbolLang, N>,
    id: Id,
) -> Option<i64> {
    let cid = eg.find(id);
    for n in &eg[cid].nodes {
        if n.children().is_empty() {
            // For SymbolLang, leaf to_string() is the original symbol string
            let s = n.to_string();
            if let Ok(v) = s.parse::<i64>() {
                return Some(v);
            }
        }
    }
    None
}

fn leaf_i<N: Analysis<SymbolLang>>(eg: &mut EGraph<SymbolLang, N>, k: i64) -> Id {
    eg.add(SymbolLang::leaf(&k.to_string()))
}
fn mk_op<N: Analysis<SymbolLang>>(eg: &mut EGraph<SymbolLang, N>, op: &str, ch: Vec<Id>) -> Id {
    eg.add(SymbolLang::new(op, ch))
}
fn mk_add<N: Analysis<SymbolLang>>(eg: &mut EGraph<SymbolLang, N>, x: Id, y: Id) -> Id {
    mk_op(eg, "+", vec![x, y])
}
fn mk_mul<N: Analysis<SymbolLang>>(eg: &mut EGraph<SymbolLang, N>, x: Id, y: Id) -> Id {
    mk_op(eg, "*", vec![x, y])
}

// Deep copy with replacement: if root and from are in the same eclass => return to; otherwise recursively clone by representative enode
fn clone_with_subst<N: Analysis<SymbolLang>>(
    eg: &mut EGraph<SymbolLang, N>,
    root: Id,
    from_cls: Id,
    to_id: Id,
    memo: &mut HashMap<Id, Id>,
    visiting: &mut HashSet<Id>,
) -> Id {
    let cid = eg.find(root);
    let from_cls = eg.find(from_cls);

    // Hit replacement point: entire subtree becomes to_id
    if cid == from_cls {
        return to_id;
    }

    // Memoization
    if let Some(&ans) = memo.get(&cid) {
        return ans;
    }

    // Detect self-loop: if this class is in the "stack", return the class itself directly to avoid deep recursion
    if !visiting.insert(cid) {
        return cid;
    }

    // Prefer to pick a "non-self-loop" enode (all children are not equal to cid)
    let pick = eg[cid]
        .nodes
        .iter()
        .find(|n| n.children().iter().all(|&ch| eg.find(ch) != cid))
        .cloned()
        // If not, can only choose the first one; visited will catch up
        .unwrap_or_else(|| eg[cid].nodes[0].clone());

    // Recursively clone children
    let mut new_children: Vec<Id> = Vec::with_capacity(pick.children().len());
    for &ch in pick.children() {
        let sub = clone_with_subst(eg, ch, from_cls, to_id, memo, visiting);
        new_children.push(sub);
    }

    // Build new node
    let new_id = eg.add(SymbolLang::new(pick.op.as_str(), new_children));

    visiting.remove(&cid);
    memo.insert(cid, new_id);
    new_id
}


#[derive(Clone, Debug, Default)]
pub struct TilingApplier;

// Parse "variable%forargN" -> N
fn parse_forarg_index_in_class<N: Analysis<SymbolLang>>(
    eg: &EGraph<SymbolLang, N>,
    id: Id,
) -> Option<usize> {
    let cid = eg.find(id);
    for n in &eg[cid].nodes {
        if n.children().is_empty() {
            let s = n.to_string();
            if let Some(rest) = s.strip_prefix("variable%forarg") {
                if let Ok(k) = rest.parse::<usize>() {
                    return Some(k);
                }
            }
        }
    }
    None
}

// Recursively do "N -> N-1" reduction on all forcontrol loop-vars in t subtree;
// Outer to inner order: first modify header, then recursively process block, and before entering block, fully replace old var's e-class with new var's e-class.
fn lower_fc_vars<N: Analysis<SymbolLang>>(
    eg: &mut EGraph<SymbolLang, N>,
    root: Id,
    visiting: &mut HashSet<Id>,
) -> Id {
    let cid = eg.find(root);
    if !visiting.insert(cid) {
        // Back edge appears: return class itself directly to avoid infinite recursion
        return cid;
    }

    // If this class has a forcontrol, use it as representative to do "reduce by one"
    if let Some(fc) = eg[cid].nodes.iter().find(|n| n.op == Symbol::from("forcontrol") && n.children().len() == 2).cloned() {
        let fv = fc.children()[0];
        let body = fc.children()[1];

        let (a,b,c,d) = decompose_forvalue(eg, fv)
            .expect("forcontrol header should be (forvalue ...) with 4 children");

        let n = parse_forarg_index_in_class(eg, d)
            .expect("loop var must be variable%forargN");
        assert!(n > 0, "cannot lower variable%forarg0");

        // d' = variable%forarg(N-1), if already exists will automatically reuse (egraph.add is hashcons)
        let d1 = eg.add(SymbolLang::leaf(&format!("variable%forarg{}", n - 1)));
        let fv1 = eg.add(SymbolLang::new("forvalue", vec![a, b, c, d1]));

        // First fully replace references to d in body with d' (class-level replacement)
        let mut memo = HashMap::default();
        let mut vis2 = HashSet::default();
        let body_substed = clone_with_subst(eg, body, d, d1, &mut memo, &mut vis2);

        // Then on the replaced body, continue inward "reduce by one"
        let body_lowered = lower_fc_vars(eg, body_substed, visiting);

        let fc_new = eg.add(SymbolLang::new("forcontrol", vec![fv1, body_lowered]));
        visiting.remove(&cid);
        return fc_new;
    }

    // Otherwise: not forcontrol. Pick a representative enode that's as "non-self-loop" as possible, recursively rewrite each child (this way can find deeper fc)
    let pick = eg[cid]
        .nodes
        .iter()
        .find(|n| n.children().iter().all(|&ch| eg.find(ch) != cid))
        .cloned()
        .unwrap_or_else(|| eg[cid].nodes[0].clone());

    if pick.children().is_empty() {
        visiting.remove(&cid);
        return cid;
    }

    let mut new_children: Vec<Id> = Vec::with_capacity(pick.children().len());
    for &ch in pick.children() {
        let lowered = lower_fc_vars(eg, ch, visiting);
        new_children.push(lowered);
    }

    let rebuilt = eg.add(SymbolLang::new(pick.op.as_str(), new_children));
    visiting.remove(&cid);
    rebuilt
}

impl<N: Analysis<SymbolLang>> Applier<SymbolLang, N> for TilingApplier {
    fn apply_one(
        &self,
        eg: &mut EGraph<SymbolLang, N>,
        matched_id: Id,                // e-class where the entire LHS forcontrol is located
        subst: &Subst,                 // bound ?a ?b ?c ?d ?e ?f
        _searcher_ast: Option<&PatternAst<SymbolLang>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        let a: Var = "?a".parse().unwrap();
        let b: Var = "?b".parse().unwrap();
        let c: Var = "?c".parse().unwrap();
        let d: Var = "?d".parse().unwrap();
        let e: Var = "?e".parse().unwrap();
        let f: Var = "?f".parse().unwrap();

        let a = eg.find(subst[a]);
        let b = eg.find(subst[b]);
        let c = eg.find(subst[c]);
        let d = eg.find(subst[d]);
        let e = eg.find(subst[e]);
        let f = eg.find(subst[f]);

        // —— Construct p = (forvalue (forvalue a b c d) (min (+ c (forvalue a b c d)) b) 1 e)
        let fv_abcd   = eg.add(SymbolLang::new("forvalue", vec![a, b, c, d]));
        let plus_c_fv = eg.add(SymbolLang::new("+",        vec![c, fv_abcd]));
        let min_term  = eg.add(SymbolLang::new("min",      vec![plus_c_fv, b]));
        let one       = eg.add(SymbolLang::leaf("1"));
        let p_id      = eg.add(SymbolLang::new("forvalue", vec![fv_abcd, min_term, one, e]));

        // —— Construct r = (forvalue a b 1 d)
        let r_id = eg.add(SymbolLang::new("forvalue", vec![
            a, b, one, d
        ]));

        // Step 1: Do class-level replacement p → r in the f subtree
        let mut memo = HashMap::default();
        let mut visiting = HashSet::default();
        let f_replaced = clone_with_subst(eg, f, p_id, r_id, &mut memo, &mut visiting);

        // Step 2: Do "variable%forargN → N-1" on all forcontrol loop-vars in f_replaced,
        // and fully replace places in corresponding block that use this var with new var (done by lower_fc_vars)
        let mut vis3 = HashSet::default();
        let f_lowered = lower_fc_vars(eg, f_replaced, &mut vis3);

        // Outer header should also become (forvalue a b 1 d)
        let outer_fv = r_id; // which is (a,b,1,d)
        let new_fc   = eg.add(SymbolLang::new("forcontrol", vec![outer_fv, f_lowered]));

        // Union with original matched eclass
        if eg.union_trusted(matched_id, new_fc, rule_name) {
            vec![eg.find(new_fc)]
        } else {
            vec![]
        }
    }
}

// Rule factory: use original search pattern (LHS), but RHS uses our TilingApplier
pub fn tiling_rule_in_applier<N>() -> Rewrite<SymbolLang, N>
where
    N: Analysis<SymbolLang> + 'static,
{
    let lhs: Pattern<SymbolLang> = "(forcontrol
        (forvalue ?a ?b ?c ?d)
        (block
          (forcontrol
            (forvalue
              (forvalue ?a ?b ?c ?d)
              (min (+ ?c (forvalue ?a ?b ?c ?d)) ?b)
              1
              ?e)
            ?f)))".parse().unwrap();

    Rewrite::new("tiling-integrated", lhs, TilingApplier::default()).unwrap()
}


#[derive(Clone, Debug)]
pub struct UnrollAdjacentApplier;

impl<N: Analysis<SymbolLang>> Applier<SymbolLang, N> for UnrollAdjacentApplier {
    fn apply_one(
        &self,
        eg: &mut EGraph<SymbolLang, N>,
        matched_id: Id,                // eclass where matched block is located (searched with "?r")
        _subst: &Subst,
        _searcher_ast: Option<&PatternAst<SymbolLang>>,
        rule_name: Symbol,
    ) -> Vec<Id> {
        let nodes_snapshot = eg[matched_id].nodes.clone();

        'each_block: for node in nodes_snapshot {
            if node.op != Symbol::from("block") { continue; }
            let ch = node.children().to_vec();
            if ch.len() < 2 { continue; }

            for i in 0..(ch.len() - 1) {
                let c1_id = eg.find(ch[i]);
                let c2_id = eg.find(ch[i + 1]);

                // Must be forcontrol
                let (fv1, body1) = match decompose_forcontrol(eg, c1_id) { Some(x) => x, None => continue };
                let (fv2, body2) = match decompose_forcontrol(eg, c2_id) { Some(x) => x, None => continue };

                // header: (a1, b1, c1, d1) / (a2, b2, c2, d2)
                let (a1, b1, c1, d1)   = match decompose_forvalue(eg, fv1) { Some(x) => x, None => continue };
                let (a2, b2, c2, _d2)  = match decompose_forvalue(eg, fv2) { Some(x) => x, None => continue };

                // Step 0: First check equality —— b1 and a2 must be in the same eclass
                if eg.find(b1) != eg.find(a2) { continue; }

                // Both bodies must be (can get) block
                let seq1 = match block_children(eg, body1) { Some(v) => v, None => continue };
                let seq2 = match block_children(eg, body2) { Some(v) => v, None => continue };
                if seq2.is_empty() { continue; }

                // Step 1: Strict structural matching (consistent with old merge)
                let c1v = match as_i64_in_class(eg, c1) { Some(v) if v > 0 => v, _ => continue };
                let c2v = match as_i64_in_class(eg, c2) { Some(v) if v > 0 => v, _ => continue };
                if c1v % c2v != 0 { continue; }
                let r = (c1v / c2v) as usize;
                if seq1.len() != r * seq2.len() { continue; }

                // Segment-by-segment equivalence (replace fv2 -> fv1 + j*c2)
                let c2_leaf = leaf_i(eg, c2v);
                let len2 = seq2.len();
                for j in 0..r {
                    let off_j = if j == 0 {
                        fv1
                    } else {
                        let j_leaf = leaf_i(eg, j as i64);
                        let mul    = mk_mul(eg, j_leaf, c2_leaf);
                        mk_add(eg, fv1, mul)
                    };
                    for k in 0..len2 {
                        let idx1   = j * len2 + k;
                        let target = seq1[idx1];

                        let mut memo = HashMap::default();
                        let mut visiting = HashSet::default();
                        let built = clone_with_subst(eg, seq2[k], fv2, off_j, &mut memo, &mut visiting);

                        if eg.find(built) != eg.find(target) {
                            // Structure doesn't match, try next pair
                            continue 'each_block;
                        }
                    }
                }

                // Step 2: After structure is OK, finally call Z3 for arithmetic identity verification (using k = b1 = a2)
                if !verify_unroll_with_z3_k(eg, a1, b1, c1, b2, c2) {
                    continue;
                }

                // Step 3: Pass —— directly construct merged fc3, replace adjacent two in block
                let fv3   = mk_op(eg, "forvalue", vec![a1, b2, c2, d1]);
                let mut new_children_body = Vec::with_capacity(seq2.len());
                for &op in &seq2 {
                    let mut memo = HashMap::default();
                    let mut visiting = HashSet::default();
                    let new_op = clone_with_subst(eg, op, fv2, fv3, &mut memo, &mut visiting);
                    new_children_body.push(new_op);
                }
                let body3 = mk_op(eg, "block", new_children_body);
                let fc3   = mk_op(eg, "forcontrol", vec![fv3, body3]);

                let mut new_children_block = Vec::with_capacity(ch.len() - 1);
                new_children_block.extend_from_slice(&ch[..i]);
                new_children_block.push(fc3);
                new_children_block.extend_from_slice(&ch[i + 2..]);

                let new_block = eg.add(SymbolLang::new("block", new_children_block));
                if eg.union_trusted(matched_id, new_block, rule_name) {
                    return vec![eg.find(new_block)];
                } else {
                    continue 'each_block;
                }
            }
        }

        vec![]
    }
}

pub fn unroll_two_adjacent_rule<N>() -> Rewrite<SymbolLang, N>
where
    N: Analysis<SymbolLang> + 'static,
{
    Rewrite::new(
        "unroll-two-adjacent",
        "?r".parse::<Pattern<SymbolLang>>().unwrap(), // Let applier filter block itself
        UnrollAdjacentApplier,
    ).unwrap()
}
