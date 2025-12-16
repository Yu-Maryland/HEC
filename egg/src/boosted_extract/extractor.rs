use crate::*;
use std::{collections::HashMap};

// Cost计算函数类型定义
pub type NodeCostFunction = dyn Fn(&[(String, CostType)]) -> CostType + Sync + Send;

// 标准cost函数：把所有cost值加起来
pub fn sum_cost_function(costs: &[(String, CostType)]) -> CostType {
    costs.iter().map(|(_, cost)| *cost).sum()
}

// Extractor configuration with optional parameters
#[derive(Debug, Clone, Default)]
pub struct ExtractorConfig {
    pub time_limit: Option<f64>,
    pub verbose: Option<bool>,
    pub solver_type: Option<i32>,
}

impl ExtractorConfig {
    pub fn new() -> Self {
        Self::default()
    }
    
    pub fn with_time_limit(mut self, time_limit: f64) -> Self {
        self.time_limit = Some(time_limit);
        self
    }
    
    pub fn with_verbose(mut self, verbose: bool) -> Self {
        self.verbose = Some(verbose);
        self
    }
    
    pub fn with_solver_type(mut self, solver_type: i32) -> Self {
        self.solver_type = Some(solver_type);
        self
    }
}

pub trait BoostExtractor: Sync {
    // extract方法，必须提供cost计算函数，现在带可选配置参数
    fn extract(&self, egraph: &SerializedEgraph, roots: &[ClassType], cost_fn: &NodeCostFunction, config: Option<&ExtractorConfig>) -> ExtractionResult;

    fn boxed(self) -> Box<dyn BoostExtractor>
    where
        Self: Sized + 'static,
    {
        Box::new(self)
    }
}

pub trait MapGet<K, V> {
    fn get(&self, key: &K) -> Option<&V>;
}

impl<K, V> MapGet<K, V> for HashMap<K, V>
where
    K: Eq + std::hash::Hash,
{
    fn get(&self, key: &K) -> Option<&V> {
        HashMap::get(self, key)
    }
}

impl<K, V> MapGet<K, V> for FxHashMap<K, V>
where
    K: Eq + std::hash::Hash,
{
    fn get(&self, key: &K) -> Option<&V> {
        FxHashMap::get(self, key)
    }
}

impl<K, V> MapGet<K, V> for IndexMap<K, V>
where
    K: Eq + std::hash::Hash,
{
    fn get(&self, key: &K) -> Option<&V> {
        IndexMap::get(self, key)
    }
}



#[derive(Default, Clone)]
pub struct ExtractionResult {
    pub choices: IndexMap<ClassType, NodeType>,
    pub cost: HashMap<NodeType, CostType>,
}

#[derive(Clone, Copy)]
enum Status {
    Doing,
    Done,
}



impl ExtractionResult {

    pub fn find_shortest_cycle(&self, egraph: &SerializedEgraph, roots: &[ClassType]) -> Option<Vec<ClassType>> {
        let mut shortest_cycle: Option<Vec<ClassType>> = None;
        let mut status = IndexMap::<ClassType, Status>::default();
        let mut stack = Vec::<ClassType>::new();
        for root in roots {
            self.cycle_dfs_shortest_path(egraph, root, &mut status, &mut stack, &mut shortest_cycle);
        }
        shortest_cycle
    }

    pub fn new_empty() -> Self {
        Self {
            choices: IndexMap::<ClassType, NodeType>::default(),
            cost: HashMap::new(),
        }
    }

    pub fn new(choices:IndexMap<ClassType, NodeType>) -> Self {
        Self {
            choices: choices,
            cost: HashMap::new(),
        }
    }

    pub fn check(&self, egraph: &SerializedEgraph) {
        // should be a root
        assert!(!egraph.root_eclasses.is_empty());

        // All roots should be selected.
        for cid in egraph.root_eclasses.iter() {
            // println!("cid:{:?}",cid);
            assert!(self.choices.contains_key(cid));
        }


        // All the nodes the roots depend upon should be selected.
        let mut todo: Vec<ClassType> = egraph.root_eclasses.to_vec();
        let mut visited: FxHashSet<ClassType> = Default::default();
        while let Some(cid) = todo.pop() {
            if !visited.insert(cid.clone()) {
                continue;
            }
            assert!(self.choices.contains_key(&cid));

            for child in &egraph[(&cid,&self.choices[&cid])].children {
                todo.push(child.clone());
            }
        }


        if !self.find_cycles(&egraph, &egraph.root_eclasses).is_empty() {
            if let Some(shortest_cycle) = self.find_shortest_cycle(&egraph, &egraph.root_eclasses) {
                println!("shortest cycle: {:?}", shortest_cycle);
            }
            assert!(false);
        }
        
    }

