#include "lp_extract.h"
#include <iostream>
#include <string>
#include <cstring>
#include <cstdlib>
#include <unordered_map>
#include <vector>
#include <chrono>
#include <sstream>
#include <fstream>
#include <thread>
#include <set>
#include <queue>
#include <unordered_set>
#include <algorithm>
#include <memory>
#include <unistd.h>
#include <fcntl.h>

// Gurobi C++ API
#include "gurobi_c++.h"

// CPLEX C++ API
#include <ilcplex/ilocplex.h>

// OR-Tools CP-SAT API
#include "ortools/sat/cp_model.h"
#include "ortools/sat/cp_model.pb.h"
#include "ortools/sat/cp_model_solver.h"

// JSON parsing using nlohmann/json
#include "json.hpp"
using json = nlohmann::json;
#include <cctype>
#include <functional>
#include <cmath>

// Basic EGraph structures for LP solving
struct EGraphNode {
    std::string op;
    std::vector<uint32_t> children;
    float cost;
    uint32_t class_id;
    uint32_t node_id;
};

struct EClass {
    uint32_t id;
    std::vector<EGraphNode> nodes;
};

struct EGraph {
    std::unordered_map<uint32_t, EClass> classes;
    std::vector<uint32_t> roots;
};

// Hash function for pair<uint32_t, uint32_t>
struct PairHash {
    std::size_t operator()(const std::pair<uint32_t, uint32_t>& p) const {
        return std::hash<uint32_t>{}(p.first) ^ (std::hash<uint32_t>{}(p.second) << 1);
    }
};

// JSON parser using nlohmann/json
class JsonParser {
public:
    static EGraph parseEGraph(const std::string& json_str, const NodeCost* costs, int cost_count, bool verbose) {
        EGraph egraph;
        
        try {
            // Parse JSON using nlohmann/json
            json j = json::parse(json_str);
            
            if (verbose) {
                std::cout << "Parsing EGraph JSON using nlohmann/json" << std::endl;
                std::cout << "Cost map contains " << cost_count << " entries" << std::endl;
            }
            
            // Create cost lookup map
            std::unordered_map<std::string, float> cost_map;
            for (int i = 0; i < cost_count; i++) {
                std::string key = std::to_string(costs[i].class_id) + "." + std::to_string(costs[i].node_id);
                cost_map[key] = costs[i].cost;
            }
        
            // Parse root_eclasses
            if (j.contains("root_eclasses") && j["root_eclasses"].is_array()) {
                for (const auto& root : j["root_eclasses"]) {
                    if (root.is_number_unsigned()) {
                        egraph.roots.push_back(root.get<uint32_t>());
                    }
                }
            }
            
            // Parse classes and nodes (in JSON they're called "nodes")
            if (j.contains("nodes") && j["nodes"].is_object()) {
                const auto& classes = j["nodes"];
                if (verbose) {
                    std::cout << "Found nodes section with " << classes.size() << " classes" << std::endl;
                }
                
                for (const auto& [class_id_str, class_obj] : classes.items()) {
                    uint32_t class_id = std::stoul(class_id_str);
                    
                    // JSON structure is: "nodes" -> "class_id" -> "node_id" -> node_obj
                    // But class_obj IS the nodes, not contains "nodes"
                    if (class_obj.is_object()) {
                        const auto& nodes = class_obj;
                        
                        for (const auto& [node_id_str, node_obj] : nodes.items()) {
                            uint32_t node_id = std::stoul(node_id_str);
                            
                            // Check if this node is in our cost map
                            std::string key = std::to_string(class_id) + "." + std::to_string(node_id);
                            if (cost_map.find(key) == cost_map.end()) {
                                continue; // Skip nodes not in cost map
                            }
                            
                            EGraphNode node;
                            node.class_id = class_id;
                            node.node_id = node_id;
                            node.cost = cost_map[key];
                            
                            // Parse operation
                            if (node_obj.contains("op") && node_obj["op"].is_string()) {
                                node.op = node_obj["op"].get<std::string>();
                            } else {
                                node.op = "op_" + std::to_string(node_id);
                            }
                            
                            // Parse children
                            if (node_obj.contains("children") && node_obj["children"].is_array()) {
                                for (const auto& child : node_obj["children"]) {
                                    if (child.is_number_unsigned()) {
                                        node.children.push_back(child.get<uint32_t>());
                                    }
                                }
                            }
                            
                            egraph.classes[class_id].nodes.push_back(node);
                        }
                    }
                }
            }
            
            if (verbose) {
                std::cout << "Parsed " << egraph.classes.size() << " classes, " << egraph.roots.size() << " roots" << std::endl;
            }
            
        } catch (const json::exception& e) {
            std::cerr << "JSON parsing error: " << e.what() << std::endl;
        }
        
        return egraph;
    }
};

// Forward declarations of solver functions
std::string solve_with_cpsat(const EGraph& egraph, double time_limit, bool verbose);
std::string solve_with_gurobi(const EGraph& egraph, double time_limit, bool verbose);
std::string solve_with_cplex(const EGraph& egraph, double time_limit, bool verbose);

