use core::default::Default;
use std::path::Path;
use std::fs;
use std::collections::HashSet;
use crate::HashMap;
use json5;
use crate::{ClassType,NodeType,CostType,NCost};
use ordered_float::NotNan;



#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct SerializedEnode {
    pub op: String,
    pub costs: Vec<(String, CostType)>, // 支持多个命名的cost属性
    pub children: Vec<ClassType>,
    pub id: String,
}

type SerializedEclass = HashMap<NodeType, SerializedEnode>;

pub type EnodeMap = HashMap<ClassType, SerializedEclass>;


#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct SerializedEgraphRaw {
    pub nodes: HashMap<String, HashMap<String, SerializedEnode>>,
    pub root_eclasses: Vec<ClassType>,
}

#[derive(Debug, Clone, serde::Serialize, serde::Deserialize)]
pub struct SerializedEgraph {
    pub nodes: EnodeMap,
    pub root_eclasses: Vec<ClassType>,
}

impl SerializedEnode {
    pub fn new() -> Self{
        SerializedEnode {
            op:String::new(),
            costs:Vec::new(),
            children:Vec::new(),
            id:String::new(),
        }
    }
    
    // 添加便捷方法获取特定名称的cost
    pub fn get_cost(&self, cost_name: &str) -> Option<CostType> {
        self.costs.iter()
            .find(|(name, _)| name == cost_name)
            .map(|(_, cost)| *cost)
    }
    
    // 为向后兼容，添加获取第一个cost的方法
    pub fn get_default_cost(&self) -> CostType {
        self.costs.first()
            .map(|(_, cost)| *cost)
            .unwrap_or(NotNan::new(1.0).unwrap())
    }
}

impl SerializedEnode {
    pub fn is_leaf(&self) -> bool {
        self.children.is_empty()
    }
}

impl SerializedEgraph {
    pub fn new() -> Self {
        SerializedEgraph {
            nodes: HashMap::default(),
            root_eclasses: Vec::new(),
        }
    }

    pub fn add_node(&mut self, node: SerializedEnode) -> ClassType {
        let cid = self.nodes.keys().max().unwrap_or(&u32::MAX) + 1;
        let mut class = HashMap::default();
        class.insert(0, node);
        self.nodes.insert(cid, class);
        cid
    }

    pub fn remove_unreachable_enodes(&mut self) -> (usize, usize) {
        use std::collections::HashSet;

        // 1) 基线统计
        let before_classes = self.nodes.len();
        let before_nodes: usize = self.nodes.values().map(|m| m.len()).sum();

        // 2) 计算从 roots 可达的 eclass 集
        let mut seen: HashSet<ClassType> = HashSet::new();
        let mut stack: Vec<ClassType> = self.root_eclasses.clone();

        while let Some(c) = stack.pop() {
            if !seen.insert(c) {
                continue;
            }
            if let Some(nodes) = self.nodes.get(&c) {
                for (_nid, node) in nodes {
                    for &child in &node.children {
                        if !seen.contains(&child) {
                            stack.push(child);
                        }
                    }
                }
            }
        }

        // 3) 只保留可达的 eclass
        self.nodes.retain(|class_id, _| seen.contains(class_id));

        // 同步清理 root_eclasses（防止有无效 root）
        self.root_eclasses.retain(|c| seen.contains(c));

        // 4) 统计差值
        let after_classes = self.nodes.len();
        let after_nodes: usize = self.nodes.values().map(|m| m.len()).sum();

        (before_nodes - after_nodes, before_classes - after_classes)
    }

    pub fn from_json_str(json_str: &str) -> Result<Self, Box<dyn std::error::Error>> {
        let json_data_raw: SerializedEgraphRaw = json5::from_str(json_str)?;
        Ok(json_data_raw.into())
    }

    pub fn from_json_file<P: AsRef<Path>>(path: P) -> Result<Self, Box<dyn std::error::Error>> {
        let content = fs::read_to_string(path)?;
        Self::from_json_str(&content)
    }

