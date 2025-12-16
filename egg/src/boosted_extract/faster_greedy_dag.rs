// Calculates the cost where shared nodes are just costed once,
// For example (+ (* x x ) (* x x )) has one mulitplication
// included in the cost.

use crate::*;
use rustc_hash::{FxHashMap, FxHashSet};
use boosted_extract::extractor::*;

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
        costs: &FxHashMap<ClassType, CostSet>,
        best_cost: CostType,
        cost_fn: &NodeCostFunction,
    ) -> CostSet {
        let node = &egraph[(&class_id, &node_id)];
        let cid = class_id;

        if node.children.is_empty() {
            let mut costs_map = HashMap::default();
            costs_map.insert(cid.clone(), cost_fn(&node.costs));
            return CostSet {
                costs: costs_map,
                total: cost_fn(&node.costs),
                choice: node_id.clone(),
            };
        }

        // Get unique classes of children.
        let mut childrens_classes = node
            .children.clone();
        childrens_classes.sort();
        childrens_classes.dedup();

        let first_cost = costs.get(&childrens_classes[0]).unwrap();

        if childrens_classes.contains(&cid)
            || (childrens_classes.len() == 1 && (cost_fn(&node.costs) + first_cost.total > best_cost))
        {
            // Shortcut. Can't be cheaper so return junk.
            return CostSet {
                costs: Default::default(),
                total: INFINITY,
                choice: node_id.clone(),
            };
        }

        // Clone the biggest set and insert the others into it.
        let id_of_biggest = childrens_classes
            .iter()
            .max_by_key(|s| costs.get(s).unwrap().costs.len())
            .unwrap();
        let mut result = costs.get(&id_of_biggest).unwrap().costs.clone();
        for child_cid in &childrens_classes {
            if child_cid == id_of_biggest {
                continue;
            }

            let next_cost = &costs.get(child_cid).unwrap().costs;
            for (key, value) in next_cost.iter() {
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

        return CostSet {
            costs: result,
            total: result_cost,
            choice: node_id.clone(),
        };
    }
}

impl BoostExtractor for FasterGreedyDagExtractor {
    fn extract(&self, egraph: &SerializedEgraph, _roots: &[ClassType], cost_fn: &NodeCostFunction, _config: Option<&ExtractorConfig>) -> ExtractionResult {
        // 构造每个等价类对应的父节点列表
        let mut parents = IndexMap::<ClassType, Vec<(ClassType,NodeType)>>::with_capacity_and_hasher(egraph.nodes.len(), Default::default());
        let mut analysis_pending = UniqueQueue::<(ClassType, NodeType)>::default();

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

        let mut result = ExtractionResult::default();
        let mut costs = FxHashMap::<ClassType, CostSet>::with_capacity_and_hasher(
            egraph.nodes.len(),
            Default::default(),
        );

        while let Some((class_id, node_id)) = analysis_pending.pop() {
            let node = &egraph[(&class_id, &node_id)];
            if node.children.iter().all(|c| costs.contains_key(c)) {
                let lookup = costs.get(&class_id);
                let mut prev_cost = INFINITY;
                if lookup.is_some() {
                    prev_cost = lookup.unwrap().total;
                }

                let cost_set = Self::calculate_cost_set(egraph, class_id, node_id, &costs, prev_cost, cost_fn);
                match result.cost.get(&node_id) {
                    Some(existing) if cost_set.total < *existing => {
                        result.cost.insert(node_id, cost_set.total);
                    }
                    None => {
                        result.cost.insert(node_id, cost_set.total);
                    }
                    _ => {}
                }
                if cost_set.total < prev_cost {
                    costs.insert(class_id.clone(), cost_set);
                    analysis_pending.extend(parents[&class_id].iter().cloned());
                }
            }
        }

        for (cid, cost_set) in costs {
            result.choose(cid, cost_set.choice);
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

    #[allow(dead_code)]
    pub fn is_empty(&self) -> bool {
        let r = self.queue.is_empty();
        debug_assert_eq!(r, self.set.is_empty());
        r
    }
}