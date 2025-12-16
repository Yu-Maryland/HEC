// Calculates the cost where shared nodes are just costed once,
// For example (+ (* x x ) (* x x )) has one mulitplication
// included in the cost.

use crate::*;
use rustc_hash::{FxHashMap, FxHashSet};
use std::sync::Arc;
use dashmap::DashMap;
use rayon::prelude::*;
use boosted_extract::extractor::*;


#[derive(Clone, Debug)]
struct CostSet {
    // It's slightly faster if this is an HashMap rather than an fxHashMap.
    costs: HashMap<ClassType, CostType>,
    total: CostType,
    choice: NodeType,
}

pub struct FasterGreedyDagExtractor;

impl FasterGreedyDagExtractor {
    fn calculate_cost_set(
        egraph: &SerializedEgraph,
        class_id: ClassType,
        node_id: NodeType,
        costs: &Arc<DashMap<ClassType, Arc<CostSet>>>,
        best_cost: CostType,
        cost_fn: &NodeCostFunction,
    ) -> Arc<CostSet> {
        let node = &egraph[(&class_id, &node_id)];
        let cid = class_id;

        if node.children.is_empty() {
            let mut costs_map = HashMap::default();
            costs_map.insert(cid.clone(), cost_fn(&node.costs));
            return Arc::new(CostSet {
                costs: costs_map,
                total: cost_fn(&node.costs),
                choice: node_id.clone(),
            });
        }

        // Get unique classes of children.
        let mut childrens_classes = node.children.clone();
        childrens_classes.sort();
        childrens_classes.dedup();

        // 预先获取所有需要的数据，减少锁操作
        let mut child_costs = Vec::with_capacity(childrens_classes.len());
        for child_cid in &childrens_classes {
            if let Some(cost) = costs.get(child_cid) {
                child_costs.push((child_cid.clone(), cost.clone()));
            }
        }

        // 确保所有子节点都有对应的成本
        if child_costs.len() != childrens_classes.len() {
            return Arc::new(CostSet {
                costs: Default::default(),
                total: INFINITY,
                choice: node_id.clone(),
            });
        }

        let first_cost = &child_costs[0].1;
        if childrens_classes.contains(&cid)
            || (childrens_classes.len() == 1 && (cost_fn(&node.costs) + first_cost.total > best_cost))
        {
            // Shortcut. Can't be cheaper so return junk.
            return Arc::new(CostSet {
                costs: Default::default(),
                total: INFINITY,
                choice: node_id.clone(),
            });
        }

        // 使用本地数据查找最大的集合
        let (id_of_biggest, _) = child_costs.iter().max_by_key(|(_, cost)| cost.costs.len()).unwrap();
        let biggest_idx = child_costs.iter().position(|(cid, _)| cid == id_of_biggest).unwrap();
        let mut result = child_costs[biggest_idx].1.costs.clone();

        for (child_cid, cost) in &child_costs {
            if child_cid == id_of_biggest {
                continue;
            }
            for (key, value) in cost.costs.iter() {
                result.insert(key.clone(), value.clone());
            }
        }

        let contains = result.contains_key(&cid);
        result.insert(cid.clone(), cost_fn(&node.costs));

        let result_cost = if contains {
            INFINITY
        } else {
            result.values().sum()
        };

        Arc::new(CostSet {
            costs: result,
            total: result_cost,
            choice: node_id.clone(),
        })
    }
}

fn process_item(
    egraph: &SerializedEgraph,
    class_id: ClassType,
    node_id: NodeType,
    costs: &Arc<DashMap<ClassType, Arc<CostSet>>>,
    cost_fn: &NodeCostFunction,
) -> (FxHashMap<ClassType, Arc<CostSet>>, CostType, NodeType) {
    let node = &egraph[(&class_id, &node_id)];
    let mut should_insert = FxHashMap::default();
    let mut total = INFINITY;
    if node.children.iter().all(|c| costs.contains_key(c)) {
        let lookup = costs.get(&class_id);
        let mut prev_cost = INFINITY;
        if lookup.is_some() {
            prev_cost = lookup.unwrap().total;
        }
        let cost_set = FasterGreedyDagExtractor::calculate_cost_set(egraph, class_id, node_id, &costs, prev_cost, cost_fn);
        total = cost_set.total;
        if cost_set.total < prev_cost {
            should_insert.insert(class_id.clone(), cost_set);
        }
    }
    (should_insert, total, node_id.clone())
}

