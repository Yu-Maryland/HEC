use egg::*;
use egg::rewrite::{
    cancel_inside_flat, cancel_pair, commutative, const_folding_rewrites, flatten_only,
    tiling_rule_in_applier, unroll_two_adjacent_rule,
};
use log::{error, info};
use std::io::{self, BufRead, BufReader};
use std::time::Instant;

fn init_logging() {
    let _ = env_logger::Builder::from_env(
        env_logger::Env::default().default_filter_or("info")
    )
    .format_timestamp_millis()
    .try_init();
}



pub fn divmod_rewrites<N>() -> Vec<Rewrite<SymbolLang, N>>
where
    N: Analysis<SymbolLang> + Default,
{
    let rs: Vec<Rewrite<SymbolLang, N>> = vec![
        // 1) b*floor(a/b)+mod(a,b)  ≡  a
        rewrite!(
            "euclid-def";
            "(+ (* (floordiv ?a ?b) ?b) (mod ?a ?b))" => "?a"
        ),

        rewrite!(
            "mod-idempotent";
            "(mod (mod ?x ?m) ?m)" => "(mod ?x ?m)"
        ),
        rewrite!(
            "mod-absorb-multiple-right";
            "(mod (+ ?x (* ?k ?m)) ?m)" => "(mod ?x ?m)"
        ),
        rewrite!(
            "mod-absorb-multiple-left";
            "(mod (+ (* ?k ?m) ?x) ?m)" => "(mod ?x ?m)"
        ),
        rewrite!(
            "mod-absorb-multiple-sub";
            "(mod (- ?x (* ?k ?m)) ?m)" => "(mod ?x ?m)"
        ),
        rewrite!(
            "mod-push-add";
            "(mod (+ (mod ?x ?m) (mod ?y ?m)) ?m)" => "(mod (+ ?x ?y) ?m)"
        ),
        rewrite!(
            "mod-push-mul";
            "(mod (* (mod ?x ?m) (mod ?y ?m)) ?m)" => "(mod (* ?x ?y) ?m)"
        ),
    ];

    rs
}

/// Generate rewrite rules for boolean optimization
pub fn make_rules() -> Vec<Rewrite<SymbolLang, ()>> {

    
    
    let mut rules: Vec<Rewrite<SymbolLang, ()>> = vec![
        rewrite!("cancel_zero"; "(- ?x 0)" => "?x"),
        rewrite!("ceildiv_1"; "(ceildiv ?x 1)" => "?x"),
        rewrite!("floordiv_1"; "(floordiv ?x 1)" => "?x"),
        rewrite!("div_1"; "(div ?x 1)" => "?x"),
        rewrite!("sub_equal"; "(- ?x ?x)" => "0"),
        rewrite!("div_equal"; "(/ ?x ?x)" => "1"),
        rewrite!("ceildiv-exact-multiple"; "(ceildiv (* ?x ?y) ?y)" => "?x"),
        rewrite!("floordiv-exact-multiple"; "(floordiv (* ?x ?y) ?y)" => "?x"),
        rewrite!("Distribution_add"; "(+ (* ?x ?y) (* ?z ?y))" => "(* (+ ?x ?z) ?y)"),
        rewrite!("Distribution_sub"; "(- (* ?x ?y) (* ?z ?y))" => "(* (- ?x ?z) ?y)"),
        rewrite!("Distribution_sub_reverse"; "(* (- ?x ?z) ?y)" => "(- (* ?x ?y) (* ?z ?y))"),
        rewrite!("Distribution_add_reverse"; "(* (+ ?x ?z) ?y)" => "(+ (* ?x ?y) (* ?z ?y))"),
        ];

    // let mut rules: Vec<Rewrite<SymbolLang, ()>> = vec![
    //     rewrite!("tiling_rule"; "(forcontrol (forvalue ?a ?b ?c ?d) ?e)" => ),];

    rules.push(tiling_rule_in_applier::<()>());
    rules.push(unroll_two_adjacent_rule::<()>());
    rules.extend(const_folding_rewrites());
    rules.push(commutative::<()>("min", 10));
    rules.push(commutative::<()>("+", 10));
    rules.push(commutative::<()>("*", 10));
    rules.push(flatten_only::<()>("block"));
    // rules.push(replace_rule());
    // rules.push(replacereducevariable_rule::<()>());
    rules.extend(divmod_rewrites::<()>());
    rules.push(cancel_pair::<()>("+", "-", Some("0")));
    rules.push(cancel_pair::<()>("*", "/", Some("1")));
    rules.push(cancel_pair::<()>("*", "floordiv", Some("1")));
    rules.push(cancel_pair::<()>("*", "ceildiv", Some("1")));
    // rules.push(mark_unroll_two_adjacent_rule::<()>());
    rules.push(cancel_inside_flat::<()>("+", "-", Some("0")));
    rules.push(cancel_inside_flat::<()>("*", "/", Some("1")));
    // rules.push(merge_unroll_rule::<()>());
    rules
}


fn read_inputs() -> Vec<String> {
    let reader = BufReader::new(io::stdin());
    reader
        .lines()
        .filter_map(|line| line.ok())
        .map(|line| line.trim().to_string())
        .filter(|line| !line.is_empty())
        .collect()
}

fn main() {
    init_logging();
    let overall_start = Instant::now();

    let inputs = read_inputs();

    if inputs.is_empty() {
        error!("No input programs provided on stdin. Pipe JSON produced by mlir_parser.py.");
        std::process::exit(1);
    }

    info!("Loaded {} serialized program(s) from stdin", inputs.len());

    let mut egraph: EGraph<SymbolLang, ()> = EGraph::default();
    let mut roots: Vec<Id> = vec![];
    let mut exprs = Vec::new();

    for (idx, input) in inputs.iter().enumerate() {
        match EGraph::from_json_str_symbollang(input, ()) {
            Ok((src, src_roots)) => {
                let (root, expr) = egraph.append_roots_from_with_cost(&src, &src_roots, AstSize);
                roots.push(root);
                exprs.push(expr);
                info!(
                    "Program {} appended: {} root(s) => root id {}",
                    idx,
                    src_roots.len(),
                    root
                );
            }
            Err(e) => {
                error!("Failed to deserialize program {}: {}", idx, e);
                std::process::exit(1);
            }
        }
    }


    egraph.rebuild();


    let runner = RunnerMT::default()
        .with_egraph(egraph)
        .with_iter_limit(5000)
        .with_time_limit_secs(100.0)
        .with_node_limit(800000)
        .run(&make_rules());

    let elapsed = overall_start.elapsed();
    let stop_reason = runner.stop_reason.clone();

    info!(
        "Done in {:.3?} over {} iteration(s); stop reason: {:?}; e-graph: {} nodes, {} classes",
        elapsed,
        runner.iterations.len(),
        stop_reason,
        runner.egraph.total_size(),
        runner.egraph.number_of_classes()
    );

    let extractor = Extractor::new(&runner.egraph, AstSize);
    for &root in roots.iter() {
        let (best_cost, best_expr) = extractor.find_best(root);
        println!("best[{root}] cost={best_cost}:\n{best_expr}");
    }

    if exprs.len() > 1 {
        println!("Equivalence summary (vs program 0):");
    }
    for i in 1..exprs.len() {
        let equivs = runner.egraph.equivs(&exprs[0], &exprs[i]);
        let verdict = if equivs.is_empty() { "NOT equivalent" } else { "equivalent" };
        println!("  program {i} -> {verdict} (shared e-class ids: {:?})", equivs);
    }
}