    pub fn to_json_file(&self,path:impl AsRef<std::path::Path>) -> std::io::Result<()> {
        let json_str = Self::to_json_str(&self)?;
        std::fs::write(path,json_str)
    }

    pub fn to_json_str(&self) -> Result<String, serde_json::Error> {
        serde_json::to_string_pretty(self)
    }

    pub fn parents_map(&self) -> HashMap<ClassType, Vec<(ClassType, NodeType)>> {
        let mut parents = HashMap::default();
        for (class_id, nodes) in &self.nodes {
            for (node_id, node) in nodes {
                for child_class in &node.children {
                    if !parents.contains_key(child_class) {
                        parents.insert(*child_class, vec![(*class_id, *node_id)]);
                    } else {
                        parents.get_mut(child_class).unwrap().push((*class_id, *node_id));
                    }
                }
            }
        }
        parents
    }

    pub fn op_nodes(&self,op:&str) -> Vec<(ClassType, NodeType)> {
        let mut op_nodes = Vec::new();
        for (class_id, nodes) in &self.nodes {
            for (node_id, node) in nodes {
                if node.op == op {
                    op_nodes.push((*class_id, *node_id));
                }
            }
        }
        op_nodes
    }

    pub fn forarg_nodes(&self) -> HashMap<String, (ClassType, NodeType)> {
        let mut op_nodes = HashMap::default();
        for (class_id, nodes) in &self.nodes {
            for (node_id, node) in nodes {
                if node.op.starts_with("variable%forarg") {
                    if !op_nodes.contains_key(&node.op) {
                        op_nodes.insert(node.op.clone(), (*class_id, *node_id));
                    } else {
                        panic!("{} already exists", node.op);
                    }
                }
            }
        }
        op_nodes
    }

    pub fn compute_fc_depths(&self) -> HashMap<(ClassType, NodeType), i64> {    
        let parents_by_class = self.parents_map(); // child_class -> Vec<(parent_class, parent_node)>
        let all_fc: Vec<(ClassType, NodeType)> = self.op_nodes("forcontrol");
    
        // 状态与结果
        let mut gray: HashSet<(ClassType, NodeType)> = HashSet::new();   // 在栈中
        let mut black: HashSet<(ClassType, NodeType)> = HashSet::new();  // 已完成
        let mut depth: HashMap<(ClassType, NodeType), i64> = HashMap::default();
    
        // 小工具
        let is_fc = |k: (ClassType, NodeType)| self.nodes.get(&k.0).unwrap().get(&k.1).unwrap().op == "forcontrol";
        let parents_of = |k: (ClassType, NodeType)| -> Vec<(ClassType, NodeType)> {
            parents_by_class.get(&k.0).cloned().unwrap_or_default()
        };
    
        // 迭代式“DFS”，只从 fc-enode 出发；过程中会给非 fc 也算 depth（中间态）
        for fc in all_fc.iter().copied() {
            if black.contains(&fc) { continue; }
    
            // 栈元素：(key, next_parent_idx, parents_vec, collected_parent_depths)
            let mut stack: Vec<((ClassType, NodeType), usize, Vec<(ClassType, NodeType)>, Vec<i64>)> =
                vec![(fc, 0, parents_of(fc), Vec::new())];
            let mut path: Vec<(ClassType, NodeType)> = vec![fc];
            gray.insert(fc);
    
            while let Some(top) = stack.last_mut() {
                let (key, p_idx, parents, pdepths) = top;
    
                if *p_idx < parents.len() {
                    let p = parents[*p_idx];
    
                    if black.contains(&p) {
                        pdepths.push(*depth.get(&p).expect("parent depth missing"));
                        *p_idx += 1;
                    } else if gray.contains(&p) {
                        // 回边：环段内不允许出现 fc
                        if let Some(pos) = path.iter().rposition(|&x| x == p) {
                            for &z in &path[pos..] {
                                assert!(!is_fc(z), "cycle contains a forcontrol enode: {:?}", z);
                            }
                        }
                        pdepths.push(-1);
                        *p_idx += 1;
                    } else {
                        stack.push((p, 0, parents_of(p), Vec::new()));
                        gray.insert(p);
                        path.push(p);
                    }
                } else {
                    // 聚合父深度
                    let my_depth = if parents.is_empty() {
                        // 根（没有任何父 enode）：基线 0
                        if is_fc(*key) { 1 } else { 0 }
                    } else {
                        // 去掉 -1，只看非环父的深度并断言一致
                        let nonneg: Vec<i64> = pdepths.iter().copied().filter(|&d| d >= 0).collect();
                        if nonneg.is_empty() {
                            // 全是环：本节点不能是 fc
                            assert!(!is_fc(*key),
                                    "All parents are cyclic (-1) but node is forcontrol {:?}", key);
                            -1
                        } else {
                            let base = nonneg[0];
                            assert!(nonneg.iter().all(|&d| d == base),
                                          "parent depths disagree for {:?}: {:?}", key, nonneg);
                            if is_fc(*key) { base + 1 } else { base }
                        }
                    };
    
                    depth.insert(*key, my_depth);
                    black.insert(*key);
                    gray.remove(key);
    
                    let popped = stack.pop().unwrap().0;
                    if let Some(pos) = path.iter().rposition(|&x| x == popped) {
                        path.remove(pos);
                    }
                }
            }
        }
    
        // 只返回 fc-enode 的 depth
        let mut out: HashMap<(ClassType, NodeType), i64> = HashMap::default();
        for k in all_fc {
            if let Some(&d) = depth.get(&k) {
                out.insert(k, d);
            }
        }
        out
    }
}