    pub fn choose(&mut self, class_id: ClassType, node_id: NodeType) {
        self.choices.insert(class_id, node_id);
    }

    pub fn find_cycles(&self, egraph: &SerializedEgraph, roots: &[ClassType]) -> Vec<ClassType> {
        // let mut status = vec![Status::Todo; egraph.classes().len()];
        let mut status = IndexMap::<ClassType, Status>::default();
        let mut cycles = vec![];
        for root in roots {
            // let root_index = egraph.classes().get_index_of(root).unwrap();
            self.cycle_dfs(egraph, root, &mut status, &mut cycles)
        }
        cycles
    }

    fn cycle_dfs_shortest_path(
        &self,
        egraph: &SerializedEgraph,
        class_id: &ClassType,
        status: &mut IndexMap<ClassType, Status>,
        stack: &mut Vec<ClassType>, // 记录当前遍历路径
        shortest_cycle: &mut Option<Vec<ClassType>>, // 记录目前找到的最短环路径
    ) {
        match status.get(class_id).cloned() {
            Some(Status::Done) => (),
            Some(Status::Doing) => {
                // 找到环，提取完整路径
                if let Some(pos) = stack.iter().position(|x| x == class_id) {
                    let cycle = stack[pos..].to_vec();
                    // 如果还没有找到环，或当前环比之前的更短，则更新
                    if shortest_cycle.is_none() || cycle.len() < shortest_cycle.as_ref().unwrap().len() {
                        *shortest_cycle = Some(cycle);
                    }
                }
            }
            None => {
                status.insert(class_id.clone(), Status::Doing);
                stack.push(class_id.clone()); // 记录访问路径
                let node_id = &self.choices[class_id];
                let node = &egraph[(class_id,node_id)];
    
                for child in &node.children {
                    self.cycle_dfs_shortest_path(egraph, child, status, stack, shortest_cycle);
                }
    
                stack.pop(); // 回溯
                status.insert(class_id.clone(), Status::Done);
            }
        }
    }
    

    fn cycle_dfs(
        &self,
        egraph: &SerializedEgraph,
        class_id: &ClassType,
        status: &mut IndexMap<ClassType, Status>,
        cycles: &mut Vec<ClassType>,
    ) {
        match status.get(class_id).cloned() {
            Some(Status::Done) => (),
            Some(Status::Doing) => cycles.push(class_id.clone()),
            None => {
                status.insert(class_id.clone(), Status::Doing);
                let node_id = &self.choices[class_id];
                let node = &egraph[(class_id,node_id)];
                for child in &node.children {
                    // let child_cid = egraph.nid_to_cid(child);
                    self.cycle_dfs(egraph, child, status, cycles)
                }
                status.insert(class_id.clone(), Status::Done);
            }
        }
    }

    pub fn depth_cost(&self, egraph: &SerializedEgraph, roots: &[ClassType], cost_fn: &NodeCostFunction) -> CostType {
        let mut memo = HashMap::<ClassType, CostType>::new();
        roots
            .iter()
            .map(|cid| self.depth_cost_rec(egraph, cid, &mut memo, cost_fn))
            .max()
            .unwrap_or(CostType::default())
    }

    // 递归计算某个等价类的深度成本（深度），使用 memo 进行记忆化计算。
    fn depth_cost_rec(
        &self,
        egraph: &SerializedEgraph,
        cid: &ClassType,
        memo: &mut HashMap<ClassType, CostType>,
        cost_fn: &NodeCostFunction,
    ) -> CostType {
        if let Some(&cost) = memo.get(cid) {
            return cost;
        }
        let node_id = &self.choices[cid];
        let node = &egraph[(cid,node_id)];
        // 对于当前节点，成本 = 节点成本 + (其所有子节点成本的最大值)
        let child_max = node
            .children
            .iter()
            .map(|child_cid| self.depth_cost_rec(egraph, child_cid, memo, cost_fn))
            .max()
            .unwrap_or(CostType::default());
        let cost = cost_fn(&node.costs) + child_max;
        memo.insert(cid.clone(), cost);
        // println!("nid:{:?},cost:{:?}",node_id,cost);
        cost
    }