extern "C" {

// Free the result string returned by cpp_lp_extract functions
void free_result_string(char* result_str) {
    if (result_str) {
        free(result_str);
    }
}

// Function to extract with specific solver and configuration
char* cpp_lp_extract_with_solver(const char* egraph_json,
                                 const struct NodeCost* costs,
                                 int cost_count,
                                 int solver_type,
                                 double time_limit,
                                 bool verbose) {
    if (!egraph_json || !costs) {
        return nullptr;
    }
    
    if (verbose) {
        std::cout << "=== C++ LP Extractor ===" << std::endl;
        std::cout << "Solver type: " << solver_type << " (0=CP-SAT, 1=Gurobi, 2=CPLEX)" << std::endl;
        std::cout << "Time limit: " << time_limit << " seconds" << std::endl;
    }
    
    // Export JSON for debugging
    std::string json_string(egraph_json);
    // std::cout << "Debug: Exporting received JSON to file..." << std::endl;
    if (verbose) {
        std::ofstream json_file("debug_received_json.json");
    }
    // json_file << json_string;
    // json_file.close();
    // std::cout << "Debug: JSON exported to debug_received_json.json" << std::endl;
    // std::cout << "Debug: JSON length: " << json_string.length() << " characters" << std::endl;
    
    // Parse the egraph
    EGraph egraph = JsonParser::parseEGraph(json_string, costs, cost_count, verbose);
    
    std::string result_json;
    std::string solver_name;
    
    try {
        auto start_time = std::chrono::high_resolution_clock::now();
        
        switch (solver_type) {
            case SOLVER_CPSAT:
                solver_name = "CP-SAT";
                result_json = solve_with_cpsat(egraph, time_limit, verbose);
                break;
            case SOLVER_GUROBI:
                solver_name = "Gurobi";
                result_json = solve_with_gurobi(egraph, time_limit, verbose);
                break;
            case SOLVER_CPLEX:
                solver_name = "CPLEX";
                result_json = solve_with_cplex(egraph, time_limit, verbose);
                break;
            default:
                solver_name = "Unknown";
                result_json = "{\"status\": \"error\", \"message\": \"Unknown solver type: " + 
                             std::to_string(solver_type) + "\"}";
                break;
        }
        
        auto end_time = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time);
        
        if (verbose) {
            std::cout << "Solver " << solver_name << " completed in " << duration.count() << " ms" << std::endl;
        }
        
    } catch (const std::exception& e) {
        result_json = "{\"status\": \"error\", \"message\": \"Exception: " + std::string(e.what()) + "\"}";
        std::cerr << "Exception in solver: " << e.what() << std::endl;
    }
    
    // Allocate C string for return
    char* result_cstr = (char*)malloc(result_json.length() + 1);
    if (result_cstr) {
        strcpy(result_cstr, result_json.c_str());
    }
    
    if (verbose) {
        std::cout << "Returning result from " << solver_name << std::endl;
    }
    return result_cstr;
}

} // extern "C"

// Implementation of solver functions