impl From<SerializedEgraphRaw> for SerializedEgraph {
    fn from(raw: SerializedEgraphRaw) -> Self {
        let mut nodes = HashMap::default();
        
        for (eclass_id_str, enode_map_raw) in raw.nodes {
            let eclass_id: ClassType = eclass_id_str.parse().expect("Invalid eclass_id");
            let mut enode_map = HashMap::default();
            
            for (enode_id_str, json_node) in enode_map_raw {
                let enode_id: NodeType = enode_id_str.parse().expect("Invalid enode_id");
                enode_map.insert(enode_id, json_node);
            }
            
            nodes.insert(eclass_id, enode_map);
        }
        
        SerializedEgraph {
            nodes,
            root_eclasses: raw.root_eclasses,
        }
    }
}



impl std::ops::Index<(&ClassType,&NodeType)> for SerializedEgraph {
    type Output = SerializedEnode;

    fn index(&self, index: (&ClassType,&NodeType)) -> &Self::Output {
        self.nodes
            .get(index.0)
            .unwrap_or_else(|| panic!("No class with id {:?}", index.0))
            .get(index.1)
            .unwrap_or_else(|| panic!("No node with id {:?} in class {:?}", index.1, index.0))

    }
}

impl std::ops::Index<&ClassType> for SerializedEgraph {
    type Output = SerializedEclass;

    fn index(&self, index: &ClassType) -> &Self::Output {
        self.nodes
            .get(index)
            .unwrap_or_else(|| panic!("No class with id {:?}", index))
    }
}

/// EGraph analyzer for preprocessing optimizations and cycle detection
pub struct EGraphAnalyzer;

impl EGraphAnalyzer {
    /// Check if the egraph contains cycles using DFS
    pub fn has_cycles(egraph: &SerializedEgraph) -> bool {
        let mut visited = HashSet::new();
        let mut rec_stack = HashSet::new();
        
        for root_class in &egraph.root_eclasses {
            if Self::has_cycles_dfs(egraph, root_class, &mut visited, &mut rec_stack) {
                return true;
            }
        }
        false
    }
    