    pub fn tree_cost(&self, egraph: &SerializedEgraph, roots: &[ClassType], cost_fn: &NodeCostFunction) -> CostType {
        let node_roots = roots
            .iter()
            .map(|cid| cid.clone())
            .collect::<Vec<ClassType>>();
        self.tree_cost_rec(egraph, &node_roots, &mut HashMap::new(), cost_fn)
    }

    
    pub fn activate_nodes(&self, egraph: &SerializedEgraph, roots: &[ClassType]) -> FxHashSet<NodeType> {
        let node_roots = roots
        .iter()
        .map(|cid| cid.clone())
        .collect::<Vec<ClassType>>();
        let mut memo = FxHashSet::default();
        self.activate_nodes_rec(egraph, &node_roots, &mut memo);
        memo
    }


    fn activate_nodes_rec(
        &self,
        egraph: &SerializedEgraph,
        roots: &[ClassType],
        memo: &mut FxHashSet<NodeType>,
    ) {
        for root in roots {
            let node_id = self.choices[root];
            if let Some(_) = memo.get(&node_id) {
                continue;
            }
            let node = &egraph[(root,&node_id)];
            memo.insert(node_id);
            self.activate_nodes_rec(egraph, &node.children, memo);
        }
    }


    fn tree_cost_rec(
        &self,
        egraph: &SerializedEgraph,
        roots: &[ClassType],
        memo: &mut HashMap<ClassType, CostType>,
        cost_fn: &NodeCostFunction,
    ) -> CostType {
        let mut cost = CostType::default();
        for root in roots {
            let node_id = self.choices[root];
            if let Some(c) = memo.get(root) {
                cost += *c;
                continue;
            }
            // let class = egraph.nid_to_cid(root);
            let node = &egraph[(root,&node_id)];
            let inner = cost_fn(&node.costs) + self.tree_cost_rec(egraph, &node.children, memo, cost_fn);
            memo.insert(root.clone(), inner);
            cost += inner;
        }
        cost
    }

    // this will loop if there are cycles
    pub fn dag_cost(&self, egraph: &SerializedEgraph, roots: &[ClassType], cost_fn: &NodeCostFunction) -> CostType {
        let mut costs: IndexMap<ClassType, CostType> = IndexMap::default();
        let mut todo: Vec<ClassType> = roots.to_vec();
        while let Some(cid) = todo.pop() {
            let node_id = &self.choices[&cid];
            let node = &egraph[(&cid,node_id)];
            if costs.insert(cid.clone(), cost_fn(&node.costs)).is_some() {
                continue;
            }
            for child in &node.children {
                todo.push(child.clone());
            }
        }
        costs.values().sum()
    }

    pub fn node_sum_cost<M>(&self, node: &SerializedEnode, costs: &M, cost_fn: &NodeCostFunction) -> CostType
    where
        M: MapGet<ClassType, CostType>,
    {
        cost_fn(&node.costs)
            + node
                .children
                .iter()
                .map(|n| {
                    // let cid = egraph.nid_to_cid(n);
                    costs.get(n).unwrap_or(&INFINITY)
                })
                .sum::<CostType>()
    }

    /// Rebuild a RecExpr from the extraction result
    pub fn to_recexpr<L: Language>(&self, egraph: &SerializedEgraph, root: ClassType) -> RecExpr<L> 
    where
        L: FromOp,
    {
        let mut expr = RecExpr::default();
        let mut memo = HashMap::new();
        self.to_recexpr_rec(egraph, root, &mut expr, &mut memo);
        expr
    }

    fn to_recexpr_rec<L: Language>(
        &self,
        egraph: &SerializedEgraph,
        class_id: ClassType,
        expr: &mut RecExpr<L>,
        memo: &mut HashMap<ClassType, Id>,
    ) -> Id
    where
        L: FromOp,
    {
        if let Some(&id) = memo.get(&class_id) {
            return id;
        }

        let node_id = &self.choices[&class_id];
        let node = &egraph[(&class_id, node_id)];

        // Recursively build children
        let children: Vec<Id> = node
            .children
            .iter()
            .map(|child| self.to_recexpr_rec(egraph, *child, expr, memo))
            .collect();

        // Create the node
        let enode = L::from_op(&node.op, children).expect("Failed to create node from op");
        let id = expr.add(enode);
        
        memo.insert(class_id, id);
        id
    }
}



#[derive(PartialEq, Eq)]
pub enum Optimal {
    Tree,
    DAG,
    Neither,
}

