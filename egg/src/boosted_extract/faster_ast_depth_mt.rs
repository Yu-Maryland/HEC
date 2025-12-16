use rustc_hash::{FxHashMap, FxHashSet};
use dashmap::DashMap;
use std::sync::Arc;
use rayon::prelude::*;
use crate::*;
use boosted_extract::extractor::*;
/// 一个基于 AST 大小（节点总数）的快速提取器
pub struct FasterAstSizeExtractor;

impl BoostExtractor for FasterAstSizeExtractor {
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

        let costs_all: Arc<DashMap<ClassType, (NodeType,CostType)>> = Arc::new(DashMap::with_capacity_and_hasher(
            egraph.nodes.len(), Default::default()));

        while !analysis_pending.is_empty() {
            let vec_node_id = analysis_pending.pop_32();
            let costs_all_clone: Arc<DashMap<ClassType, (NodeType,CostType)>> = Arc::clone(&costs_all);
            let should_insert: Vec<_> = vec_node_id.into_par_iter().map(|(class_id, node_id)| {
                let costs_all = Arc::clone(&costs_all_clone);
                let node = &egraph[(&class_id,&node_id)];
                let prev_cost = costs_all
                    .get(&class_id)
                    .map(|r| r.1)
                    .unwrap_or(INFINITY);
                let child_max_cost = node
                    .children
                    .iter()
                    .fold(CostType::default(),|max,child_id| {
                        max.max(costs_all_clone.get(&child_id).map(|r| r.1).unwrap_or(INFINITY))
                    });
                let cost = cost_fn(&node.costs) + child_max_cost;
                if cost < prev_cost {
                    (cost, (class_id, node_id))
                } else {
                    (INFINITY, (class_id, node_id))
                }
            }).collect();
            let mut grouped: FxHashMap<ClassType, (NodeType,CostType)> = FxHashMap::default();
            should_insert.into_iter().for_each(|map| {
                let (class_id, node_id) = map.1;
                let value = map.0;
                if value != INFINITY {
                    grouped.entry(class_id)
                        .and_modify(|existing| {
                            if value < existing.1 {
                                *existing = (node_id,value);
                            }
                        })
                        .or_insert((node_id,value));
                }
            });
            for (cid, cost_set) in grouped {
                costs_all.insert(cid, cost_set);
                analysis_pending.extend(parents[&cid].iter().cloned());
            }
        }
        for entry in costs_all.iter() {
            let cid = entry.key();
            let cost_set = entry.value();
            result.choose(cid.clone(), cost_set.0);
        }
        
        result
    }
}

/// 保证队列中元素唯一的队列结构，实现了 O(1) 期望均摊插入/弹出复杂度。
#[derive(Clone)]
#[cfg_attr(feature = "serde-1", derive(Serialize, Deserialize))]
pub(crate) struct UniqueQueue<T>
where
    T: Eq + std::hash::Hash + Clone,
{
    set: FxHashSet<T>,
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
        for t in iter {
            self.insert(t);
        }
    }

    pub fn pop(&mut self) -> Option<T> {
        let res = self.queue.pop_front();
        res.as_ref().map(|t| self.set.remove(t));
        res
    }

    pub fn pop_32(&mut self) -> Vec<T> {
        let k = 4096*2;
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