// CP-SAT Solver Implementation
// CP-SAT Solver Implementation - using Google OR-Tools CP-SAT API with same constraints as Gurobi/CPLEX
std::string solve_with_cpsat(const EGraph& egraph, double time_limit, bool verbose) {
    if (verbose) {
        std::cout << "=== CP-SAT Solver ===" << std::endl;
    }
    
    try {
        auto start_time = std::chrono::high_resolution_clock::now();
        
        // Initialize CP-SAT model
        operations_research::sat::CpModelBuilder cp_model;
        
        if (verbose) {
            std::cout << "Building CP-SAT constraint model..." << std::endl;
            std::cout << "Classes: " << egraph.classes.size() << std::endl;
            std::cout << "Roots: " << egraph.roots.size() << std::endl;
        }
        
        // Count total nodes
        int total_nodes = 0;
        for (const auto& [class_id, eclass] : egraph.classes) {
            total_nodes += eclass.nodes.size();
        }
        if (verbose) {
            std::cout << "Total nodes: " << total_nodes << std::endl;
        }
        
        // Create variables (same structure as Gurobi/CPLEX)
        std::unordered_map<uint32_t, operations_research::sat::BoolVar> class_active_vars;
        std::unordered_map<std::pair<uint32_t, uint32_t>, operations_research::sat::BoolVar, PairHash> node_vars;
        std::unordered_map<uint32_t, operations_research::sat::IntVar> level_vars;
        std::unordered_map<std::pair<uint32_t, uint32_t>, operations_research::sat::BoolVar, PairHash> opposite_vars;
        
        // Create class activation variables
        for (const auto& [class_id, eclass] : egraph.classes) {
            class_active_vars[class_id] = cp_model.NewBoolVar();
        }
        
        // Create node selection variables and level variables
        for (const auto& [class_id, eclass] : egraph.classes) {
            // Level variable for cycle prevention
            level_vars[class_id] = cp_model.NewIntVar({0, 200});
            
            for (const auto& node : eclass.nodes) {
                node_vars[{class_id, node.node_id}] = cp_model.NewBoolVar();
                // Opposite variable for level constraints
                opposite_vars[{class_id, node.node_id}] = cp_model.NewBoolVar();
            }
        }
        
        if (verbose) {
            std::cout << "Created " << (class_active_vars.size() + node_vars.size() + level_vars.size() + opposite_vars.size()) << " variables" << std::endl;
        }
        
        // Add basic constraints (same as Gurobi/CPLEX)
        
        // Constraint 1: For each class, sum of node selections = class activation
        for (const auto& [class_id, eclass] : egraph.classes) {
            std::vector<operations_research::sat::BoolVar> node_vars_in_class;
            for (const auto& node : eclass.nodes) {
                node_vars_in_class.push_back(node_vars[{class_id, node.node_id}]);
            }
            cp_model.AddEquality(operations_research::sat::LinearExpr::Sum(node_vars_in_class), class_active_vars[class_id]);
        }
        
        // Constraint 2: Root classes must be active
        for (const auto& root_class : egraph.roots) {
            if (class_active_vars.find(root_class) != class_active_vars.end()) {
                cp_model.AddEquality(class_active_vars[root_class], 1);
            }
        }
        
        // Constraint 3: Child activation constraints
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                std::pair<uint32_t, uint32_t> node_key = {class_id, node.node_id};
                operations_research::sat::BoolVar node_var = node_vars[node_key];
                
                for (const auto& child_class : node.children) {
                    if (class_active_vars.find(child_class) != class_active_vars.end()) {
                        operations_research::sat::BoolVar child_var = class_active_vars[child_class];
                        cp_model.AddImplication(node_var, child_var);
                    }
                }
            }
        }
        
        // Constraint 4: Opposite variable constraints
        for (const auto& [node_key, node_var] : node_vars) {
            operations_research::sat::BoolVar opp_var = opposite_vars[node_key];
            cp_model.AddEquality(operations_research::sat::LinearExpr::Sum({node_var, opp_var}), 1);
        }
        
        // Set objective function (minimize cost)
        std::vector<operations_research::sat::BoolVar> cost_vars;
        std::vector<int64_t> cost_coeffs;
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                cost_vars.push_back(node_vars[{class_id, node.node_id}]);
                cost_coeffs.push_back(static_cast<int64_t>(node.cost));
            }
        }
        cp_model.Minimize(operations_research::sat::LinearExpr::WeightedSum(cost_vars, cost_coeffs));
        
        int self_loop_constraints = 0;
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                bool has_self_loop = std::find(node.children.begin(), node.children.end(), class_id) != node.children.end();
                if (has_self_loop) {
                    auto node_key = std::make_pair(class_id, node.node_id);
                    if (node_vars.find(node_key) != node_vars.end()) {
                        cp_model.AddEquality(node_vars[node_key], 0);
                        self_loop_constraints++;
                    }
                }
            }
        }
        int added_constraints = 0;
        int64_t M = 200; // Large constant
        
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                std::pair<uint32_t, uint32_t> node_key = {class_id, node.node_id};
                if (opposite_vars.find(node_key) == opposite_vars.end()) continue;
                
                operations_research::sat::IntVar parent_level = level_vars[class_id];
                operations_research::sat::BoolVar opp_var = opposite_vars[node_key];
                
                // For each child class (excluding self-loops)
                std::set<uint32_t> unique_children;
                for (uint32_t child_class : node.children) {
                    if (child_class != class_id && egraph.classes.find(child_class) != egraph.classes.end()) {
                        unique_children.insert(child_class);
                    }
                }
                
                for (uint32_t child_class : unique_children) {
                    if (level_vars.find(child_class) != level_vars.end()) {
                        operations_research::sat::IntVar child_level = level_vars[child_class];
                        // -parent_level + child_level + M * opp_var >= 1
                        operations_research::sat::LinearExpr expr = 
                            operations_research::sat::LinearExpr::Term(parent_level, -1) +
                            child_level +
                            operations_research::sat::LinearExpr::Term(opp_var, M);
                        cp_model.AddGreaterOrEqual(expr, 1);
                        added_constraints++;
                    }
                }
            }
        }
        
        operations_research::sat::Model model;
        
        // Configure CP-SAT parameters
        operations_research::sat::SatParameters parameters;
        parameters.set_max_time_in_seconds(time_limit);
        if (!verbose) {
            parameters.set_log_search_progress(false);
        }
        model.Add(operations_research::sat::NewSatParameters(parameters));
        
        operations_research::sat::CpSolverResponse response = operations_research::sat::SolveCpModel(cp_model.Build(), &model);
        
        auto end_time = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time);
        double solve_time = duration.count() / 1000.0;
        
        double best_objective = -1;
        std::string best_status = "unknown";
        
        if (response.status() == operations_research::sat::CpSolverStatus::OPTIMAL) {
            best_objective = static_cast<double>(response.objective_value());
            best_status = "optimal";
            if (verbose) {
                std::cout << "Found optimal solution with objective: " << best_objective << std::endl;
            }
        } else if (response.status() == operations_research::sat::CpSolverStatus::FEASIBLE) {
            best_objective = static_cast<double>(response.objective_value());
            best_status = "time_limit";
            std::cout << "Found feasible solution with objective: " << best_objective << std::endl;
        } else if (response.status() == operations_research::sat::CpSolverStatus::INFEASIBLE) {
            best_status = "infeasible";
            if (verbose) {
                std::cout << "Model is infeasible" << std::endl;
            }
        } else {
            best_status = "error";
            if (verbose) {
                std::cout << "Failed to solve" << std::endl;
            }
        }
        
        // Extract choices from solution if optimal/feasible
        std::map<uint32_t, uint32_t> choices;
        if (response.status() == operations_research::sat::CpSolverStatus::OPTIMAL || 
            response.status() == operations_research::sat::CpSolverStatus::FEASIBLE) {
            for (const auto& [node_key, var] : node_vars) {
                if (operations_research::sat::SolutionBooleanValue(response, var)) {  // Node is selected
                    uint32_t class_id = node_key.first;
                    uint32_t node_id = node_key.second;
                    choices[class_id] = node_id;
                }
            }
        }
        
        // Build result JSON (same format as Gurobi/CPLEX)
        std::stringstream result;
        result << "{";
        result << "\"status\": \"" << best_status << "\",";
        result << "\"solver\": \"CP-SAT\",";
        result << "\"method\": \"Constraint Programming with Level-based Cycle Prevention\",";
        result << "\"time_limit\": " << time_limit << ",";
        result << "\"objective_value\": " << best_objective << ",";
        result << "\"solve_time\": " << solve_time << ",";
        result << "\"total_variables\": " << (class_active_vars.size() + node_vars.size() + level_vars.size() + opposite_vars.size()) << ",";
        result << "\"choices\": {";
        bool first = true;
        for (const auto& [class_id, node_id] : choices) {
            if (!first) result << ",";
            result << "\"" << class_id << "\": " << node_id;
            first = false;
        }
        result << "},";
        result << "\"message\": \"CP-SAT constraint programming with level-based cycle prevention completed\"";
        result << "}";

        
        if (verbose) {
            std::cout << "CP-SAT solver completed in " << solve_time << " seconds" << std::endl;
            std::cout << "Final objective value: " << (best_objective == -1 ? "infeasible" : std::to_string(best_objective)) << std::endl;
        }

        
        return result.str();
        
    } catch (const std::exception& e) {
        std::stringstream error_result;
        error_result << "{";
        error_result << "\"status\": \"error\",";
        error_result << "\"solver\": \"CP-SAT\",";
        error_result << "\"message\": \"Error: " << e.what() << "\"";
        error_result << "}";
        return error_result.str();
    }
}