    /// DFS helper for cycle detection
    fn has_cycles_dfs(
        egraph: &SerializedEgraph,
        class_id: &ClassType,
        visited: &mut HashSet<ClassType>,
        rec_stack: &mut HashSet<ClassType>,
    ) -> bool {
        if rec_stack.contains(class_id) {
            return true; // Found cycle
        }
        if visited.contains(class_id) {
            return false; // Already processed
        }
        
        visited.insert(*class_id);
        rec_stack.insert(*class_id);
        
        // Check all nodes in this class
        if let Some(nodes) = egraph.nodes.get(class_id) {
            for (_, node) in nodes {
                for child_class in &node.children {
                    if Self::has_cycles_dfs(egraph, child_class, visited, rec_stack) {
                        return true;
                    }
                }
            }
        }
        
        rec_stack.remove(class_id);
        false
    }
    
    /// Remove self-loops from the egraph
    pub fn remove_self_loops(egraph: &mut SerializedEgraph) -> usize {
        let mut removed = 0;
        
        for (class_id, nodes) in &mut egraph.nodes {
            let mut nodes_to_remove = Vec::new();
            
            for (node_id, node) in nodes.iter() {
                if node.children.contains(class_id) {
                    nodes_to_remove.push(*node_id);
                    removed += 1;
                }
            }
            
            for node_id in nodes_to_remove {
                nodes.remove(&node_id);
            }
        }
        
        removed
    }
    
    /// Get reachable classes from roots
    pub fn get_reachable_classes(egraph: &SerializedEgraph) -> HashSet<ClassType> {
        let mut reachable = HashSet::new();
        
        for root_class in &egraph.root_eclasses {
            Self::mark_reachable(egraph, root_class, &mut reachable);
        }
        
        reachable
    }
    
    /// Mark reachable classes recursively
    fn mark_reachable(
        egraph: &SerializedEgraph,
        class_id: &ClassType,
        reachable: &mut HashSet<ClassType>,
    ) {
        if reachable.contains(class_id) {
            return;
        }
        
        reachable.insert(*class_id);
        
        if let Some(nodes) = egraph.nodes.get(class_id) {
            for (_, node) in nodes {
                for child_class in &node.children {
                    Self::mark_reachable(egraph, child_class, reachable);
                }
            }
        }
    }
    
    /// Remove unreachable classes
    pub fn remove_unreachable_classes(egraph: &mut SerializedEgraph) -> usize {
        let reachable = Self::get_reachable_classes(egraph);
        let initial_size = egraph.nodes.len();
        
        egraph.nodes.retain(|class_id, _| reachable.contains(class_id));
        
        initial_size - egraph.nodes.len()
    }
    
    /// Find zero-cost leaf nodes that can be optimized
    pub fn find_zero_cost_leaves(egraph: &SerializedEgraph, cost_name: &str) -> Vec<(ClassType, NodeType)> {
        let mut zero_cost_leaves = Vec::new();
        
        for (class_id, nodes) in &egraph.nodes {
            for (node_id, node) in nodes {
                if node.children.is_empty() {
                    if let Some(cost) = node.get_cost(cost_name) {
                        if cost.into_inner() == 0.0 {
                            zero_cost_leaves.push((*class_id, *node_id));
                        }
                    }
                }
            }
        }
        
        zero_cost_leaves
    }
    
    /// Remove single zero-cost leaf nodes
    pub fn remove_single_zero_cost(egraph: &mut SerializedEgraph, cost_name: &str) -> usize {
        let mut removed_classes = HashSet::new();
        
        // Find classes with single zero-cost leaf nodes
        for (class_id, nodes) in &egraph.nodes {
            if nodes.len() == 1 {
                let (_, node) = nodes.iter().next().unwrap();
                if node.children.is_empty() {
                    if let Some(cost) = node.get_cost(cost_name) {
                        if cost.into_inner() == 0.0 && !egraph.root_eclasses.contains(class_id) {
                            removed_classes.insert(*class_id);
                        }
                    }
                }
            }
        }
        
        // Remove references to these classes from other nodes
        for (_, nodes) in &mut egraph.nodes {
            for (_, node) in nodes.iter_mut() {
                node.children.retain(|child| !removed_classes.contains(child));
            }
        }
        
        // Remove the classes themselves
        let removed_count = removed_classes.len();
        egraph.nodes.retain(|class_id, _| !removed_classes.contains(class_id));
        
        removed_count
    }
    