impl BoostExtractor for FasterGreedyDagExtractor {
    fn extract(&self, egraph: &SerializedEgraph, _roots: &[ClassType], cost_fn: &NodeCostFunction, _config: Option<&ExtractorConfig>) -> ExtractionResult {
        // 构造每个等价类对应的父节点列表
        let mut parents = IndexMap::<ClassType, Vec<(ClassType,NodeType)>>::with_capacity_and_hasher(egraph.nodes.len(), Default::default());
        let mut analysis_pending = UniqueQueue::<(ClassType, NodeType)>::default();

        let costs_all: Arc<DashMap<ClassType, Arc<CostSet>>> = Arc::new(DashMap::with_capacity_and_hasher(
            egraph.nodes.len(), Default::default()));

        for class in egraph.nodes.keys() {
            parents.insert(class.clone(), Vec::new());
        }

        // 遍历所有节点，建立子节点到父节点的映射，并将叶节点加入待分析队列
        for (cid,nodes) in egraph.nodes.iter() {
            for (nid,node) in nodes.iter() {
                for child in nodes[nid].children.clone() {
                    parents[&child].push((cid.clone(),nid.clone()));
                }
                if node.is_leaf() {
                    analysis_pending.insert((cid.clone(),nid.clone()));
                }
            }
        }


        // let arc_queue = Arc::new(Mutex::new(analysis_pending));


        let mut result = ExtractionResult::default();

        // while !arc_queue.lock().unwrap().is_empty() {


        for i in 0..5 {
            for (cid, nodes) in egraph.nodes.iter() {
                for (nid, node) in nodes.iter() {
                    if i == 0 {
                        if node.is_leaf() {
                            analysis_pending.insert((cid.clone(), nid.clone()));
                        }
                    } else {
                        analysis_pending.insert((cid.clone(), nid.clone()));
                    }
                }
            }

            while !analysis_pending.is_empty() {
                let vec_node_id = analysis_pending.pop_32();

                let costs_all_clone = Arc::clone(&costs_all);

                let should_insert: Vec<_> = vec_node_id.into_par_iter().map(|(class_id, node_id)| {
                    let costs_all = Arc::clone(&costs_all_clone);
                    process_item(egraph, class_id, node_id, &costs_all, cost_fn)
                }).collect();



                let mut grouped: FxHashMap<ClassType, Arc<CostSet>> = FxHashMap::default();
                should_insert.into_iter().for_each(|map| {
                    for (key, value) in map.0 {
                        if value.total != INFINITY {
                            grouped.entry(key)
                                .and_modify(|existing| {
                                    if value.total < existing.total {
                                        *existing = value.clone();
                                    }
                                })
                                .or_insert(value);
                        }
                    }
                    match result.cost.get(&map.2) {
                        Some(existing) if map.1 < *existing => {
                            result.cost.insert(map.2, map.1);
                        }
                        None => {
                            result.cost.insert(map.2, map.1);
                        }
                        _ => {}
                    }
                });
                for (cid, cost_set) in grouped {
                    costs_all.insert(cid, cost_set);
                    analysis_pending.extend(parents[&cid].iter().cloned());
                }
            }
        }


        for entry in costs_all.iter() {
            let cid = entry.key();
            let cost_set = entry.value();
            result.choose(cid.clone(), cost_set.choice);
        }
        result
    }
}

/** A data structure to maintain a queue of unique elements.

Notably, insert/pop operations have O(1) expected amortized runtime complexity.

Thanks @Bastacyclop for the implementation!
*/
#[derive(Clone)]
#[cfg_attr(feature = "serde-1", derive(Serialize, Deserialize))]
pub(crate) struct UniqueQueue<T>
where
    T: Eq + std::hash::Hash + Clone,
{
    set: FxHashSet<T>, // hashbrown::
    queue: std::collections::VecDeque<T>,
}

impl<T> Default for UniqueQueue<T>
where
    T: Eq + std::hash::Hash + Clone,
{
    fn default() -> Self {
        UniqueQueue {
            set: Default::default(),
            queue: std::collections::VecDeque::new(),
        }
    }
}

impl<T> UniqueQueue<T>
where
    T: Eq + std::hash::Hash + Clone,
{
    pub fn insert(&mut self, t: T) {
        if self.set.insert(t.clone()) {
            self.queue.push_back(t);
        }
    }

    pub fn extend<I>(&mut self, iter: I)
    where
        I: IntoIterator<Item = T>,
    {
        for t in iter.into_iter() {
            self.insert(t);
        }
    }

    pub fn pop(&mut self) -> Option<T> {
        let res = self.queue.pop_front();
        res.as_ref().map(|t| self.set.remove(t));
        res
    }

    pub fn pop_32(&mut self) -> Vec<T> {
        let k = 16384;
        let mut popped_items = Vec::with_capacity(k);
        
        for _ in 0..k {
            if let Some(item) = self.queue.pop_front() {
                self.set.remove(&item);
                popped_items.push(item);
            } else {
                break; // 队列已空，退出循环
            }
        }
        
        popped_items
    }

    #[allow(dead_code)]
    pub fn is_empty(&self) -> bool {
        let r = self.queue.is_empty();
        debug_assert_eq!(r, self.set.is_empty());
        r
    }
}