// Gurobi Solver Implementation
std::string solve_with_gurobi(const EGraph& egraph, double time_limit, bool verbose) {
    if (verbose) {
        std::cout << "=== Gurobi Solver ===" << std::endl;
    }
    
    try {
        auto start_time = std::chrono::high_resolution_clock::now();

        
        if (verbose) {
            std::cout << "Building Gurobi MIP model..." << std::endl;
            std::cout << "Classes: " << egraph.classes.size() << std::endl;
            std::cout << "Roots: " << egraph.roots.size() << std::endl;
        }
        
        int total_nodes = 0;
        for (const auto& [class_id, eclass] : egraph.classes) {
            total_nodes += eclass.nodes.size();
        }
        if (verbose) {
            std::cout << "Total nodes: " << total_nodes << std::endl;
        }
        
        // Create Gurobi environment and model
        std::unique_ptr<GRBEnv> env_ptr;
        if (!verbose) {
            // Temporarily redirect all output streams to suppress license messages
            int original_stdout = dup(STDOUT_FILENO);
            int original_stderr = dup(STDERR_FILENO);
            
            int devnull = open("/dev/null", O_WRONLY);
            dup2(devnull, STDOUT_FILENO);
            dup2(devnull, STDERR_FILENO);
            close(devnull);
            
            env_ptr = std::make_unique<GRBEnv>();
            env_ptr->set(GRB_IntParam_OutputFlag, 0);      // Suppress solver output
            env_ptr->set(GRB_IntParam_LogToConsole, 0);    // Suppress console logging
            
            // Restore original output streams
            dup2(original_stdout, STDOUT_FILENO);
            dup2(original_stderr, STDERR_FILENO);
            close(original_stdout);
            close(original_stderr);
        } else {
            env_ptr = std::make_unique<GRBEnv>();
        }
        GRBModel model = GRBModel(*env_ptr);
        
        // Set time limit
        if (time_limit > 0) {
            model.set(GRB_DoubleParam_TimeLimit, time_limit);
        }
        
        // Create variables
        std::unordered_map<uint32_t, GRBVar> class_active_vars;
        std::unordered_map<std::pair<uint32_t, uint32_t>, GRBVar, PairHash> node_vars;
        
        // Create binary variables for each class (activation)
        for (const auto& [class_id, eclass] : egraph.classes) {
            std::string var_name = "A_" + std::to_string(class_id);
            class_active_vars[class_id] = model.addVar(0.0, 1.0, 0.0, GRB_BINARY, var_name);
        }
        
        // Create binary variables for each node (selection)
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                std::string var_name = "N_" + std::to_string(class_id) + "_" + std::to_string(node.node_id);
                node_vars[{class_id, node.node_id}] = model.addVar(0.0, 1.0, node.cost, GRB_BINARY, var_name);
            }
        }
        
        // Set objective (minimize total cost)
        model.set(GRB_IntAttr_ModelSense, GRB_MINIMIZE);
        
        if (verbose) {
            std::cout << "Created " << class_active_vars.size() << " class variables and " 
                      << node_vars.size() << " node variables" << std::endl;
        }
        
        // Add constraints
        
        // Constraint 1: For each class, sum of node selections = class activation
        for (const auto& [class_id, eclass] : egraph.classes) {
            GRBLinExpr sum = 0;
            for (const auto& node : eclass.nodes) {
                auto key = std::make_pair(class_id, node.node_id);
                if (node_vars.find(key) != node_vars.end()) {
                    sum += node_vars[key];
                }
            }
            std::string constr_name = "class_active_" + std::to_string(class_id);
            model.addConstr(sum == class_active_vars[class_id], constr_name);
        }
        
        // Constraint 2: If node is selected, all child classes must be active
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                auto node_key = std::make_pair(class_id, node.node_id);
                if (node_vars.find(node_key) == node_vars.end()) continue;
                
                for (const auto& child_class : node.children) {
                    if (class_active_vars.find(child_class) != class_active_vars.end()) {
                        std::string constr_name = "child_active_" + std::to_string(class_id) 
                                                + "_" + std::to_string(node.node_id) 
                                                + "_" + std::to_string(child_class);
                        model.addConstr(node_vars[node_key] <= class_active_vars[child_class], constr_name);
                    }
                }
            }
        }
        
        // Constraint 3: Root classes must be active
        for (const auto& root_class : egraph.roots) {
            if (class_active_vars.find(root_class) != class_active_vars.end()) {
                std::string constr_name = "root_active_" + std::to_string(root_class);
                model.addConstr(class_active_vars[root_class] == 1, constr_name);
            }
        }
        
        
        // Set objective function: minimize total cost of selected nodes
        GRBLinExpr obj = 0;
        for (const auto& [node_key, var] : node_vars) {
            uint32_t class_id = node_key.first;
            uint32_t node_id = node_key.second;
            if (egraph.classes.find(class_id) != egraph.classes.end()) {
                const auto& eclass = egraph.classes.at(class_id);
                for (const auto& node : eclass.nodes) {
                    if (node.node_id == node_id) {
                        obj += node.cost * var;
                        break;
                    }
                }
            }
        }
        model.setObjective(obj, GRB_MINIMIZE);
        
        // Export LP file for debugging
        // std::cout << "Debug: Exporting basic model to LP file..." << std::endl;
        // model.update();
        // model.write("debug_basic_model.lp");
        // std::cout << "Debug: Basic model exported to debug_basic_model.lp" << std::endl;
        
        // Debug: Check model feasibility before cycle constraints
        // std::cout << "Debug: Testing basic model feasibility..." << std::endl;
        // model.optimize();
        // int debug_status = model.get(GRB_IntAttr_Status);
        // if (debug_status == GRB_OPTIMAL) {
        //     std::cout << "Debug: Basic model is feasible with objective: " << model.get(GRB_DoubleAttr_ObjVal) << std::endl;
        // } else if (debug_status == GRB_INFEASIBLE) {
        //     std::cout << "Debug: ERROR - Basic model is already infeasible before cycle constraints!" << std::endl;
        //     std::cout << "Debug: This indicates a problem with basic constraints" << std::endl;
        // } else {
        //     std::cout << "Debug: Basic model status: " << debug_status << std::endl;
        // }
        
        // Add level-based cycle prevention constraints (following eboost approach)
        {
            
            // Create level variables for each class: L_<class_id>
            std::unordered_map<uint32_t, GRBVar> level_vars;
            std::unordered_map<std::pair<uint32_t, uint32_t>, GRBVar, PairHash> opposite_vars;
            
            uint32_t num_classes = egraph.classes.size();
            for (const auto& [class_id, eclass] : egraph.classes) {
                std::string level_var_name = "L_" + std::to_string(class_id);
                level_vars[class_id] = model.addVar(0.0, num_classes, 0.0, GRB_INTEGER, level_var_name);
                
                // Create opposite variables for each node: Opp_<class_id>_<node_id>
                for (const auto& node : eclass.nodes) {
                    std::string opp_var_name = "Opp_" + std::to_string(class_id) + "_" + std::to_string(node.node_id);
                    opposite_vars[{class_id, node.node_id}] = model.addVar(0.0, 1.0, 0.0, GRB_BINARY, opp_var_name);
                }
            }
            
            int added_constraints = 0;
            
            // Add constraints: N + Opp = 1 for each node
            for (const auto& [class_id, eclass] : egraph.classes) {
                for (const auto& node : eclass.nodes) {
                    auto node_key = std::make_pair(class_id, node.node_id);
                    if (node_vars.find(node_key) != node_vars.end() && 
                        opposite_vars.find(node_key) != opposite_vars.end()) {
                        std::string constr_name = "opp_" + std::to_string(class_id) + "_" + std::to_string(node.node_id);
                        model.addConstr(node_vars[node_key] + opposite_vars[node_key] == 1, constr_name);
                        added_constraints++;
                    }
                }
            }
            
            // Add self-loop prevention: if node points to its own class, set N = 0
            for (const auto& [class_id, eclass] : egraph.classes) {
                for (const auto& node : eclass.nodes) {
                    bool has_self_loop = std::find(node.children.begin(), node.children.end(), class_id) != node.children.end();
                    if (has_self_loop) {
                        auto node_key = std::make_pair(class_id, node.node_id);
                        if (node_vars.find(node_key) != node_vars.end()) {
                            std::string constr_name = "self_loop_" + std::to_string(class_id) + "_" + std::to_string(node.node_id);
                            model.addConstr(node_vars[node_key] == 0, constr_name);
                            added_constraints++;
                        }
                    }
                }
            }
            
            // Add level constraints: -L_parent + L_child + M * Opp >= 1
            // where M = num_classes + 1
            uint32_t M = num_classes + 1;
            for (const auto& [class_id, eclass] : egraph.classes) {
                for (const auto& node : eclass.nodes) {
                    auto node_key = std::make_pair(class_id, node.node_id);
                    if (opposite_vars.find(node_key) == opposite_vars.end()) continue;
                    
                    GRBVar parent_level = level_vars[class_id];
                    GRBVar opp_var = opposite_vars[node_key];
                    
                    // For each child class (excluding self-loops)
                    std::set<uint32_t> unique_children;
                    for (uint32_t child_class : node.children) {
                        if (child_class != class_id && egraph.classes.find(child_class) != egraph.classes.end()) {
                            unique_children.insert(child_class);
                        }
                    }
                    
                    for (uint32_t child_class : unique_children) {
                        if (level_vars.find(child_class) != level_vars.end()) {
                            GRBVar child_level = level_vars[child_class];
                            std::string constr_name = "level_" + std::to_string(class_id) + "_" + 
                                                     std::to_string(node.node_id) + "_" + std::to_string(child_class);
                            model.addConstr(-parent_level + child_level + M * opp_var >= 1, constr_name);
                            added_constraints++;
                        }
                    }
                }
            }
            
            if (verbose) {
                std::cout << "Added " << added_constraints << " level-based cycle prevention constraints" << std::endl;
            }
            
            // Export model with cycle constraints for debugging
            if (verbose) {
                std::cout << "Debug: Exporting model with level constraints to debug_gurobi.lp" << std::endl;
                model.update();
                model.write("debug_gurobi.lp");
            }
        }
        
        // Solve the model
        model.optimize();
        
        int status = model.get(GRB_IntAttr_Status);
        double best_objective = GRB_INFINITY;
        std::string best_status = "unknown";
        
        if (status == GRB_OPTIMAL) {
            best_objective = model.get(GRB_DoubleAttr_ObjVal);
            best_status = "optimal";
            if (verbose) {
                std::cout << "Found solution with objective: " << best_objective << std::endl;
            }            
        } else if (status == GRB_TIME_LIMIT) {
            if (verbose) {
                std::cout << "Time limit reached" << std::endl;
            }
            if (model.get(GRB_IntAttr_SolCount) > 0) {
                best_objective = model.get(GRB_DoubleAttr_ObjVal);
                best_status = "time_limit";
            }
        } else if (status == GRB_INFEASIBLE) {
            if (verbose) {
                std::cout << "Model is infeasible" << std::endl;
            }
            best_status = "infeasible";
        } else {
            best_status = "error";
        }
        
        auto end_time = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time);
        double solve_time = duration.count() / 1000.0;
        
        // Extract choices from solution if optimal
        std::map<uint32_t, uint32_t> choices;
        if ((status == GRB_OPTIMAL || status == GRB_TIME_LIMIT) && model.get(GRB_IntAttr_SolCount) > 0) {
            for (const auto& [node_key, var] : node_vars) {
                if (var.get(GRB_DoubleAttr_X) > 0.5) {  // Node is selected
                    uint32_t class_id = node_key.first;
                    uint32_t node_id = node_key.second;
                    choices[class_id] = node_id;
                }
            }
        }
        
        // Build result JSON
        std::stringstream result;
        result << "{";
        result << "\"status\": \"" << best_status << "\",";
        result << "\"solver\": \"Gurobi\",";
        result << "\"method\": \"Mixed Integer Programming with Level-based Cycle Prevention\",";
        result << "\"time_limit\": " << time_limit << ",";
        result << "\"objective_value\": " << (best_objective == GRB_INFINITY ? -1 : best_objective) << ",";
        result << "\"solve_time\": " << solve_time << ",";
        result << "\"total_variables\": " << (class_active_vars.size() + node_vars.size()) << ",";
        result << "\"choices\": {";
        bool first = true;
        for (const auto& [class_id, node_id] : choices) {
            if (!first) result << ",";
            result << "\"" << class_id << "\": " << node_id;
            first = false;
        }
        result << "},";
        result << "\"message\": \"Gurobi MIP with level-based cycle prevention completed\"";
        result << "}";
        
        if (verbose) {
            std::cout << "Gurobi solver completed in " << solve_time << " seconds" << std::endl;
            std::cout << "Final objective value: " << (best_objective == GRB_INFINITY ? "infeasible" : std::to_string(best_objective)) << std::endl;
        }
        
        return result.str();
        
    } catch (GRBException& e) {
        std::stringstream error_result;
        error_result << "{";
        error_result << "\"status\": \"error\",";
        error_result << "\"solver\": \"Gurobi\",";
        error_result << "\"message\": \"Gurobi error: " << e.getMessage() << "\"";
        error_result << "}";
        return error_result.str();
    } catch (const std::exception& e) {
        std::stringstream error_result;
        error_result << "{";
        error_result << "\"status\": \"error\",";
        error_result << "\"solver\": \"Gurobi\",";
        error_result << "\"message\": \"Error: " << e.what() << "\"";
        error_result << "}";
        return error_result.str();
    }
}