    /// Remove high-cost nodes based on a threshold
    pub fn remove_high_cost_nodes(egraph: &mut SerializedEgraph, cost_name: &str, threshold: NCost) -> usize {
        let mut removed = 0;
        
        for (_, nodes) in &mut egraph.nodes {
            let mut nodes_to_remove = Vec::new();
            
            for (node_id, node) in nodes.iter() {
                if let Some(cost) = node.get_cost(cost_name) {
                    if cost.into_inner() > threshold {
                        nodes_to_remove.push(*node_id);
                        removed += 1;
                    }
                }
            }
            
            for node_id in nodes_to_remove {
                nodes.remove(&node_id);
            }
        }
        
        removed
    }
    
    /// Estimate problem complexity
    pub fn estimate_complexity(egraph: &SerializedEgraph) -> (usize, usize, bool) {
        let total_classes = egraph.nodes.len();
        let total_nodes: usize = egraph.nodes.values()
            .map(|nodes| nodes.len())
            .sum();
        let has_cycles = Self::has_cycles(egraph);
        
        (total_classes, total_nodes, has_cycles)
    }
    
    /// Apply all preprocessing optimizations
    pub fn preprocess_egraph(
        egraph: &mut SerializedEgraph,
        cost_name: &str,
        remove_self_loops: bool,
        remove_unreachable: bool,
        remove_zero_cost: bool,
        high_cost_threshold: Option<NCost>,
        verbose: bool,
    ) -> PreprocessingStats {
        let mut stats = PreprocessingStats::default();
        
        if verbose {
            println!("=== EGraph Preprocessing ===");
            println!("Initial: {} classes, {} nodes total", 
                    egraph.nodes.len(), 
                    egraph.nodes.values().map(|n| n.len()).sum::<usize>());
        }
        
        if remove_self_loops {
            let removed = Self::remove_self_loops(egraph);
            stats.self_loops_removed = removed;
            if verbose {
                println!("Removed {} self-loop nodes", removed);
            }
        }
        
        if remove_unreachable {
            let removed = Self::remove_unreachable_classes(egraph);
            stats.unreachable_classes_removed = removed;
            if verbose {
                println!("Removed {} unreachable classes", removed);
            }
        }
        
        if remove_zero_cost {
            let removed = Self::remove_single_zero_cost(egraph, cost_name);
            stats.zero_cost_nodes_removed = removed;
            if verbose {
                println!("Removed {} single zero-cost classes", removed);
            }
        }
        
        if let Some(threshold) = high_cost_threshold {
            let removed = Self::remove_high_cost_nodes(egraph, cost_name, threshold);
            stats.high_cost_nodes_removed = removed;
            if verbose {
                println!("Removed {} high-cost nodes (threshold: {})", removed, threshold);
            }
        }
        
        // Final complexity analysis
        let (classes, nodes, has_cycles) = Self::estimate_complexity(egraph);
        stats.final_classes = classes;
        stats.final_nodes = nodes;
        stats.has_cycles = has_cycles;
        
        stats
    }
}

/// Statistics from preprocessing operations
#[derive(Debug, Default)]
pub struct PreprocessingStats {
    pub self_loops_removed: usize,
    pub unreachable_classes_removed: usize,
    pub zero_cost_nodes_removed: usize,
    pub high_cost_nodes_removed: usize,
    pub final_classes: usize,
    pub final_nodes: usize,
    pub has_cycles: bool,
}