pub struct ExtractorDetail {
    extractor: Box<dyn BoostExtractor>,
    optimal: Optimal,
    use_for_bench: bool,
}

impl ExtractorDetail {
    // Getter for `extractor`
    pub fn get_extractor(&self) -> &dyn BoostExtractor {
        &*self.extractor
    }

    // Getter for `optimal`
    pub fn get_optimal(&self) -> &Optimal {
        &self.optimal
    }

    // Getter for `use_for_bench`
    pub fn get_use_for_bench(&self) -> bool {
        self.use_for_bench
    }
}

pub fn extractors() -> IndexMap<&'static str, ExtractorDetail> {
    let mut extractors = IndexMap::default();
    
    extractors.insert(
        "faster-ast-depth",
        ExtractorDetail {
            extractor: crate::boosted_extract::faster_ast_depth::FasterAstSizeExtractor.boxed(),
            optimal: Optimal::Tree,
            use_for_bench: true,
        },
    );
    
    extractors.insert(
        "faster-ast-depth-mt",
        ExtractorDetail {
            extractor: crate::boosted_extract::faster_ast_depth_mt::FasterAstSizeExtractor.boxed(),
            optimal: Optimal::Tree,
            use_for_bench: true,
        },
    );
    
    extractors.insert(
        "faster-bottom-up",
        ExtractorDetail {
            extractor: crate::boosted_extract::faster_bottom_up::FasterBottomUpExtractor.boxed(),
            optimal: Optimal::Tree,
            use_for_bench: true,
        },
    );
    
    extractors.insert(
        "faster-bottom-up-mt",
        ExtractorDetail {
            extractor: crate::boosted_extract::faster_bottom_up_mt::FasterBottomUpExtractor.boxed(),
            optimal: Optimal::Tree,
            use_for_bench: true,
        },
    );
    
    extractors.insert(
        "faster-greedy-dag",
        ExtractorDetail {
            extractor: crate::boosted_extract::faster_greedy_dag::FasterGreedyDagExtractor.boxed(),
            optimal: Optimal::Neither,
            use_for_bench: true,
        },
    );
    
    extractors.insert(
        "faster-greedy-dag-mt",
        ExtractorDetail {
            extractor: crate::boosted_extract::faster_greedy_dag_mt::FasterGreedyDagExtractor.boxed(),
            optimal: Optimal::Neither,
            use_for_bench: true,
        },
    );
    
    // Add LP solver extractors
    #[cfg(feature = "lp-extractor")]
    {
        extractors.insert(
            "lp-cpsat",
            ExtractorDetail {
                extractor: LPExtractor::new(crate::ffi::SOLVER_CPSAT).boxed(),
                optimal: Optimal::DAG,
                use_for_bench: true,
            },
        );
        
        extractors.insert(
            "lp-gurobi",
            ExtractorDetail {
                extractor: LPExtractor::new(crate::ffi::SOLVER_GUROBI).boxed(),
                optimal: Optimal::DAG,
                use_for_bench: true,
            },
        );
        
        extractors.insert(
            "lp-cplex",
            ExtractorDetail {
                extractor: LPExtractor::new(crate::ffi::SOLVER_CPLEX).boxed(),
                optimal: Optimal::DAG,
                use_for_bench: true,
            },
        );
    }
    
    return extractors;
}

// LP Solver Extractor implementation
#[cfg(feature = "lp-extractor")]
pub struct LPExtractor {
    solver_type: i32,
}

#[cfg(feature = "lp-extractor")]
impl LPExtractor {
    pub fn new(solver_type: i32) -> Self {
        Self { solver_type }
    }
}

#[cfg(feature = "lp-extractor")]
impl BoostExtractor for LPExtractor {
    fn extract(&self, egraph: &SerializedEgraph, _roots: &[ClassType], cost_fn: &NodeCostFunction, config: Option<&ExtractorConfig>) -> ExtractionResult {
        // Extract configuration parameters
        let time_limit = config.and_then(|c| c.time_limit).unwrap_or(30.0);
        let verbose = config.and_then(|c| c.verbose).unwrap_or(false);
        
        // Call the C++ LP extractor
        match crate::ffi::call_cpp_lp_extract_with_solver(
            egraph,
            cost_fn,
            self.solver_type,
            time_limit,
            verbose,
        ) {
            Some(result) => result,
            None => {
                eprintln!("LP solver failed, returning empty result");
                ExtractionResult::new_empty()
            }
        }
    }
}