// CPLEX Solver Implementation - using real CPLEX API with same constraints as Gurobi
std::string solve_with_cplex(const EGraph& egraph, double time_limit, bool verbose) {
    if (verbose) {
        std::cout << "=== CPLEX Solver ===" << std::endl;
    }
    
    try {
        auto start_time = std::chrono::high_resolution_clock::now();
        
        // Initialize CPLEX environment and model
        IloEnv env;
        IloModel model(env);
        IloCplex cplex(model);
        
        // Set time limit (using new parameter name to avoid deprecation warning)
        cplex.setParam(IloCplex::Param::TimeLimit, time_limit);
        if (!verbose) {
            cplex.setOut(env.getNullStream()); // Suppress CPLEX output
        }
        
        if (verbose) {
            std::cout << "Building CPLEX MIP model..." << std::endl;
            std::cout << "Classes: " << egraph.classes.size() << std::endl;
            std::cout << "Roots: " << egraph.roots.size() << std::endl;
        }
        
        // Count total nodes
        int total_nodes = 0;
        for (const auto& [class_id, eclass] : egraph.classes) {
            total_nodes += eclass.nodes.size();
        }
        if (verbose) {
            std::cout << "Total nodes: " << total_nodes << std::endl;
        }
        
        // Create variables (same structure as Gurobi)
        std::unordered_map<uint32_t, IloIntVar> class_active_vars;
        std::unordered_map<std::pair<uint32_t, uint32_t>, IloIntVar, PairHash> node_vars;
        std::unordered_map<uint32_t, IloNumVar> level_vars;
        std::unordered_map<std::pair<uint32_t, uint32_t>, IloIntVar, PairHash> opposite_vars;
        
        // Create class activation variables
        for (const auto& [class_id, eclass] : egraph.classes) {
            std::string name = "A_" + std::to_string(class_id);
            class_active_vars[class_id] = IloIntVar(env, 0, 1, name.c_str());
            model.add(class_active_vars[class_id]);
        }
        
        // Create node selection variables and level variables
        for (const auto& [class_id, eclass] : egraph.classes) {
            // Level variable for cycle prevention
            std::string level_name = "L_" + std::to_string(class_id);
            level_vars[class_id] = IloNumVar(env, 0, 200, level_name.c_str());
            model.add(level_vars[class_id]);
            
            for (const auto& node : eclass.nodes) {
                std::string node_name = "N_" + std::to_string(class_id) + "_" + std::to_string(node.node_id);
                node_vars[{class_id, node.node_id}] = IloIntVar(env, 0, 1, node_name.c_str());
                model.add(node_vars[{class_id, node.node_id}]);
                
                // Opposite variable for level constraints
                std::string opp_name = "Opp_" + std::to_string(class_id) + "_" + std::to_string(node.node_id);
                opposite_vars[{class_id, node.node_id}] = IloIntVar(env, 0, 1, opp_name.c_str());
                model.add(opposite_vars[{class_id, node.node_id}]);
            }
        }
        
        if (verbose) {
            std::cout << "Created " << (class_active_vars.size() + node_vars.size() + level_vars.size() + opposite_vars.size()) << " variables" << std::endl;
        }
        
        // Constraint 1: For each class, sum of node selections = class activation
        for (const auto& [class_id, eclass] : egraph.classes) {
            IloExpr sum_nodes(env);
            for (const auto& node : eclass.nodes) {
                sum_nodes += node_vars[{class_id, node.node_id}];
            }
            std::string constr_name = "class_active_" + std::to_string(class_id);
            model.add(sum_nodes == class_active_vars[class_id]);
            sum_nodes.end();
        }
        
        // Constraint 2: Root classes must be active
        for (const auto& root_class : egraph.roots) {
            if (class_active_vars.find(root_class) != class_active_vars.end()) {
                std::string constr_name = "root_" + std::to_string(root_class);
                model.add(class_active_vars[root_class] == 1);
            }
        }
        
        // Constraint 3: Child activation constraints
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                std::pair<uint32_t, uint32_t> node_key = {class_id, node.node_id};
                IloIntVar node_var = node_vars[node_key];
                
                for (const auto& child_class : node.children) {
                    if (class_active_vars.find(child_class) != class_active_vars.end()) {
                        IloIntVar child_var = class_active_vars[child_class];
                        std::string constr_name = "child_active_" + std::to_string(class_id) + "_" + 
                                                 std::to_string(node.node_id) + "_" + std::to_string(child_class);
                        model.add(child_var >= node_var);
                    }
                }
            }
        }
        
        // Constraint 4: Opposite variable constraints
        for (const auto& [node_key, node_var] : node_vars) {
            IloIntVar opp_var = opposite_vars[node_key];
            model.add(node_var + opp_var == 1);
        }
        
        // Set objective function (minimize cost)
        IloExpr objective(env);
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                objective += node.cost * node_vars[{class_id, node.node_id}];
            }
        }
        model.add(IloMinimize(env, objective));
        objective.end();
        
        int self_loop_constraints = 0;
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                bool has_self_loop = std::find(node.children.begin(), node.children.end(), class_id) != node.children.end();
                if (has_self_loop) {
                    auto node_key = std::make_pair(class_id, node.node_id);
                    if (node_vars.find(node_key) != node_vars.end()) {
                        std::string constr_name = "self_loop_" + std::to_string(class_id) + "_" + std::to_string(node.node_id);
                        model.add(node_vars[node_key] == 0);
                        self_loop_constraints++;
                    }
                }
            }
        }

        if (verbose) {
            std::cout << "Added " << self_loop_constraints << " self-loop prevention constraints" << std::endl;
        }
        
        int added_constraints = 0;
        double M = 200.0; // Large constant
        
        for (const auto& [class_id, eclass] : egraph.classes) {
            for (const auto& node : eclass.nodes) {
                std::pair<uint32_t, uint32_t> node_key = {class_id, node.node_id};
                if (opposite_vars.find(node_key) == opposite_vars.end()) continue;
                
                IloNumVar parent_level = level_vars[class_id];
                IloIntVar opp_var = opposite_vars[node_key];
                
                // For each child class (excluding self-loops)
                std::set<uint32_t> unique_children;
                for (uint32_t child_class : node.children) {
                    if (child_class != class_id && egraph.classes.find(child_class) != egraph.classes.end()) {
                        unique_children.insert(child_class);
                    }
                }
                
                for (uint32_t child_class : unique_children) {
                    if (level_vars.find(child_class) != level_vars.end()) {
                        IloNumVar child_level = level_vars[child_class];
                        std::string constr_name = "level_" + std::to_string(class_id) + "_" + 
                                                 std::to_string(node.node_id) + "_" + std::to_string(child_class);
                        model.add(-parent_level + child_level + M * opp_var >= 1);
                        added_constraints++;
                    }
                }
            }
        }
        
        if (verbose) {
            std::cout << "Added " << added_constraints << " level-based cycle prevention constraints" << std::endl;
        }
        
        // Export model to LP file for debugging
        if (verbose) {
            std::cout << "Debug: Exporting CPLEX model with constraints to debug_cplex.lp." << std::endl;
            cplex.exportModel("debug_cplex.lp");
        }
        
        // Solve the model
        bool solved = cplex.solve();
        
        double best_objective = IloInfinity;
        std::string best_status = "unknown";
        
        if (solved) {
            IloCplex::CplexStatus status = cplex.getCplexStatus();
            if (status == IloCplex::Optimal) {
                best_objective = cplex.getObjValue();
                best_status = "optimal";
                if (verbose) {
                    std::cout << "Found optimal solution with objective: " << best_objective << std::endl;
                }
            } else if (status == IloCplex::OptimalTol) {
                best_objective = cplex.getObjValue();
                best_status = "optimal";
                if (verbose) {
                    std::cout << "Found solution within tolerance with objective: " << best_objective << std::endl;
                }
            } else if (status == IloCplex::AbortTimeLim) {
                if (cplex.getSolnPoolNsolns() > 0) {
                    best_objective = cplex.getObjValue();
                    best_status = "time_limit";
                    if (verbose) {
                        std::cout << "Time limit reached with solution: " << best_objective << std::endl;
                    }
                } else {
                    best_status = "time_limit";
                    if (verbose) {
                        std::cout << "Time limit reached without solution" << std::endl;
                    }
                }
            } else if (status == IloCplex::Infeasible) {
                if (verbose) {
                std::cout << "Model is infeasible" << std::endl;
            }
                best_status = "infeasible";
            }
        } else {
            if (verbose) {
                std::cout << "Failed to solve" << std::endl;
            }
            best_status = "error";
        }
        
        auto end_time = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time);
        double solve_time = duration.count() / 1000.0;
        
        // Extract choices from solution if optimal
        std::map<uint32_t, uint32_t> choices;
        if (solved && (best_status == "optimal" || best_status == "time_limit") && cplex.getSolnPoolNsolns() > 0) {
            for (const auto& [node_key, var] : node_vars) {
                if (cplex.getValue(var) > 0.5) {  // Node is selected
                    uint32_t class_id = node_key.first;
                    uint32_t node_id = node_key.second;
                    choices[class_id] = node_id;
                }
            }
        }
        
        // Build result JSON (same format as Gurobi)
        std::stringstream result;
        result << "{";
        result << "\"status\": \"" << best_status << "\",";
        result << "\"solver\": \"CPLEX\",";
        result << "\"method\": \"Mixed Integer Programming with Level-based Cycle Prevention\",";
        result << "\"time_limit\": " << time_limit << ",";
        result << "\"objective_value\": " << (best_objective == IloInfinity ? -1 : best_objective) << ",";
        result << "\"solve_time\": " << solve_time << ",";
        result << "\"total_variables\": " << (class_active_vars.size() + node_vars.size() + level_vars.size() + opposite_vars.size()) << ",";
        result << "\"choices\": {";
        bool first = true;
        for (const auto& [class_id, node_id] : choices) {
            if (!first) result << ",";
            result << "\"" << class_id << "\": " << node_id;
            first = false;
        }
        result << "},";
        result << "\"message\": \"CPLEX MIP with level-based cycle prevention completed\"";
        result << "}";
        
        if (verbose) {
            std::cout << "CPLEX solver completed in " << solve_time << " seconds" << std::endl;
            std::cout << "Final objective value: " << (best_objective == IloInfinity ? "infeasible" : std::to_string(best_objective)) << std::endl;
        }
        
        // Clean up CPLEX environment
        env.end();
        
        return result.str();
        
    } catch (IloException& e) {
        std::stringstream error_result;
        error_result << "{";
        error_result << "\"status\": \"error\",";
        error_result << "\"solver\": \"CPLEX\",";
        error_result << "\"message\": \"CPLEX error: " << e.getMessage() << "\"";
        error_result << "}";
        return error_result.str();
    } catch (const std::exception& e) {
        std::stringstream error_result;
        error_result << "{";
        error_result << "\"status\": \"error\",";
        error_result << "\"solver\": \"CPLEX\",";
        error_result << "\"message\": \"Error: " << e.what() << "\"";
        error_result << "}";
        return error_result.str();
    }
}