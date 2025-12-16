#[cfg(feature = "lp-extractor")]
use std::ffi::{CString, CStr};
#[cfg(feature = "lp-extractor")]
use std::os::raw::c_char;
use crate::json::SerializedEgraph;
#[cfg(feature = "lp-extractor")]
use crate::boosted_extract::extractor::{NodeCostFunction, ExtractionResult};
#[cfg(feature = "lp-extractor")]
use crate::{ClassType, NodeType};
#[cfg(feature = "lp-extractor")]
use crate::util::IndexMap;
#[cfg(feature = "lp-extractor")]
use std::collections::HashMap;
#[cfg(feature = "lp-extractor")]
use serde_json::Value;

// C struct for passing node costs
#[cfg(feature = "lp-extractor")]
#[repr(C)]
struct NodeCost {
    class_id: u32,
    node_id: u32,
    cost: f32,
}

#[cfg(feature = "lp-extractor")]
extern "C" {
    fn cpp_lp_extract_with_solver(
        egraph_json: *const c_char,
        costs: *const NodeCost,
        cost_count: i32,
        solver_type: i32,
        time_limit: f64,
        verbose: bool,
    ) -> *mut c_char;
    fn free_result_string(result_str: *mut c_char);
}

// Solver type constants
#[cfg(feature = "lp-extractor")]
pub const SOLVER_CPSAT: i32 = 0;
#[cfg(feature = "lp-extractor")]
pub const SOLVER_GUROBI: i32 = 1;
#[cfg(feature = "lp-extractor")]
pub const SOLVER_CPLEX: i32 = 2;


/// Call C++ LP extractor with specific solver and return ExtractionResult
#[cfg(feature = "lp-extractor")]
pub fn call_cpp_lp_extract_with_solver(
    egraph: &SerializedEgraph,
    cost_fn: &NodeCostFunction,
    solver_type: i32,
    time_limit: f64,
    verbose: bool,
) -> Option<ExtractionResult> {
    let json_result = call_cpp_lp_extract_raw(egraph, cost_fn, solver_type, time_limit, verbose)?;
    if verbose {
        println!("json_result:{:?}",json_result);
    }
    parse_extraction_result(&json_result, egraph, cost_fn)
}

/// Call C++ LP extractor and return raw JSON string
#[cfg(feature = "lp-extractor")]
pub fn call_cpp_lp_extract_raw(
    egraph: &SerializedEgraph,
    cost_fn: &NodeCostFunction,
    solver_type: i32,
    time_limit: f64,
    verbose: bool,
) -> Option<String> {
    // Convert egraph to JSON string
    let json_str = match egraph.to_json_str() {
        Ok(json) => json,
        Err(_) => return None,
    };
    
    // Convert to C string
    let c_json = match CString::new(json_str) {
        Ok(c_str) => c_str,
        Err(_) => return None,
    };
    
    // Precompute costs for all nodes
    let mut node_costs = Vec::new();
    for (class_id, nodes) in &egraph.nodes {
        for (node_id, node) in nodes {
            let cost_value = cost_fn(&node.costs);
            node_costs.push(NodeCost {
                class_id: *class_id as u32,
                node_id: *node_id as u32,
                cost: cost_value.into_inner() as f32,
            });
        }
    }
    
    // Call C++ function with specific solver
    unsafe {
        let result_ptr = cpp_lp_extract_with_solver(
            c_json.as_ptr(),
            node_costs.as_ptr(),
            node_costs.len() as i32,
            solver_type,
            time_limit,
            verbose,
        );
        
        if result_ptr.is_null() {
            return None;
        }
        
        // Convert result back to Rust string
        let result_cstr = CStr::from_ptr(result_ptr);
        let result = match result_cstr.to_str() {
            Ok(s) => s.to_string(),
            Err(_) => {
                free_result_string(result_ptr);
                return None;
            }
        };
        
        // Free the C++ allocated string
        free_result_string(result_ptr);
        Some(result)
    }
}

/// Parse JSON result from C++ solver into ExtractionResult
#[cfg(feature = "lp-extractor")]
fn parse_extraction_result(
    json_result: &str,
    egraph: &SerializedEgraph,
    cost_fn: &NodeCostFunction,
) -> Option<ExtractionResult> {
    let parsed: Value = serde_json::from_str(json_result).ok()?;
    
    // Check if solver succeeded
    let status = parsed.get("status")?.as_str()?;
    if status != "optimal" && status != "time_limit" {
        return None; // Solver failed or infeasible
    }
    
    // Extract choices from JSON
    let choices_json = parsed.get("choices")?.as_object()?;
    let mut choices = IndexMap::with_hasher(Default::default());
    
    for (class_id_str, node_id_value) in choices_json {
        let class_id: ClassType = class_id_str.parse().ok()?;
        let node_id: NodeType = node_id_value.to_string().parse().ok()?;
        choices.insert(class_id, node_id);
    }
    
    // Create cost map using the cost function
    let mut cost_map = HashMap::new();
    for (_, nodes) in &egraph.nodes {
        for (node_id, node) in nodes {
            let cost_value = cost_fn(&node.costs);
            cost_map.insert(*node_id, cost_value);
        }
    }
    
    Some(ExtractionResult {
        choices,
        cost: cost_map,
    })
}


/// Stub function when lp-extractor feature is not enabled
#[cfg(not(feature = "lp-extractor"))]
pub fn call_cpp_lp_extract_with_solver(
    _egraph: &SerializedEgraph,
    _cost_fn: &NodeCostFunction,
    _solver_type: i32,
    _time_limit: f64,
    _verbose: bool,
) -> Option<ExtractionResult> {
    None // LP extractor not available
}