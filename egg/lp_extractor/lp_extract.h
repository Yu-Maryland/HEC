#ifndef LP_EXTRACT_H
#define LP_EXTRACT_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

// Node cost structure for passing precomputed costs
struct NodeCost {
    uint32_t class_id;  // ClassType
    uint32_t node_id;   // NodeType  
    float cost;         // CostType (NCost)
};

// Solver types
enum SolverType {
    SOLVER_CPSAT = 0,
    SOLVER_GUROBI = 1,
    SOLVER_CPLEX = 2
};

// LP Solver Configuration (simplified - preprocessing done in Rust)
// Function to extract with specific solver and configuration
char* cpp_lp_extract_with_solver(const char* egraph_json,
                                 const struct NodeCost* costs,
                                 int cost_count,
                                 int solver_type,
                                 double time_limit,
                                 bool verbose);

// Free the result string returned by cpp_lp_extract functions
void free_result_string(char* result_str);

#ifdef __cplusplus
}
#endif

#endif // LP_EXTRACT_H