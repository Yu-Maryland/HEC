use crate::*;
use crate::json::*;
use core::{default::Default, option::Option::{self, Some}};
use std::{
    borrow::BorrowMut,
    fmt::{self, Debug, Display},
    marker::PhantomData,
};
use ordered_float::NotNan;
use hashbrown::HashSet;
#[cfg(feature = "serde-1")]
use serde::{Deserialize, Serialize};
use std::path::Path;
use std::fs;
use log::*;


/** A data structure to keep track of equalities between expressions.

Check out the [background tutorial](crate::tutorials::_01_background)
for more information on e-graphs in general.

# E-graphs in `egg`

In `egg`, the main types associated with e-graphs are
[`EGraph`], [`EClass`], [`Language`], and [`Id`].

[`EGraph`] and [`EClass`] are all generic over a
[`Language`], meaning that types actually floating around in the
egraph are all user-defined.
In particular, the e-nodes are elements of your [`Language`].
[`EGraph`]s and [`EClass`]es are additionally parameterized by some
[`Analysis`], abritrary data associated with each e-class.

Many methods of [`EGraph`] deal with [`Id`]s, which represent e-classes.
Because eclasses are frequently merged, many [`Id`]s will refer to the
same e-class.

You can use the `egraph[id]` syntax to get an [`EClass`] from an [`Id`], because
[`EGraph`] implements
`Index` and `IndexMut`.

Enabling the `serde-1` feature on this crate will allow you to
de/serialize [`EGraph`]s using [`serde`](https://serde.rs/).
You must call [`EGraph::rebuild`] after deserializing an e-graph!

[`add`]: EGraph::add()
[`union`]: EGraph::union()
[`rebuild`]: EGraph::rebuild()
[equivalence relation]: https://en.wikipedia.org/wiki/Equivalence_relation
[congruence relation]: https://en.wikipedia.org/wiki/Congruence_relation
[dot]: Dot
[extract]: Extractor
[sound]: https://itinerarium.github.io/phoneme-synthesis/?w=/'igraf/
**/
#[derive(Clone)]
#[cfg_attr(feature = "serde-1", derive(Serialize, Deserialize))]
pub struct EGraph<L: Language, N: Analysis<L>> {
    /// The `Analysis` given when creating this `EGraph`.
    pub analysis: N,
    /// The `Explain` used to explain equivalences in this `EGraph`.
    pub(crate) explain: Option<Explain<L>>,
    unionfind: UnionFind,
    /// Stores the original node represented by each non-canonical id
    nodes: Vec<L>,
    /// Stores each enode's `Id`, not the `Id` of the eclass.
    /// Enodes in the memo are canonicalized at each rebuild, but after rebuilding new
    /// unions can cause them to become out of date.
    #[cfg_attr(feature = "serde-1", serde(with = "vectorize"))]
    memo: HashMap<L, Id>,
    /// Nodes which need to be processed for rebuilding. The `Id` is the `Id` of the enode,
    /// not the canonical id of the eclass.
    pending: Vec<Id>,
    analysis_pending: UniqueQueue<Id>,
    #[cfg_attr(
        feature = "serde-1",
        serde(bound(
            serialize = "N::Data: Serialize",
            deserialize = "N::Data: for<'a> Deserialize<'a>",
        ))
    )]
    pub(crate) classes: HashMap<Id, EClass<L, N::Data>>,
    #[cfg_attr(feature = "serde-1", serde(skip))]
    #[cfg_attr(feature = "serde-1", serde(default = "default_classes_by_op"))]
    pub(crate) classes_by_op: HashMap<L::Discriminant, HashSet<Id>>,
    /// Whether or not reading operation are allowed on this e-graph.
    /// Mutating operations will set this to `false`, and
    /// [`EGraph::rebuild`] will set it to true.
    /// Reading operations require this to be `true`.
    /// Only manually set it if you know what you're doing.
    #[cfg_attr(feature = "serde-1", serde(skip))]
    pub clean: bool,
    pub json_graph: SerializedEgraph,
}

#[cfg(feature = "serde-1")]
fn default_classes_by_op<K>() -> HashMap<K, HashSet<Id>> {
    HashMap::default()
}

impl<L: Language, N: Analysis<L> + Default> Default for EGraph<L, N> {
    fn default() -> Self {
        Self::new(N::default())
    }
}

// manual debug impl to avoid L: Language bound on EGraph defn
impl<L: Language, N: Analysis<L>> Debug for EGraph<L, N> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        f.debug_struct("EGraph")
            .field("memo", &self.memo)
            .field("classes", &self.classes)
            .finish()
    }
}

impl<L: Language, N: Analysis<L>> EGraph<L, N> {

    /// Load EGraph from JSON file with the specified format
    /// 
    /// The JSON format expected:
    /// ```json
    /// {
    ///   "nodes": {
    ///     "eclass_id": {
    ///       "enode_id": {
    ///         "op": "operation_name",
    ///         "area_cost": 1.0,
    ///         "delay_cost": 2.0,
    ///         "eclass": 0,
    ///         "children": [child_eclass_ids...],
    ///         "id": "node_identifier"
    ///       }
    ///     }
    ///   },
    ///   "root_eclasses": [root_eclass_ids...]
    /// }
    /// ```
    /// 
    /// Convert SerializedEgraph to EGraph with proper handling of multiple nodes per eclass
    pub fn from_json_data(
        json_data: SerializedEgraph,
        analysis: N,
        node_converter: impl Fn(&SerializedEnode, &[Id]) -> L,
    ) -> Result<(Self, Vec<Id>), Box<dyn std::error::Error>> {
        let mut egraph = Self::new(analysis);
        
        // Maps to track eclass relationships
        let mut eclass_to_canonical: HashMap<ClassType, Id> = HashMap::default();
        
        // Create a map from eclass to ALL SerializedEnodes (not just one)
        let mut eclass_to_json_nodes: HashMap<ClassType, Vec<SerializedEnode>> = HashMap::default();
        
        // Collect all nodes, grouping by eclass
        for (eclass_id, enode_map) in json_data.nodes {
            for (_enode_id, json_node) in enode_map {
                eclass_to_json_nodes.entry(eclass_id).or_insert_with(Vec::new).push(json_node);
            }
        }


        // Track which nodes we're currently processing to detect infinite recursion
        let mut processing_stack: HashSet<ClassType> = HashSet::default();

        let mut placeholder_map: HashMap<ClassType,L> = HashMap::default();
        
        // Process all eclasses
        for &eclass_id in eclass_to_json_nodes.keys() {
            if !eclass_to_canonical.contains_key(&eclass_id) {
                Self::process_eclass_recursive(
                    eclass_id,
                    &eclass_to_json_nodes,
                    &mut eclass_to_canonical,
                    &mut processing_stack,
                    &mut egraph,
                    &node_converter,
                    &mut placeholder_map,
                )?;
            }
        }
        egraph.rebuild();
        
        // Convert root_eclasses to Ids
        let roots: Vec<Id> = json_data.root_eclasses
            .iter()
            .filter_map(|&class_id| eclass_to_canonical.get(&class_id).copied())
            .collect();
        
        Ok((egraph, roots))
    }

    /// Recursively process an eclass and all its nodes
    fn process_eclass_recursive<F>(
        eclass_id: ClassType,
        eclass_to_json_nodes: &HashMap<ClassType, Vec<SerializedEnode>>,
        eclass_to_canonical: &mut HashMap<ClassType, Id>,
        processing_stack: &mut HashSet<ClassType>,
        egraph: &mut EGraph<L, N>,
        node_converter: &F,
        placeholder_map: &mut HashMap<ClassType,L>,
    ) -> Result<Id, Box<dyn std::error::Error>>
    where
        F: Fn(&SerializedEnode, &[Id]) -> L,
    {
        if let Some(&canonical_id) = eclass_to_canonical.get(&eclass_id) {
            return Ok(canonical_id);
        }

        if processing_stack.contains(&eclass_id) {
            println!("\u{26A0}\u{FE0F} \x1b[33m Warning: Cycle detected\x1b[0m");
            let return_id;

            
            if let Some(cid) = eclass_to_canonical.get(&eclass_id) {
                return_id = *cid;
            } else {
                let placeholder_json_node = json::SerializedEnode {
                op:"Placeholder".to_string(),
                costs:vec![("default".to_string(), NotNan::new(NCost::MAX).unwrap())],
                children:Vec::new(),
                id:String::new(),
            };
                let placeholder_node = node_converter(&placeholder_json_node, &[]);
                placeholder_map.insert(eclass_id,placeholder_node.clone());
                let placeholder_id = egraph.add(placeholder_node);
                eclass_to_canonical.insert(eclass_id, placeholder_id);
                return_id = placeholder_id;
            }


            
            return Ok(return_id);
        }

        processing_stack.insert(eclass_id);

        let json_nodes = eclass_to_json_nodes.get(&eclass_id)
            .ok_or_else(|| format!("SerializedEnodes for eclass {} not found", eclass_id))?;



        let mut dependencies: HashSet<ClassType> = HashSet::default();
        for json_node in json_nodes {
            for &child_eclass in &json_node.children {
                dependencies.insert(child_eclass.clone());
            }
        }

        for &dep_eclass in &dependencies {
            Self::process_eclass_recursive(
                dep_eclass,
                eclass_to_json_nodes,
                eclass_to_canonical,
                processing_stack,
                egraph,
                node_converter,
                placeholder_map,
            )?;
        }

        let mut current_eclass_id: Option<Id> = eclass_to_canonical.get(&eclass_id).copied();
        
        for json_node in json_nodes {
            let mut child_ids = Vec::new();
            for &child_eclass in &json_node.children {
                if child_eclass == eclass_id {
                    if let Some(self_id) = current_eclass_id {
                        child_ids.push(self_id);
                    } else {
                        return Err(format!("Self-reference in eclass {} before canonical ID established", eclass_id).into());
                    }
                } else {
                    if let Some(&canonical_id) = eclass_to_canonical.get(&child_eclass) {
                        child_ids.push(canonical_id);
                    } else {
                        return Err(format!("Child eclass {} not found", child_eclass).into());
                    }
                }
            }

            let language_node = node_converter(json_node, &child_ids);
            let new_node_id = egraph.add(language_node);

            if let Some(existing_id) = current_eclass_id {
                egraph.union(existing_id, new_node_id);
            } else {
                current_eclass_id = Some(new_node_id);
                eclass_to_canonical.insert(eclass_id, new_node_id);
            }
        }

        if let Some(enode) = placeholder_map.get(&eclass_id) {
            egraph.remove_safe_enode(enode);
        }

        processing_stack.remove(&eclass_id);

        Ok(current_eclass_id.unwrap())
    }

    /// Public interface for loading from JSON file
    pub fn from_json_file<P: AsRef<Path>>(
        path: P,
        analysis: N,
        node_converter: impl Fn(&SerializedEnode, &[Id]) -> L,
    ) -> Result<(Self, Vec<Id>), Box<dyn std::error::Error>> {
        let content = fs::read_to_string(path)?;
        Self::from_json_str(&content, analysis, node_converter)
    }


    pub fn from_json_str(
        json_str: &str,
        analysis: N,
        node_converter: impl Fn(&SerializedEnode, &[Id]) -> L,
    ) -> Result<(Self, Vec<Id>), Box<dyn std::error::Error>> {
        let json_data = SerializedEgraph::from_json_str(json_str)?;
        Self::from_json_data(json_data, analysis, node_converter)
    }


    /// Creates a new, empty `EGraph` with the given `Analysis`
    pub fn new(analysis: N) -> Self {
        Self {
            analysis,
            classes: Default::default(),
            unionfind: Default::default(),
            nodes: Default::default(),
            clean: false,
            explain: None,
            pending: Default::default(),
            memo: Default::default(),
            analysis_pending: Default::default(),
            classes_by_op: Default::default(),
            json_graph: SerializedEgraph::new(),
        }
    }

    /// Returns an iterator over the eclasses in the egraph.
    pub fn classes(&self) -> impl ExactSizeIterator<Item = &EClass<L, N::Data>> {
        self.classes.values()
    }

    /// Returns an mutating iterator over the eclasses in the egraph.
    pub fn classes_mut(&mut self) -> impl ExactSizeIterator<Item = &mut EClass<L, N::Data>> {
        self.classes.values_mut()
    }

    /// Returns `true` if the egraph is empty
    /// # Example
    /// ```
    /// use egg::{*, SymbolLang as S};
    /// let mut egraph = EGraph::<S, ()>::default();
    /// assert!(egraph.is_empty());
    /// egraph.add(S::leaf("foo"));
    /// assert!(!egraph.is_empty());
    /// ```
    pub fn is_empty(&self) -> bool {
        self.memo.is_empty()
    }

    /// Returns the number of enodes in the `EGraph`.
    ///
    /// Actually returns the size of the hashcons index.
    /// # Example
    /// ```
    /// use egg::{*, SymbolLang as S};
    /// let mut egraph = EGraph::<S, ()>::default();
    /// let x = egraph.add(S::leaf("x"));
    /// let y = egraph.add(S::leaf("y"));
    /// // only one eclass
    /// egraph.union(x, y);
    /// egraph.rebuild();
    ///
    /// assert_eq!(egraph.total_size(), 2);
    /// assert_eq!(egraph.number_of_classes(), 1);
    /// ```
    pub fn total_size(&self) -> usize {
        self.memo.len()
    }

    /// Iterates over the classes, returning the total number of nodes.
    pub fn total_number_of_nodes(&self) -> usize {
        self.classes().map(|c| c.len()).sum()
    }

    /// Returns the number of eclasses in the egraph.
    pub fn number_of_classes(&self) -> usize {
        self.classes.len()
    }

    /// Enable explanations for this `EGraph`.
    /// This allows the egraph to explain why two expressions are
    /// equivalent with the [`explain_equivalence`](EGraph::explain_equivalence) function.
    pub fn with_explanations_enabled(mut self) -> Self {
        if self.explain.is_some() {
            return self;
        }
        if self.total_size() > 0 {
            panic!("Need to set explanations enabled before adding any expressions to the egraph.");
        }
        self.explain = Some(Explain::new());
        self
    }

    /// By default, egg runs a greedy algorithm to reduce the size of resulting explanations (without complexity overhead).
    /// Use this function to turn this algorithm off.
    pub fn without_explanation_length_optimization(mut self) -> Self {
        if let Some(explain) = &mut self.explain {
            explain.optimize_explanation_lengths = false;
            self
        } else {
            panic!("Need to set explanations enabled before setting length optimization.");
        }
    }

    /// By default, egg runs a greedy algorithm to reduce the size of resulting explanations (without complexity overhead).
    /// Use this function to turn this algorithm on again if you have turned it off.
    pub fn with_explanation_length_optimization(mut self) -> Self {
        if let Some(explain) = &mut self.explain {
            explain.optimize_explanation_lengths = true;
            self
        } else {
            panic!("Need to set explanations enabled before setting length optimization.");
        }
    }

    /// Make a copy of the egraph with the same nodes, but no unions between them.
    pub fn copy_without_unions(&self, analysis: N) -> Self {
        if self.explain.is_none() {
            panic!("Use runner.with_explanations_enabled() or egraph.with_explanations_enabled() before running to get a copied egraph without unions");
        }
        let mut egraph = Self::new(analysis);
        for node in &self.nodes {
            egraph.add(node.clone());
        }
        egraph
    }

    /// Performs the union between two egraphs.
    pub fn egraph_union(&mut self, other: &EGraph<L, N>) {
        let right_unions = other.get_union_equalities();
        for (left, right, why) in right_unions {
            self.union_instantiations(
                &other.id_to_pattern(left, &Default::default()).0.ast,
                &other.id_to_pattern(right, &Default::default()).0.ast,
                &Default::default(),
                why,
            );
        }
        self.rebuild();
    }

    fn from_enodes(enodes: Vec<(L, Id)>, analysis: N) -> Self {
        let mut egraph = Self::new(analysis);
        let mut ids: HashMap<Id, Id> = Default::default();

        loop {
            let mut did_something = false;

            for (enode, id) in &enodes {
                let valid = enode.children().iter().all(|c| ids.contains_key(c));
                if !valid {
                    continue;
                }

                let mut enode = enode.clone().map_children(|c| ids[&c]);

                if egraph.lookup(&mut enode).is_some() {
                    continue;
                }

                let added = egraph.add(enode);
                if let Some(existing) = ids.get(id) {
                    egraph.union(*existing, added);
                } else {
                    ids.insert(*id, added);
                }

                did_something = true;
            }

            if !did_something {
                break;
            }
        }

        egraph
    }

    /// A intersection algorithm between two egraphs.
    /// The intersection is correct for all terms that are equal in both egraphs.
    /// Be wary, though, because terms which are not represented in both egraphs
    /// are not captured in the intersection.
    /// The runtime of this algorithm is O(|E1| * |E2|), where |E1| and |E2| are the number of enodes in each egraph.
    pub fn egraph_intersect(&self, other: &EGraph<L, N>, analysis: N) -> EGraph<L, N> {
        let mut product_map: HashMap<(Id, Id), Id> = Default::default();
        let mut enodes = vec![];

        for class1 in self.classes() {
            for class2 in other.classes() {
                self.intersect_classes(other, &mut enodes, class1.id, class2.id, &mut product_map);
            }
        }

        Self::from_enodes(enodes, analysis)
    }

    fn get_product_id(class1: Id, class2: Id, product_map: &mut HashMap<(Id, Id), Id>) -> Id {
        if let Some(id) = product_map.get(&(class1, class2)) {
            *id
        } else {
            let id = Id::from(product_map.len());
            product_map.insert((class1, class2), id);
            id
        }
    }

    fn intersect_classes(
        &self,
        other: &EGraph<L, N>,
        res: &mut Vec<(L, Id)>,
        class1: Id,
        class2: Id,
        product_map: &mut HashMap<(Id, Id), Id>,
    ) {
        let res_id = Self::get_product_id(class1, class2, product_map);
        for node1 in &self.classes[&class1].nodes {
            for node2 in &other.classes[&class2].nodes {
                if node1.matches(node2) {
                    let children1 = node1.children();
                    let children2 = node2.children();
                    let mut new_node = node1.clone();
                    let children = new_node.children_mut();
                    for (i, (child1, child2)) in children1.iter().zip(children2.iter()).enumerate()
                    {
                        let prod = Self::get_product_id(
                            self.find(*child1),
                            other.find(*child2),
                            product_map,
                        );
                        children[i] = prod;
                    }

                    res.push((new_node, res_id));
                }
            }
        }
    }

    /// Pick a representative term for a given Id.
    ///
    /// Calling this function on an uncanonical `Id` returns a representative based on the how it
    /// was obtained (see [`add_uncanoncial`](EGraph::add_uncanonical),
    /// [`add_expr_uncanonical`](EGraph::add_expr_uncanonical))
    pub fn id_to_expr(&self, id: Id) -> RecExpr<L> {
        let mut res = Default::default();
        let mut cache = Default::default();
        self.id_to_expr_internal(&mut res, id, &mut cache);
        res
    }

    fn id_to_expr_internal(
        &self,
        res: &mut RecExpr<L>,
        node_id: Id,
        cache: &mut HashMap<Id, Id>,
    ) -> Id {
        if let Some(existing) = cache.get(&node_id) {
            return *existing;
        }
        let new_node = self
            .id_to_node(node_id)
            .clone()
            .map_children(|child| self.id_to_expr_internal(res, child, cache));
        let res_id = res.add(new_node);
        cache.insert(node_id, res_id);
        res_id
    }

    /// Like [`id_to_expr`](EGraph::id_to_expr) but only goes one layer deep
    pub fn id_to_node(&self, id: Id) -> &L {
        &self.nodes[usize::from(id)]
    }

    /// Like [`id_to_expr`](EGraph::id_to_expr), but creates a pattern instead of a term.
    /// When an eclass listed in the given substitutions is found, it creates a variable.
    /// It also adds this variable and the corresponding Id value to the resulting [`Subst`]
    /// Otherwise it behaves like [`id_to_expr`](EGraph::id_to_expr).
    pub fn id_to_pattern(&self, id: Id, substitutions: &HashMap<Id, Id>) -> (Pattern<L>, Subst) {
        let mut res = Default::default();
        let mut subst = Default::default();
        let mut cache = Default::default();
        self.id_to_pattern_internal(&mut res, id, substitutions, &mut subst, &mut cache);
        (Pattern::new(res), subst)
    }

    fn id_to_pattern_internal(
        &self,
        res: &mut PatternAst<L>,
        node_id: Id,
        var_substitutions: &HashMap<Id, Id>,
        subst: &mut Subst,
        cache: &mut HashMap<Id, Id>,
    ) -> Id {
        if let Some(existing) = cache.get(&node_id) {
            return *existing;
        }
        let res_id = if let Some(existing) = var_substitutions.get(&node_id) {
            let var = format!("?{}", node_id).parse().unwrap();
            subst.insert(var, *existing);
            res.add(ENodeOrVar::Var(var))
        } else {
            let new_node = self.id_to_node(node_id).clone().map_children(|child| {
                self.id_to_pattern_internal(res, child, var_substitutions, subst, cache)
            });
            res.add(ENodeOrVar::ENode(new_node))
        };
        cache.insert(node_id, res_id);
        res_id
    }

    /// Get all the unions ever found in the egraph in terms of enode ids.
    pub fn get_union_equalities(&self) -> UnionEqualities {
        if let Some(explain) = &self.explain {
            explain.get_union_equalities()
        } else {
            panic!("Use runner.with_explanations_enabled() or egraph.with_explanations_enabled() before running to get union equalities");
        }
    }

    /// Disable explanations for this `EGraph`.
    pub fn with_explanations_disabled(mut self) -> Self {
        self.explain = None;
        self
    }

    /// Check if explanations are enabled.
    pub fn are_explanations_enabled(&self) -> bool {
        self.explain.is_some()
    }

    /// Get the number of congruences between nodes in the egraph.
    /// Only available when explanations are enabled.
    pub fn get_num_congr(&mut self) -> usize {
        if let Some(explain) = &mut self.explain {
            explain
                .with_nodes(&self.nodes)
                .get_num_congr::<N>(&self.classes, &self.unionfind)
        } else {
            panic!("Use runner.with_explanations_enabled() or egraph.with_explanations_enabled() before running to get explanations.")
        }
    }

    /// Get the number of nodes in the egraph used for explanations.
    pub fn get_explanation_num_nodes(&mut self) -> usize {
        if let Some(explain) = &mut self.explain {
            explain.with_nodes(&self.nodes).get_num_nodes()
        } else {
            panic!("Use runner.with_explanations_enabled() or egraph.with_explanations_enabled() before running to get explanations.")
        }
    }

    /// When explanations are enabled, this function
    /// produces an [`Explanation`] describing why two expressions are equivalent.
    ///
    /// The [`Explanation`] can be used in it's default tree form or in a less compact
    /// flattened form. Each of these also has a s-expression string representation,
    /// given by [`get_flat_string`](Explanation::get_flat_string) and [`get_string`](Explanation::get_string).
    pub fn explain_equivalence(
        &mut self,
        left_expr: &RecExpr<L>,
        right_expr: &RecExpr<L>,
    ) -> Explanation<L> {
        let left = self.add_expr_uncanonical(left_expr);
        let right = self.add_expr_uncanonical(right_expr);

        self.explain_id_equivalence(left, right)
    }

    /// Equivalent to calling [`explain_equivalence`](EGraph::explain_equivalence)`(`[`id_to_expr`](EGraph::id_to_expr)`(left),`
    /// [`id_to_expr`](EGraph::id_to_expr)`(right))` but more efficient
    ///
    /// This function picks representatives using [`id_to_expr`](EGraph::id_to_expr) so choosing
    /// `Id`s returned by functions like [`add_uncanonical`](EGraph::add_uncanonical) is important
    /// to control explanations
    pub fn explain_id_equivalence(&mut self, left: Id, right: Id) -> Explanation<L> {
        if self.find(left) != self.find(right) {
            panic!(
                "Tried to explain equivalence between non-equal terms {:?} and {:?}",
                self.id_to_expr(left),
                self.id_to_expr(left)
            );
        }
        if let Some(explain) = &mut self.explain {
            explain.with_nodes(&self.nodes).explain_equivalence::<N>(
                left,
                right,
                &mut self.unionfind,
                &self.classes,
            )
        } else {
            panic!("Use runner.with_explanations_enabled() or egraph.with_explanations_enabled() before running to get explanations.")
        }
    }

    /// When explanations are enabled, this function
    /// produces an [`Explanation`] describing how the given expression came
    /// to be in the egraph.
    ///
    /// The [`Explanation`] begins with some expression that was added directly
    /// into the egraph and ends with the given `expr`.
    /// Note that this function can be called again to explain any intermediate terms
    /// used in the output [`Explanation`].
    pub fn explain_existance(&mut self, expr: &RecExpr<L>) -> Explanation<L> {
        let id = self.add_expr_uncanonical(expr);
        self.explain_existance_id(id)
    }

    /// Equivalent to calling [`explain_existance`](EGraph::explain_existance)`(`[`id_to_expr`](EGraph::id_to_expr)`(id))`
    /// but more efficient
    fn explain_existance_id(&mut self, id: Id) -> Explanation<L> {
        if let Some(explain) = &mut self.explain {
            explain.with_nodes(&self.nodes).explain_existance(id)
        } else {
            panic!("Use runner.with_explanations_enabled() or egraph.with_explanations_enabled() before running to get explanations.")
        }
    }

    /// Return an [`Explanation`] for why a pattern appears in the egraph.
    pub fn explain_existance_pattern(
        &mut self,
        pattern: &PatternAst<L>,
        subst: &Subst,
    ) -> Explanation<L> {
        let id = self.add_instantiation_noncanonical(pattern, subst);
        if let Some(explain) = &mut self.explain {
            explain.with_nodes(&self.nodes).explain_existance(id)
        } else {
            panic!("Use runner.with_explanations_enabled() or egraph.with_explanations_enabled() before running to get explanations.")
        }
    }

    /// Get an explanation for why an expression matches a pattern.
    pub fn explain_matches(
        &mut self,
        left_expr: &RecExpr<L>,
        right_pattern: &PatternAst<L>,
        subst: &Subst,
    ) -> Explanation<L> {
        let left = self.add_expr_uncanonical(left_expr);
        let right = self.add_instantiation_noncanonical(right_pattern, subst);

        if self.find(left) != self.find(right) {
            panic!(
                "Tried to explain equivalence between non-equal terms {:?} and {:?}",
                left_expr, right_pattern
            );
        }
        if let Some(explain) = &mut self.explain {
            explain.with_nodes(&self.nodes).explain_equivalence::<N>(
                left,
                right,
                &mut self.unionfind,
                &self.classes,
            )
        } else {
            panic!("Use runner.with_explanations_enabled() or egraph.with_explanations_enabled() before running to get explanations.");
        }
    }

    /// Canonicalizes an eclass id.
    ///
    /// This corresponds to the `find` operation on the egraph's
    /// underlying unionfind data structure.
    ///
    /// # Example
    /// ```
    /// use egg::{*, SymbolLang as S};
    /// let mut egraph = EGraph::<S, ()>::default();
    /// let x = egraph.add(S::leaf("x"));
    /// let y = egraph.add(S::leaf("y"));
    /// assert_ne!(egraph.find(x), egraph.find(y));
    ///
    /// egraph.union(x, y);
    /// egraph.rebuild();
    /// assert_eq!(egraph.find(x), egraph.find(y));
    /// ```
    pub fn find(&self, id: Id) -> Id {
        self.unionfind.find(id)
    }

    /// This is private, but internals should use this whenever
    /// possible because it does path compression.
    fn find_mut(&mut self, id: Id) -> Id {
        self.unionfind.find_mut(id)
    }

    /// Creates a [`Dot`] to visualize this egraph. See [`Dot`].
    pub fn dot(&self) -> Dot<'_, L, N> {
        Dot {
            egraph: self,
            config: vec![],
            use_anchors: true,
        }
    }
}

impl<N: Analysis<SymbolLang>> EGraph<SymbolLang, N> {

    /// Recursively process an eclass and all its nodes
    fn process_eclass_recursive_symbollang(
        eclass_id: ClassType,
        eclass_to_json_nodes: &HashMap<ClassType, Vec<SerializedEnode>>,
        eclass_to_canonical: &mut HashMap<ClassType, Id>,
        processing_stack: &mut HashSet<ClassType>,
        egraph: &mut EGraph<SymbolLang, N>,
        placeholder_map: &mut HashMap<ClassType,SymbolLang>,
    ) -> Result<Id, Box<dyn std::error::Error>>
    {
        if let Some(&canonical_id) = eclass_to_canonical.get(&eclass_id) {
            return Ok(canonical_id);
        }

        if processing_stack.contains(&eclass_id) {
            println!("\u{26A0}\u{FE0F} \x1b[33m Warning: Cycle detected\x1b[0m");
            let return_id;

            
            if let Some(cid) = eclass_to_canonical.get(&eclass_id) {
                return_id = *cid;
            } else {
                let placeholder_json_node = json::SerializedEnode {
                op:format!("Placeholder_{}",eclass_id).to_string(),
                costs:vec![("default".to_string(), NotNan::new(NCost::MAX).unwrap())],
                children:Vec::new(),
                id:String::new(),
            };
                let placeholder_node = create_symbol_lang_node(&placeholder_json_node, &[]);
                placeholder_map.insert(eclass_id,placeholder_node.clone());
                let placeholder_id = egraph.add(placeholder_node);
                eclass_to_canonical.insert(eclass_id, placeholder_id);
                return_id = placeholder_id;
            }


            
            return Ok(return_id);
        }

        processing_stack.insert(eclass_id);

        let json_nodes = eclass_to_json_nodes.get(&eclass_id)
            .ok_or_else(|| format!("SerializedEnodes for eclass {} not found", eclass_id))?;



        let mut dependencies: HashSet<ClassType> = HashSet::default();
        for json_node in json_nodes {
            for &child_eclass in &json_node.children {
                dependencies.insert(child_eclass.clone());
            }
        }

        for &dep_eclass in &dependencies {
            Self::process_eclass_recursive_symbollang(
                dep_eclass,
                eclass_to_json_nodes,
                eclass_to_canonical,
                processing_stack,
                egraph,
                placeholder_map,
            )?;
        }

        let mut current_eclass_id: Option<Id> = eclass_to_canonical.get(&eclass_id).copied();
        for json_node in json_nodes {
            let mut child_ids = Vec::new();
            for &child_eclass in &json_node.children {
                if child_eclass == eclass_id {
                    if let Some(self_id) = current_eclass_id {
                        child_ids.push(self_id);
                    } else {
                        return Err(format!("Self-reference in eclass {} before canonical ID established", eclass_id).into());
                    }
                } else {
                    if let Some(&canonical_id) = eclass_to_canonical.get(&child_eclass) {
                        child_ids.push(canonical_id);
                    } else {
                        return Err(format!("Child eclass {} not found", child_eclass).into());
                    }
                }
            }
            let language_node = create_symbol_lang_node(json_node, &child_ids);
            let new_node_id = egraph.add(language_node);
            if let Some(existing_id) = current_eclass_id {
                egraph.union(existing_id, new_node_id);
            } else {
                current_eclass_id = Some(new_node_id);
                eclass_to_canonical.insert(eclass_id, new_node_id);
            }
        }
        if let Some(enode) = placeholder_map.get(&eclass_id) {
            egraph.remove_safe_enode(enode);
        }

        processing_stack.remove(&eclass_id);

        Ok(current_eclass_id.unwrap())
    }



    /// Load EGraph from JSON file with the specified format
    /// 
    /// The JSON format expected:
    /// ```json
    /// {
    ///   "nodes": {
    ///     "eclass_id": {
    ///       "enode_id": {
    ///         "op": "operation_name",
    ///         "area_cost": 1.0,
    ///         "delay_cost": 2.0,
    ///         "eclass": 0,
    ///         "children": [child_eclass_ids...],
    ///         "id": "node_identifier"
    ///       }
    ///     }
    ///   },
    ///   "root_eclasses": [root_eclass_ids...]
    /// }
    /// ```
    /// 
    /// Convert SerializedEgraph to EGraph with proper handling of multiple nodes per eclass
    pub fn from_json_data_symbollang(
        json_data: SerializedEgraph,
        analysis: N,
    ) -> Result<(Self, Vec<Id>), Box<dyn std::error::Error>> {
        let mut egraph = Self::new(analysis);
        
        // Maps to track eclass relationships
        let mut eclass_to_canonical: HashMap<ClassType, Id> = HashMap::default();
        
        // Create a map from eclass to ALL SerializedEnodes (not just one)
        let mut eclass_to_json_nodes: HashMap<ClassType, Vec<SerializedEnode>> = HashMap::default();
        
        // Collect all nodes, grouping by eclass
        for (eclass_id, enode_map) in json_data.nodes {
            for (_enode_id, json_node) in enode_map {
                eclass_to_json_nodes.entry(eclass_id).or_insert_with(Vec::new).push(json_node);
            }
        }


        // Track which nodes we're currently processing to detect infinite recursion
        let mut processing_stack: HashSet<ClassType> = HashSet::default();

        let mut placeholder_map: HashMap<ClassType,SymbolLang> = HashMap::default();
        
        // Process all eclasses
        for &eclass_id in eclass_to_json_nodes.keys() {
            if !eclass_to_canonical.contains_key(&eclass_id) {
                Self::process_eclass_recursive_symbollang(
                    eclass_id,
                    &eclass_to_json_nodes,
                    &mut eclass_to_canonical,
                    &mut processing_stack,
                    &mut egraph,
                    &mut placeholder_map,
                )?;
            }
        }
        egraph.rebuild();
        
        // Convert root_eclasses to Ids
        let roots: Vec<Id> = json_data.root_eclasses
            .iter()
            .filter_map(|&class_id| eclass_to_canonical.get(&class_id).copied())
            .collect();
        
        Ok((egraph, roots))
    }

    /// Public interface for loading from JSON file
    pub fn from_json_file_symbollang<P: AsRef<Path>>(
        path: P,
        analysis: N
    ) -> Result<(Self, Vec<Id>), Box<dyn std::error::Error>> {
        let content = fs::read_to_string(path)?;
        Self::from_json_str_symbollang(&content, analysis)
    }

    pub fn from_json_str_symbollang(
        json_str: &str,
        analysis: N,
    ) -> Result<(Self, Vec<Id>), Box<dyn std::error::Error>> {
        let json_data = SerializedEgraph::from_json_str(json_str)?;
        Self::from_json_data_symbollang(json_data, analysis)
    }

    // TODO: POD相关函数为C++接口准备，当前注释掉避免影响编译
    // /// Load EGraph from POD data using SymbolLang node converter
    // pub fn from_pod_data_symbollang(
    //     nodes_slice: &[crate::pod::EGraphNodePOD],
    //     outputs: &[ClassType],
    //     input_len: usize,
    //     analysis: N,
    // ) -> Result<Self, Box<dyn std::error::Error>> {
    //     Self::from_pod_data(nodes_slice, outputs,input_len, analysis, crate::create_symbol_lang_node)
    // }
}

/// Translates `EGraph<L, A>` into `EGraph<L2, A2>`. For common cases, you don't
/// need to implement this manually. See the provided [`SimpleLanguageMapper`].
pub trait LanguageMapper<L, A>
where
    L: Language,
    A: Analysis<L>,
{
    /// The target language to translate into.
    type L2: Language;

    /// The target analysis to transate into.
    type A2: Analysis<Self::L2>;

    /// Translate a node of `L` into a node of `L2`.
    fn map_node(&self, node: L) -> Self::L2;

    /// Translate `L::Discriminant` into `L2::Discriminant`
    fn map_discriminant(
        &self,
        discriminant: L::Discriminant,
    ) -> <Self::L2 as Language>::Discriminant;

    /// Translate an analysis of type `A` into an analysis of `A2`.
    fn map_analysis(&self, analysis: A) -> Self::A2;

    /// Translate `A::Data` into `A2::Data`.
    fn map_data(&self, data: A::Data) -> <Self::A2 as Analysis<Self::L2>>::Data;

    /// Translate an [`EClass`] over `L` into an [`EClass`] over `L2`.
    fn map_eclass(
        &self,
        src_eclass: EClass<L, A::Data>,
    ) -> EClass<Self::L2, <Self::A2 as Analysis<Self::L2>>::Data> {
        EClass {
            id: src_eclass.id,
            nodes: src_eclass
                .nodes
                .into_iter()
                .map(|l| self.map_node(l))
                .collect(),
            data: self.map_data(src_eclass.data),
            parents: src_eclass.parents,
        }
    }

    /// Map an `EGraph` over `L` into an `EGraph` over `L2`.
    fn map_egraph(&self, src_egraph: EGraph<L, A>) -> EGraph<Self::L2, Self::A2> {
        let kv_map = |(k, v): (L, Id)| (self.map_node(k), v);
        EGraph {
            analysis: self.map_analysis(src_egraph.analysis),
            explain: None,
            unionfind: src_egraph.unionfind,
            memo: src_egraph.memo.into_iter().map(kv_map).collect(),
            pending: src_egraph.pending,
            nodes: src_egraph
                .nodes
                .into_iter()
                .map(|x| self.map_node(x))
                .collect(),
            analysis_pending: src_egraph.analysis_pending,
            classes: src_egraph
                .classes
                .into_iter()
                .map(|(id, eclass)| (id, self.map_eclass(eclass)))
                .collect(),
            classes_by_op: src_egraph
                .classes_by_op
                .into_iter()
                .map(|(k, v)| (self.map_discriminant(k), v))
                .collect(),
            clean: src_egraph.clean,
            json_graph: src_egraph.json_graph,
        }
    }
}

/// An implementation of [`LanguageMapper`] that can convert an [`EGraph`] over one
/// language into an [`EGraph`] over a different language in common cases.
///
/// Specifically, you can use this if have
/// [`conversion`](https://doc.rust-lang.org/1.76.0/core/convert/index.html)
/// implemented between your source and target language, as well as your source and
/// target analysis.
///
/// Here is an example of how to use this. Consider a case where you have a newtype
/// wrapper over an existing language type:
///
/// ```rust
/// use egg::*;
///
/// #[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
/// struct MyLang(SymbolLang);
/// # impl Language for MyLang {
/// #     type Discriminant = <SymbolLang as Language>::Discriminant;
/// #
/// #     fn matches(&self, other: &Self) -> bool {
/// #         self.0.matches(&other.0)
/// #     }
/// #
/// #     fn children(&self) -> &[Id] {
/// #         self.0.children()
/// #     }
/// #
/// #     fn children_mut(&mut self) -> &mut [Id] {
/// #         self.0.children_mut()
/// #     }
/// #
/// #     fn discriminant(&self) -> Self::Discriminant {
/// #         self.0.discriminant()
/// #     }
/// # }
///
/// // some external library function
/// pub fn external(egraph: EGraph<SymbolLang, ()>) { }
///
/// fn do_thing(egraph: EGraph<MyLang, ()>) {
///   // how do I call external?
///   external(todo!())
/// }
/// ```
///
/// By providing an implementation of `From<MyLang> for SymbolLang`, we can
/// construct `SimpleLanguageMapper` and use it to translate our [`EGraph`] into the
/// right type.
///
/// ```rust
/// # use egg::*;
/// # #[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
/// # struct MyLang(SymbolLang);
/// # impl Language for MyLang {
/// #     type Discriminant = <SymbolLang as Language>::Discriminant;
/// #
/// #     fn matches(&self, other: &Self) -> bool {
/// #         self.0.matches(&other.0)
/// #     }
/// #
/// #     fn children(&self) -> &[Id] {
/// #         self.0.children()
/// #     }
/// #
/// #     fn children_mut(&mut self) -> &mut [Id] {
/// #         self.0.children_mut()
/// #     }
/// #
/// #     fn discriminant(&self) -> Self::Discriminant {
/// #         self.0.discriminant()
/// #     }
/// # }
/// # pub fn external(egraph: EGraph<SymbolLang, ()>) { }
/// impl From<MyLang> for SymbolLang {
///     fn from(value: MyLang) -> Self {
///         value.0
///     }
/// }
///
/// fn do_thing(egraph: EGraph<MyLang, ()>) {
///     external(SimpleLanguageMapper::default().map_egraph(egraph))
/// }
/// ```
///
/// Note that we do not need to provide any conversion for the analysis, because it
/// is the same in both source and target e-graphs.
pub struct SimpleLanguageMapper<L2, A2> {
    _phantom: PhantomData<(L2, A2)>,
}

impl<L, A> Default for SimpleLanguageMapper<L, A> {
    fn default() -> Self {
        SimpleLanguageMapper {
            _phantom: PhantomData,
        }
    }
}


pub fn create_symbol_lang_node(json_node: &SerializedEnode, child_ids: &[Id]) -> SymbolLang {
    if child_ids.is_empty() {
        SymbolLang::leaf(&json_node.op)
    } else {
        SymbolLang::new(&json_node.op, child_ids.to_vec())
    }
}

impl<L, A, L2, A2> LanguageMapper<L, A> for SimpleLanguageMapper<L2, A2>
where
    L: Language,
    A: Analysis<L>,
    L2: Language + From<L>,
    A2: Analysis<L2> + From<A>,
    <L2 as Language>::Discriminant: From<<L as Language>::Discriminant>,
    <A2 as Analysis<L2>>::Data: From<<A as Analysis<L>>::Data>,
{
    type L2 = L2;
    type A2 = A2;

    fn map_node(&self, node: L) -> Self::L2 {
        node.into()
    }

    fn map_discriminant(
        &self,
        discriminant: <L as Language>::Discriminant,
    ) -> <Self::L2 as Language>::Discriminant {
        discriminant.into()
    }

    fn map_analysis(&self, analysis: A) -> Self::A2 {
        analysis.into()
    }

    fn map_data(&self, data: <A as Analysis<L>>::Data) -> <Self::A2 as Analysis<Self::L2>>::Data {
        data.into()
    }
}

/// Given an `Id` using the `egraph[id]` syntax, retrieve the e-class.
impl<L: Language, N: Analysis<L>> std::ops::Index<Id> for EGraph<L, N> {
    type Output = EClass<L, N::Data>;
    fn index(&self, id: Id) -> &Self::Output {
        let id = self.find(id);
        self.classes
            .get(&id)
            .unwrap_or_else(|| panic!("Invalid id {}", id))
    }
}

/// Given an `Id` using the `&mut egraph[id]` syntax, retrieve a mutable
/// reference to the e-class.
impl<L: Language, N: Analysis<L>> std::ops::IndexMut<Id> for EGraph<L, N> {
    fn index_mut(&mut self, id: Id) -> &mut Self::Output {
        let id = self.find_mut(id);
        self.classes
            .get_mut(&id)
            .unwrap_or_else(|| panic!("Invalid id {}", id))
    }
}

impl<L: Language, N: Analysis<L>> EGraph<L, N> {
    /// Adds a [`RecExpr`] to the [`EGraph`], returning the id of the RecExpr's eclass.
    ///
    /// # Example
    /// ```
    /// use egg::{*, SymbolLang as S};
    /// let mut egraph = EGraph::<S, ()>::default();
    /// let x = egraph.add(S::leaf("x"));
    /// let y = egraph.add(S::leaf("y"));
    /// let plus = egraph.add(S::new("+", vec![x, y]));
    /// let plus_recexpr = "(+ x y)".parse().unwrap();
    /// assert_eq!(plus, egraph.add_expr(&plus_recexpr));
    /// ```
    ///
    /// [`add_expr`]: EGraph::add_expr()
    pub fn add_expr(&mut self, expr: &RecExpr<L>) -> Id {
        let id = self.add_expr_uncanonical(expr);
        self.find(id)
    }

    /// Similar to [`add_expr`](EGraph::add_expr) but the `Id` returned may not be canonical
    ///
    /// Calling [`id_to_expr`](EGraph::id_to_expr) on this `Id` return a copy of `expr` when explanations are enabled
    pub fn add_expr_uncanonical(&mut self, expr: &RecExpr<L>) -> Id {
        let nodes = expr.as_ref();
        let mut new_ids = Vec::with_capacity(nodes.len());
        let mut new_node_q = Vec::with_capacity(nodes.len());
        for node in nodes {
            let new_node = node.clone().map_children(|i| new_ids[usize::from(i)]);
            let size_before = self.unionfind.size();
            let next_id = self.add_uncanonical(new_node);
            if self.unionfind.size() > size_before {
                new_node_q.push(true);
            } else {
                new_node_q.push(false);
            }
            if let Some(explain) = &mut self.explain {
                node.for_each(|child| {
                    // Set the existance reason for new nodes to their parent node.
                    if new_node_q[usize::from(child)] {
                        explain.set_existance_reason(new_ids[usize::from(child)], next_id);
                    }
                });
            }
            new_ids.push(next_id);
        }
        *new_ids.last().unwrap()
    }

    /// Adds a [`Pattern`] and a substitution to the [`EGraph`], returning
    /// the eclass of the instantiated pattern.
    pub fn add_instantiation(&mut self, pat: &PatternAst<L>, subst: &Subst) -> Id {
        let id = self.add_instantiation_noncanonical(pat, subst);
        self.find(id)
    }

    /// Similar to [`add_instantiation`](EGraph::add_instantiation) but the `Id` returned may not be
    /// canonical
    ///
    /// Like [`add_uncanonical`](EGraph::add_uncanonical), when explanations are enabled calling
    /// Calling [`id_to_expr`](EGraph::id_to_expr) on this `Id` return an correspond to the
    /// instantiation of the pattern
    fn add_instantiation_noncanonical(&mut self, pat: &PatternAst<L>, subst: &Subst) -> Id {
        let nodes = pat.as_ref();
        let mut new_ids = Vec::with_capacity(nodes.len());
        let mut new_node_q = Vec::with_capacity(nodes.len());
        for node in nodes {
            match node {
                ENodeOrVar::Var(var) => {
                    let id = self.find(subst[*var]);
                    new_ids.push(id);
                    new_node_q.push(false);
                }
                ENodeOrVar::ENode(node) => {
                    let new_node = node.clone().map_children(|i| new_ids[usize::from(i)]);
                    let size_before = self.unionfind.size();
                    let next_id = self.add_uncanonical(new_node);
                    if self.unionfind.size() > size_before {
                        new_node_q.push(true);
                    } else {
                        new_node_q.push(false);
                    }

                    if let Some(explain) = &mut self.explain {
                        node.for_each(|child| {
                            if new_node_q[usize::from(child)] {
                                explain.set_existance_reason(new_ids[usize::from(child)], next_id);
                            }
                        });
                    }
                    new_ids.push(next_id);
                }
            }
        }
        *new_ids.last().unwrap()
    }

    /// Lookup the eclass of the given enode.
    ///
    /// You can pass in either an owned enode or a `&mut` enode,
    /// in which case the enode's children will be canonicalized.
    ///
    /// # Example
    /// ```
    /// # use egg::*;
    /// let mut egraph: EGraph<SymbolLang, ()> = Default::default();
    /// let a = egraph.add(SymbolLang::leaf("a"));
    /// let b = egraph.add(SymbolLang::leaf("b"));
    ///
    /// // lookup will find this node if its in the egraph
    /// let mut node_f_ab = SymbolLang::new("f", vec![a, b]);
    /// assert_eq!(egraph.lookup(node_f_ab.clone()), None);
    /// let id = egraph.add(node_f_ab.clone());
    /// assert_eq!(egraph.lookup(node_f_ab.clone()), Some(id));
    ///
    /// // if the query node isn't canonical, and its passed in by &mut instead of owned,
    /// // its children will be canonicalized
    /// egraph.union(a, b);
    /// egraph.rebuild();
    /// assert_eq!(egraph.lookup(&mut node_f_ab), Some(id));
    /// assert_eq!(node_f_ab, SymbolLang::new("f", vec![a, a]));
    /// ```
    pub fn lookup<B>(&self, enode: B) -> Option<Id>
    where
        B: BorrowMut<L>,
    {
        self.lookup_internal(enode).map(|id| self.find(id))
    }

    fn lookup_internal<B>(&self, mut enode: B) -> Option<Id>
    where
        B: BorrowMut<L>,
    {
        let enode = enode.borrow_mut();
        enode.update_children(|id| self.find(id));
        self.memo.get(enode).copied()
    }

    /// Lookup the eclass of the given [`RecExpr`].
    ///
    /// Equivalent to the last value in [`EGraph::lookup_expr_ids`].
    pub fn lookup_expr(&self, expr: &RecExpr<L>) -> Option<Id> {
        self.lookup_expr_ids(expr)
            .and_then(|ids| ids.last().copied())
    }

    /// Lookup the eclasses of all the nodes in the given [`RecExpr`].
    pub fn lookup_expr_ids(&self, expr: &RecExpr<L>) -> Option<Vec<Id>> {
        let nodes = expr.as_ref();
        let mut new_ids = Vec::with_capacity(nodes.len());
        for node in nodes {
            let node = node.clone().map_children(|i| new_ids[usize::from(i)]);
            let id = self.lookup(node)?;
            new_ids.push(id)
        }
        Some(new_ids)
    }

    /// Adds an enode to the [`EGraph`].
    ///
    /// When adding an enode, to the egraph, [`add`] it performs
    /// _hashconsing_ (sometimes called interning in other contexts).
    ///
    /// Hashconsing ensures that only one copy of that enode is in the egraph.
    /// If a copy is in the egraph, then [`add`] simply returns the id of the
    /// eclass in which the enode was found.
    ///
    /// Like [`union`](EGraph::union), this modifies the e-graph.
    ///
    /// [`add`]: EGraph::add()
    pub fn add(&mut self, enode: L) -> Id {
        let id = self.add_uncanonical(enode);
        self.find(id)
    }

    /// Similar to [`add`](EGraph::add) but the `Id` returned may not be canonical
    ///
    /// When explanations are enabled calling [`id_to_expr`](EGraph::id_to_expr) on this `Id` will
    /// correspond to the parameter `enode`
    ///
    /// ## Example
    /// ```
    /// # use egg::*;
    /// let mut egraph: EGraph<SymbolLang, ()> = EGraph::default().with_explanations_enabled();
    /// let a = egraph.add_uncanonical(SymbolLang::leaf("a"));
    /// let b = egraph.add_uncanonical(SymbolLang::leaf("b"));
    /// egraph.union(a, b);
    /// egraph.rebuild();
    ///
    /// let fa = egraph.add_uncanonical(SymbolLang::new("f", vec![a]));
    /// let fb = egraph.add_uncanonical(SymbolLang::new("f", vec![b]));
    ///
    /// assert_eq!(egraph.id_to_expr(fa), "(f a)".parse().unwrap());
    /// assert_eq!(egraph.id_to_expr(fb), "(f b)".parse().unwrap());
    /// ```
    ///
    /// When explanations are not enabled calling [`id_to_expr`](EGraph::id_to_expr) on this `Id` will
    /// produce an expression with equivalent but not necessarily identical children
    ///
    /// # Example
    /// ```
    /// # use egg::*;
    /// let mut egraph: EGraph<SymbolLang, ()> = EGraph::default().with_explanations_disabled();
    /// let a = egraph.add_uncanonical(SymbolLang::leaf("a"));
    /// let b = egraph.add_uncanonical(SymbolLang::leaf("b"));
    /// egraph.union(a, b);
    /// egraph.rebuild();
    ///
    /// let fa = egraph.add_uncanonical(SymbolLang::new("f", vec![a]));
    /// let fb = egraph.add_uncanonical(SymbolLang::new("f", vec![b]));
    ///
    /// assert_eq!(egraph.id_to_expr(fa), "(f a)".parse().unwrap());
    /// assert_eq!(egraph.id_to_expr(fb), "(f a)".parse().unwrap());
    /// ```
    pub fn add_uncanonical(&mut self, mut enode: L) -> Id {
        let original = enode.clone();
        if let Some(existing_id) = self.lookup_internal(&mut enode) {
            let id = self.find(existing_id);
            // when explanations are enabled, we need a new representative for this expr
            if let Some(explain) = self.explain.as_mut() {
                if let Some(existing_explain) = explain.uncanon_memo.get(&original) {
                    *existing_explain
                } else {
                    let new_id = self.unionfind.make_set();
                    explain.add(original.clone(), new_id, new_id);
                    debug_assert_eq!(Id::from(self.nodes.len()), new_id);
                    self.nodes.push(original);
                    self.unionfind.union(id, new_id);
                    explain.union(existing_id, new_id, Justification::Congruence, true);
                    new_id
                }
            } else {
                existing_id
            }
        } else {
            let id = self.make_new_eclass(enode, original.clone());
            if let Some(explain) = self.explain.as_mut() {
                explain.add(original, id, id);
            }

            // now that we updated explanations, run the analysis for the new eclass
            N::modify(self, id);
            self.clean = false;
            id
        }
    }

    /// This function makes a new eclass in the egraph (but doesn't touch explanations)
    fn make_new_eclass(&mut self, enode: L, original: L) -> Id {
        let id = self.unionfind.make_set();
        log::trace!("  ...adding to {}", id);
        let class = EClass {
            id,
            nodes: vec![enode.clone()],
            data: N::make(self, &original),
            parents: Default::default(),
        };

        debug_assert_eq!(Id::from(self.nodes.len()), id);
        self.nodes.push(original);

        // add this enode to the parent lists of its children
        enode.for_each(|child| {
            self[child].parents.push(id);
        });

        // TODO is this needed?
        self.pending.push(id);

        self.classes.insert(id, class);
        assert!(self.memo.insert(enode, id).is_none());

        id
    }

    /// Checks whether two [`RecExpr`]s are equivalent.
    /// Returns a list of id where both expression are represented.
    /// In most cases, there will none or exactly one id.
    ///
    pub fn equivs(&self, expr1: &RecExpr<L>, expr2: &RecExpr<L>) -> Vec<Id> {
        let pat1 = Pattern::from(expr1.as_ref());
        let pat2 = Pattern::from(expr2.as_ref());
        let matches1 = pat1.search(self);
        trace!("Matches1: {:?}", matches1);

        let matches2 = pat2.search(self);
        trace!("Matches2: {:?}", matches2);

        let mut equiv_eclasses = Vec::new();

        for m1 in &matches1 {
            for m2 in &matches2 {
                if self.find(m1.eclass) == self.find(m2.eclass) {
                    equiv_eclasses.push(m1.eclass)
                }
            }
        }

        equiv_eclasses
    }

    /// Given two patterns and a substitution, add the patterns
    /// and union them.
    ///
    /// When explanations are enabled [`with_explanations_enabled`](Runner::with_explanations_enabled), use
    /// this function instead of [`union`](EGraph::union).
    ///
    /// Returns the id of the new eclass, along with
    /// a `bool` indicating whether a union occured.
    pub fn union_instantiations(
        &mut self,
        from_pat: &PatternAst<L>,
        to_pat: &PatternAst<L>,
        subst: &Subst,
        rule_name: impl Into<Symbol>,
    ) -> (Id, bool) {
        let id1 = self.add_instantiation_noncanonical(from_pat, subst);
        let size_before = self.unionfind.size();
        let id2 = self.add_instantiation_noncanonical(to_pat, subst);
        let rhs_new = self.unionfind.size() > size_before;

        let did_union = self.perform_union(
            id1,
            id2,
            Some(Justification::Rule(rule_name.into())),
            rhs_new,
        );
        (self.find(id1), did_union)
    }

    /// Unions two e-classes, using a given reason to justify it.
    ///
    /// This function picks representatives using [`id_to_expr`](EGraph::id_to_expr) so choosing
    /// `Id`s returned by functions like [`add_uncanonical`](EGraph::add_uncanonical) is important
    /// to control explanations
    pub fn union_trusted(&mut self, from: Id, to: Id, reason: impl Into<Symbol>) -> bool {
        self.perform_union(from, to, Some(Justification::Rule(reason.into())), false)
    }

    /// Unions two eclasses given their ids.
    ///
    /// The given ids need not be canonical.
    /// The returned `bool` indicates whether a union is necessary,
    /// so it's `false` if they were already equivalent.
    ///
    /// When explanations are enabled, this function behaves like [`EGraph::union_trusted`],
    ///  and it lists the call site as the proof reason.
    /// You should prefer [`union_instantiations`](EGraph::union_instantiations) when
    ///  you want the proofs to always be meaningful.
    /// Alternatively you can use [`EGraph::union_trusted`] using uncanonical `Id`s obtained from
    ///  functions like [`EGraph::add_uncanonical`]
    /// See [`explain_equivalence`](Runner::explain_equivalence) for a more detailed
    /// explanation of the feature.
    #[track_caller]
    pub fn union(&mut self, id1: Id, id2: Id) -> bool {
        if self.explain.is_some() {
            let caller = std::panic::Location::caller();
            self.union_trusted(id1, id2, caller.to_string())
        } else {
            self.perform_union(id1, id2, None, false)
        }
    }

    fn perform_union(
        &mut self,
        enode_id1: Id,
        enode_id2: Id,
        rule: Option<Justification>,
        any_new_rhs: bool,
    ) -> bool {
        N::pre_union(self, enode_id1, enode_id2, &rule);

        self.clean = false;
        let mut id1 = self.find_mut(enode_id1);
        let mut id2 = self.find_mut(enode_id2);
        if id1 == id2 {
            if let Some(Justification::Rule(_)) = rule {
                if let Some(explain) = &mut self.explain {
                    explain.alternate_rewrite(enode_id1, enode_id2, rule.unwrap());
                }
            }
            return false;
        }
        // make sure class2 has fewer parents
        let class1_parents = self.classes[&id1].parents.len();
        let class2_parents = self.classes[&id2].parents.len();
        if class1_parents < class2_parents {
            std::mem::swap(&mut id1, &mut id2);
        }

        if let Some(explain) = &mut self.explain {
            explain.union(enode_id1, enode_id2, rule.unwrap(), any_new_rhs);
        }

        // make id1 the new root
        self.unionfind.union(id1, id2);

        assert_ne!(id1, id2);
        let class2 = self.classes.remove(&id2).unwrap();
        let class1 = self.classes.get_mut(&id1).unwrap();
        assert_eq!(id1, class1.id);

        self.pending.extend(class2.parents.iter().copied());
        let did_merge = self.analysis.merge(&mut class1.data, class2.data);
        if did_merge.0 {
            self.analysis_pending.extend(class1.parents.iter().copied());
        }
        if did_merge.1 {
            self.analysis_pending.extend(class2.parents.iter().copied());
        }

        concat_vecs(&mut class1.nodes, class2.nodes);
        concat_vecs(&mut class1.parents, class2.parents);

        N::modify(self, id1);
        true
    }

    /// Update the analysis data of an e-class.
    ///
    /// This also propagates the changes through the e-graph,
    /// so [`Analysis::make`] and [`Analysis::merge`] will get
    /// called for other parts of the e-graph on rebuild.
    pub fn set_analysis_data(&mut self, id: Id, new_data: N::Data) {
        let id = self.find_mut(id);
        let class = self.classes.get_mut(&id).unwrap();
        class.data = new_data;
        self.analysis_pending.extend(class.parents.iter().copied());
        N::modify(self, id)
    }

    /// Returns a more debug-able representation of the egraph.
    ///
    /// [`EGraph`]s implement [`Debug`], but it ain't pretty. It
    /// prints a lot of stuff you probably don't care about.
    /// This method returns a wrapper that implements [`Debug`] in a
    /// slightly nicer way, just dumping enodes in each eclass.
    ///
    /// [`Debug`]: std::fmt::Debug
    pub fn dump(&self) -> impl Debug + '_ {
        EGraphDump(self)
    }
}

impl<L: Language + Display, N: Analysis<L>> EGraph<L, N> {
    /// Panic if the given eclass doesn't contain the given patterns
    ///
    /// Useful for testing.
    pub fn check_goals(&self, id: Id, goals: &[Pattern<L>]) {
        let (cost, best) = Extractor::new(self, AstSize).find_best(id);
        println!("End ({}): {}", cost, best.pretty(80));

        for (i, goal) in goals.iter().enumerate() {
            println!("Trying to prove goal {}: {}", i, goal.pretty(40));
            let matches = goal.search_eclass(self, id);
            if matches.is_none() {
                let best = Extractor::new(self, AstSize).find_best(id).1;
                panic!(
                    "Could not prove goal {}:\n\
                     {}\n\
                     Best thing found:\n\
                     {}",
                    i,
                    goal.pretty(40),
                    best.pretty(40),
                );
            }
        }
    }
}

impl<L, N> EGraph<L, N>
where
    L: Language + Send + Sync,                       // 并行所需
    N: Analysis<L>,
    <L as Language>::Discriminant: Send + Sync,
{
    #[inline(never)]
    fn rebuild_classes_mt(&mut self) -> usize {
        use rayon::prelude::*;


        // 1) 清空 classes_by_op
        let mut classes_by_op = std::mem::take(&mut self.classes_by_op);
        classes_by_op.values_mut().for_each(|ids| ids.clear());

        // 2) 把每个 eclass 的 nodes 移出（不 clone）
        let originals: Vec<(Id, Vec<L>)> = self
            .classes
            .values_mut()
            .map(|c| (c.id, std::mem::take(&mut c.nodes)))
            .collect();

        // 3) 串行做一次全量路径压缩，构建 canon 映射
        let uf_size = self.unionfind.size();
        let canon: Vec<Id> = (0..uf_size)
            .map(|i| self.unionfind.find_mut(Id::from(i)))
            .collect();

        // 4) 外层并行：规范化子节点 -> 排序去重 -> 收集 op
        let updates: Vec<(Id, Vec<L>, Vec<<L as Language>::Discriminant>, usize)> =
            originals
                .into_par_iter()
                // .with_min_len(64) // 可选：降低调度开销
                .map(|(cid, mut nodes)| {
                    // 规范化：用 canon 映射，避免并行里访问 union-find
                    for n in &mut nodes {
                        n.update_children(|id| canon[usize::from(id)]);
                    }

                    let old_len = nodes.len();
                    nodes.sort_unstable();
                    nodes.dedup();

                    // 收集（去重后）discriminant
                    let mut ops = Vec::new();
                    if let Some(first) = nodes.first() {
                        let mut prev = first;
                        ops.push(first.discriminant());
                        for n in nodes.iter().skip(1) {
                            if !prev.matches(n) {
                                ops.push(n.discriminant());
                                prev = n;
                            }
                        }
                    }

                    (cid, nodes, ops, old_len)
                })
                .collect();

        // 5) 串行回写
        let mut trimmed = 0usize;
        for (cid, new_nodes, ops, old_len) in updates {
            let class = self.classes.get_mut(&cid).unwrap();
            trimmed += old_len.saturating_sub(new_nodes.len());
            class.nodes = new_nodes;

            for op in ops {
                classes_by_op.entry(op).or_default().insert(cid);
            }
        }

        self.classes_by_op = classes_by_op;
        trimmed
    }

    pub fn rebuild_mt(&mut self) -> usize {
        let old_hc_size = self.memo.len();
        let old_n_eclasses = self.number_of_classes();
        let start = Instant::now();
        let n_unions = self.process_unions();
        let trimmed_nodes = self.rebuild_classes();

        let elapsed = start.elapsed();
        log::debug!(
            concat!(
                "REBUILT! in {}.{:03}s\n",
                "  Old: hc size {}, eclasses: {}\n",
                "  New: hc size {}, eclasses: {}\n",
                "  unions: {}, trimmed nodes: {}"
            ),
            elapsed.as_secs(),
            elapsed.subsec_millis(),
            old_hc_size,
            old_n_eclasses,
            self.memo.len(),
            self.number_of_classes(),
            n_unions,
            trimmed_nodes,
        );

        debug_assert!(self.check_memo());
        self.clean = true;
        n_unions
    }
}

// All the rebuilding stuff
impl<L: Language, N: Analysis<L>> EGraph<L, N> {
    #[inline(never)]
    fn rebuild_classes(&mut self) -> usize {
        let mut classes_by_op = std::mem::take(&mut self.classes_by_op);
        classes_by_op.values_mut().for_each(|ids| ids.clear());

        let mut trimmed = 0;
        let uf = &mut self.unionfind;

        for class in self.classes.values_mut() {
            let old_len = class.len();
            class
                .nodes
                .iter_mut()
                .for_each(|n| n.update_children(|id| uf.find_mut(id)));
            class.nodes.sort_unstable();
            class.nodes.dedup();

            trimmed += old_len - class.nodes.len();

            let mut add = |n: &L| {
                classes_by_op
                    .entry(n.discriminant())
                    .or_default()
                    .insert(class.id)
            };

            // we can go through the ops in order to dedup them, becaue we
            // just sorted them
            let mut nodes = class.nodes.iter();
            if let Some(mut prev) = nodes.next() {
                add(prev);
                for n in nodes {
                    if !prev.matches(n) {
                        add(n);
                        prev = n;
                    }
                }
            }
        }

        #[cfg(debug_assertions)]
        for ids in classes_by_op.values_mut() {
            let unique: HashSet<Id> = ids.iter().copied().collect();
            assert_eq!(ids.len(), unique.len());
        }

        self.classes_by_op = classes_by_op;
        trimmed
    }

    #[inline(never)]
    fn check_memo(&self) -> bool {
        let mut test_memo = HashMap::default();

        for (&id, class) in self.classes.iter() {
            assert_eq!(class.id, id);
            for node in &class.nodes {
                if let Some(old) = test_memo.insert(node, id) {
                    assert_eq!(
                        self.find(old),
                        self.find(id),
                        "Found unexpected equivalence for {:?}\n{:?}\nvs\n{:?}",
                        node,
                        self[self.find(id)].nodes,
                        self[self.find(old)].nodes,
                    );
                }
            }
        }

        for (n, e) in test_memo {
            assert_eq!(e, self.find(e));
            assert_eq!(
                Some(e),
                self.memo.get(n).map(|id| self.find(*id)),
                "Entry for {:?} at {} in test_memo was incorrect",
                n,
                e
            );
        }

        true
    }

    #[inline(never)]
    fn process_unions(&mut self) -> usize {
        let mut n_unions = 0;

        while !self.pending.is_empty() || !self.analysis_pending.is_empty() {
            while let Some(class) = self.pending.pop() {
                let mut node = self.nodes[usize::from(class)].clone();
                node.update_children(|id| self.find_mut(id));
                if let Some(memo_class) = self.memo.insert(node, class) {
                    let did_something = self.perform_union(
                        memo_class,
                        class,
                        Some(Justification::Congruence),
                        false,
                    );
                    n_unions += did_something as usize;
                }
            }

            while let Some(class_id) = self.analysis_pending.pop() {
                let node = self.nodes[usize::from(class_id)].clone();
                let class_id = self.find_mut(class_id);
                let node_data = N::make(self, &node);
                let class = self.classes.get_mut(&class_id).unwrap();

                let did_merge = self.analysis.merge(&mut class.data, node_data);
                if did_merge.0 {
                    self.analysis_pending.extend(class.parents.iter().copied());
                    N::modify(self, class_id)
                }
            }
        }

        assert!(self.pending.is_empty());
        assert!(self.analysis_pending.is_empty());

        n_unions
    }

    /// Restores the egraph invariants of congruence and enode uniqueness.
    ///
    /// As mentioned
    /// [in the tutorial](tutorials/_01_background/index.html#invariants-and-rebuilding),
    /// `egg` takes a lazy approach to maintaining the egraph invariants.
    /// The `rebuild` method allows the user to manually restore those
    /// invariants at a time of their choosing. It's a reasonably
    /// fast, linear-ish traversal through the egraph.
    ///
    /// After modifying an e-graph with [`add`](EGraph::add) or
    /// [`union`](EGraph::union), you must call `rebuild` to restore
    /// invariants before any query operations, otherwise the results
    /// may be stale or incorrect.
    ///
    /// This will set [`EGraph::clean`] to `true`.
    ///
    /// # Example
    /// ```
    /// use egg::{*, SymbolLang as S};
    /// let mut egraph = EGraph::<S, ()>::default();
    /// let x = egraph.add(S::leaf("x"));
    /// let y = egraph.add(S::leaf("y"));
    /// let ax = egraph.add_expr(&"(+ a x)".parse().unwrap());
    /// let ay = egraph.add_expr(&"(+ a y)".parse().unwrap());

    /// // Union x and y
    /// egraph.union(x, y);
    /// // Classes: [x y] [ax] [ay] [a]
    /// assert_eq!(egraph.find(x), egraph.find(y));
    ///
    /// // Rebuilding restores the congruence invariant, finding
    /// // that ax and ay are equivalent.
    /// egraph.rebuild();
    /// // Classes: [x y] [ax ay] [a]
    /// assert_eq!(egraph.number_of_classes(), 3);
    /// assert_eq!(egraph.find(ax), egraph.find(ay));
    /// ```
    pub fn rebuild(&mut self) -> usize {
        let old_hc_size = self.memo.len();
        let old_n_eclasses = self.number_of_classes();

        let start = Instant::now();

        let n_unions = self.process_unions();
        let trimmed_nodes = self.rebuild_classes();

        let elapsed = start.elapsed();
        info!(
            concat!(
                "REBUILT! in {}.{:03}s\n",
                "  Old: hc size {}, eclasses: {}\n",
                "  New: hc size {}, eclasses: {}\n",
                "  unions: {}, trimmed nodes: {}"
            ),
            elapsed.as_secs(),
            elapsed.subsec_millis(),
            old_hc_size,
            old_n_eclasses,
            self.memo.len(),
            self.number_of_classes(),
            n_unions,
            trimmed_nodes,
        );

        debug_assert!(self.check_memo());
        self.clean = true;
        n_unions
    }

    pub(crate) fn check_each_explain(&mut self, rules: &[&Rewrite<L, N>]) -> bool {
        if let Some(explain) = &mut self.explain {
            explain.with_nodes(&self.nodes).check_each_explain(rules)
        } else {
            panic!("Can't check explain when explanations are off");
        }
    }
}

struct EGraphDump<'a, L: Language, N: Analysis<L>>(&'a EGraph<L, N>);

impl<'a, L: Language, N: Analysis<L>> Debug for EGraphDump<'a, L, N> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let mut ids: Vec<Id> = self.0.classes().map(|c| c.id).collect();
        ids.sort();
        for id in ids {
            let mut nodes = self.0[id].nodes.clone();
            nodes.sort();
            writeln!(f, "{} ({:?}): {:?}", id, self.0[id].data, nodes)?
        }
        Ok(())
    }
}

impl<L: Language, N: Analysis<L>> EGraph<L, N> {
    /// Convert EGraph to JSON format and save to file
    pub fn to_json_file<P: AsRef<Path>>(
        &self,
        path: P
    ) -> Result<(), Box<dyn std::error::Error>>
    where
        L: Display,
    {
        let json_str = self.to_json_string()?;
        fs::write(path, json_str)?;
        Ok(())
    }

    /// Convert EGraph to JSON string
    pub fn to_json_string(&self) -> Result<String, Box<dyn std::error::Error>>
    where
        L: Display,
    {
        if self.json_graph.nodes.is_empty() {
            println!("\u{26A0}\u{FE0F} \x1b[33m Warning: json_graph.nodes is empty\x1b[0m");
        }
        if self.json_graph.root_eclasses.is_empty() {
            println!("\u{26A0}\u{FE0F} \x1b[33m Warning: json_graph.root_eclasses is empty\x1b[0m");
        }
        let json_str = serde_json::to_string_pretty(&self.json_graph)?;
        Ok(json_str)
    }

    pub fn to_json_data(&mut self,costmaps:Option<&Vec<(&str, &std::collections::HashMap<String,CostType>)>>)
    where
        L: Display,
    {
        let mut json_nodes: EnodeMap = HashMap::default();
        
        // Convert each eclass
        for class in self.classes() {
            let eclass_id = usize::from(class.id) as ClassType;
            let mut enode_map = HashMap::default();
            
            // Convert each node in the eclass
            for (enode_index, node) in class.nodes.iter().enumerate() {
                let node_id = format!("{}.{}", eclass_id, enode_index);
                
                // Extract children eclass IDs
                let children: Vec<ClassType> = node.children()
                    .iter()
                    .map(|&id| usize::from(self.find(id)) as ClassType)
                    .collect();

                // 处理多个cost属性
                let costs = if let Some(costmaps) = costmaps.as_ref() {
                    costmaps.iter()
                        .map(|(cost_name, costmap)| {
                            let cost_value = costmap.get(&node.to_string())
                                .copied()
                                .unwrap_or(NotNan::new(1.0).unwrap());
                            (cost_name.to_string(), cost_value)
                        })
                        .collect()
                } else {
                    // 默认只有一个cost
                    vec![("default".to_string(), NotNan::new(1.0).unwrap())]
                };

                let json_node = SerializedEnode {
                        op: node.to_string(),
                        costs,
                        children,
                        id: node_id,
                    };
                
                enode_map.insert(enode_index as NodeType, json_node);
            }
            
            if !enode_map.is_empty() {
                json_nodes.insert(eclass_id, enode_map);
            }
        }
        
        // Find root eclasses
        let root_eclasses: Vec<ClassType> = self.classes()
            .filter(|eclass| {
                // Root class if: 
                // 1. No parents at all, OR
                // 2. Only parent is itself (self-loop)
                eclass.parents.is_empty() || 
                (eclass.parents.len() == 1 && eclass.parents.contains(&eclass.id))
            })
            .map(|eclass| usize::from(eclass.id) as ClassType)
            .collect();

        self.json_graph = SerializedEgraph {
            nodes: json_nodes,
            root_eclasses,
        }
    }    
}

impl<L: Language, N: Analysis<L>> EGraph<L, N> {
    // TODO: POD相关函数为C++接口准备，当前注释掉避免影响编译
    // /// Load EGraph from POD data
    // /// 
    // /// Converts POD array to EGraph via JSON intermediate format
    // pub fn from_pod_data(
    //     nodes_slice: &[crate::pod::EGraphNodePOD],
    //     outputs: &[ClassType],
    //     input_len: usize,
    //     analysis: N,
    //     node_converter: impl Fn(&crate::json::SerializedEnode, &[Id]) -> L,
    // ) -> Result<Self, Box<dyn std::error::Error>> {
    //     // Convert POD to JSON format
    //     let egraph_data = crate::pod::pod_to_egraph_data(nodes_slice,input_len);
    //     // Create SerializedEgraph with outputs as root_eclasses
    //     let json_data = crate::json::SerializedEgraph {
    //         nodes: egraph_data,
    //         root_eclasses: outputs.to_vec(),
    //     };
    //     
    //     // Convert JSON to EGraph
    //     Self::from_json_data(json_data, analysis, node_converter)
    // }

    // TODO: POD相关函数为C++接口准备，当前注释掉避免影响编译
    // /// Convert EGraph to POD data
    // /// 
    // /// Returns (nodes, root_eclasses) tuple via JSON intermediate format
    // pub fn to_pod_data(&self) -> (Vec<crate::pod::EGraphNodePOD>, &Vec<ClassType>)
    // where
    //     L: Display,
    // {
    //     // Convert EGraph to JSON format
    //     if self.json_graph.nodes.is_empty() {
    //         println!("\u{26A0}\u{FE0F} \x1b[33m Warning: json_graph.nodes is empty\x1b[0m");
    //     }
    //     if self.json_graph.root_eclasses.is_empty() {
    //         println!("\u{26A0}\u{FE0F} \x1b[33m Warning: json_graph.root_eclasses is empty\x1b[0m");
    //     }
    //     let pod_nodes = crate::pod::egraph_data_to_pod(&(self.json_graph.nodes));
    //     
    //     (pod_nodes, &(self.json_graph.root_eclasses))
    // }

    /// Returns a vector of (eclass_id, fanout_node) pairs
    pub fn find_nodes_by_string (
        &self, 
        find_str: &str
    ) -> Vec<(Id, &L)>
    where
        L: Language,
    {
        let mut nodes = Vec::new();
        
        for eclass in self.classes() {
            for node in &eclass.nodes {
                if format!("{:?}", node).contains(find_str) {
                    nodes.push((eclass.id, node));
                }
            }
        }
        nodes
    }
}


impl<L: Language, N: Analysis<L>> EGraph<L, N> {
    /// Safely remove a leaf enode from its eclass
    /// 
    /// Returns `true` if the enode was successfully removed.
    /// 
    /// # Safety Conditions
    /// - The enode must be a leaf node (no children)
    /// - The eclass must contain at least one other node
    /// - The enode must exist in the egraph
    /// 
    /// # Example
    /// ```rust
    /// use egg::{*, SymbolLang as S};
    /// let mut egraph = EGraph::<S, ()>::default();
    /// 
    /// // Add some nodes to same eclass
    /// let x = egraph.add(S::leaf("x"));
    /// let temp = egraph.add(S::leaf("temp"));
    /// let y = egraph.add(S::leaf("y"));
    /// 
    /// egraph.union(x, temp);
    /// egraph.union(x, y);
    /// egraph.rebuild();
    /// 
    /// // Safe to remove temp since it's a leaf and eclass has other nodes
    /// let removed = egraph.remove_safe_enode(&S::leaf("temp"));
    /// assert!(removed);
    /// ```
    pub fn remove_safe_enode(&mut self, enode: &L) -> bool {
        // Safety check 1: Must be a leaf node (no children)
        if !enode.children().is_empty() {
            return false;
        }

        // Canonicalize the enode for memo lookup
        let mut canonical_enode = enode.clone();
        canonical_enode.update_children(|id| self.find(id));
        
        // Safety check 2: Enode must exist
        let Some(&enode_id) = self.memo.get(&canonical_enode) else {
            return false;
        };
        
        // Find the eclass this enode belongs to
        let class_id = self.find(enode_id);
        let class = &self.classes[&class_id];
        
        // Safety check 3: Eclass must have more than one node
        if class.nodes.len() <= 1 {
            return false;
        }
        
        // Safety check 4: Enode must actually be in this eclass
        if !class.nodes.contains(enode) {
            return false;
        }
        
        // All safety checks passed - perform the removal
        self.perform_safe_removal(&canonical_enode, class_id);
        
        true
    }
    
    /// Internal method to perform the actual removal
    fn perform_safe_removal(&mut self, canonical_enode: &L, class_id: Id) {
        // Remove from memo
        self.memo.remove(canonical_enode);
        
        // Remove from eclass
        let class = self.classes.get_mut(&class_id).unwrap();
        class.nodes.retain(|n| n != canonical_enode);
        
        // Update classes_by_op if needed
        self.update_classes_by_op(canonical_enode, class_id);
        
        // Recompute analysis for this eclass
        self.recompute_analysis_after_removal(class_id);
        
        // Mark egraph as dirty
        self.clean = false;
    }
    
    /// Update classes_by_op mapping after node removal
    fn update_classes_by_op(&mut self, removed_enode: &L, class_id: Id) {
        let op_discriminant = removed_enode.discriminant();
        let class = &self.classes[&class_id];
        
        // Check if any remaining nodes have the same discriminant
        let has_same_op = class.nodes.iter().any(|n| n.discriminant() == op_discriminant);
        
        if !has_same_op {
            // Remove this class from the op mapping
            if let Some(op_set) = self.classes_by_op.get_mut(&op_discriminant) {
                op_set.remove(&class_id);
                // Clean up empty entries
                if op_set.is_empty() {
                    self.classes_by_op.remove(&op_discriminant);
                }
            }
        }
    }
    
    /// Recompute analysis data for eclass after node removal
    /// 
    /// Since analysis belongs to the eclass (not individual enodes),
    /// we merge analysis contributions from all remaining enodes.
    fn recompute_analysis_after_removal(&mut self, class_id: Id) {
        // Get remaining nodes (avoiding borrow checker issues)
        let remaining_nodes = self.classes[&class_id].nodes.clone();
        
        if remaining_nodes.is_empty() {
            // This should never happen due to our safety checks
            panic!("Attempted to recompute analysis for empty eclass");
        }
        
        // Compute analysis data by merging contributions from all remaining enodes
        let mut new_analysis_data = N::make(self, &remaining_nodes[0]);
        
        for node in remaining_nodes.iter().skip(1) {
            let node_analysis = N::make(self, node);
            self.analysis.merge(&mut new_analysis_data, node_analysis);
        }
        
        // Update the eclass analysis data
        self.classes.get_mut(&class_id).unwrap().data = new_analysis_data;
        
        // Trigger analysis propagation
        N::modify(self, class_id);
        self.analysis_pending.insert(class_id);
    }
    
    /// Remove multiple leaf enodes matching a predicate
    /// 
    /// Only removes enodes that satisfy all safety conditions.
    /// Returns the number of enodes successfully removed.
    /// 
    /// This is more efficient than calling remove_safe_enode multiple times
    /// because it batches analysis recomputation.
    pub fn remove_safe_enodes_if<F>(&mut self, mut predicate: F) -> usize 
    where 
        F: FnMut(&L) -> bool,
    {
        // Collect safe removals to avoid borrowing conflicts
        let mut safe_removals = Vec::new();
        
        for (enode, &enode_id) in &self.memo {
            // Check if matches predicate and satisfies safety conditions
            if enode.children().is_empty() && predicate(enode) {
                let class_id = self.find(enode_id);
                let class = &self.classes[&class_id];
                
                if class.nodes.len() > 1 && class.nodes.contains(enode) {
                    safe_removals.push((enode.clone(), class_id));
                }
            }
        }
        
        // Track which classes need analysis recomputation
        let mut affected_classes = std::collections::HashSet::new();
        let mut removed_count = 0;
        
        // Perform removals without analysis update
        for (enode, class_id) in safe_removals {
            if self.remove_without_analysis_update(&enode, class_id) {
                affected_classes.insert(class_id);
                removed_count += 1;
            }
        }
        
        // Batch recompute analysis for all affected classes
        for class_id in affected_classes {
            self.recompute_analysis_after_removal(class_id);
        }
        
        removed_count
    }
    
    /// Remove enode without updating analysis (for batch operations)
    fn remove_without_analysis_update(&mut self, enode: &L, class_id: Id) -> bool {
        // Final safety check
        let class = &self.classes[&class_id];
        if class.nodes.len() <= 1 || !class.nodes.contains(enode) {
            return false;
        }
        
        // Create canonical version for memo removal
        let mut canonical_enode = enode.clone();
        canonical_enode.update_children(|id| self.find(id));
        
        // Perform removal
        self.memo.remove(&canonical_enode);
        
        let class = self.classes.get_mut(&class_id).unwrap();
        class.nodes.retain(|n| n != enode);
        
        // Update classes_by_op
        self.update_classes_by_op(&canonical_enode, class_id);
        
        self.clean = false;
        true
    }
}

pub fn debug_egraph_structure<L: Language + Display, N: Analysis<L>>(egraph: &EGraph<L, N>) {
    println!("=== EGraph Structure Debug ===");
    for class in egraph.classes() {
        println!("EClass {}: {} nodes", usize::from(class.id), class.nodes.len());
        for (i, node) in class.nodes.iter().enumerate() {
            println!("  Node {}: {}", i, node.to_string());
        }
    }
    println!("==============================");
}




#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn simple_add() {
        use SymbolLang as S;

        crate::init_logger();
        let mut egraph = EGraph::<S, ()>::default();

        let x = egraph.add(S::leaf("x"));
        let x2 = egraph.add(S::leaf("x"));
        let _plus = egraph.add(S::new("+", vec![x, x2]));

        egraph.union_instantiations(
            &"x".parse().unwrap(),
            &"y".parse().unwrap(),
            &Default::default(),
            "union x and y".to_string(),
        );
        egraph.rebuild();
    }

    #[cfg(all(feature = "serde-1", feature = "serde_json"))]
    #[test]
    fn test_serde() {
        fn ser(_: &impl Serialize) {}
        fn de<'a>(_: &impl Deserialize<'a>) {}

        let mut egraph = EGraph::<SymbolLang, ()>::default();
        egraph.add_expr(&"(foo bar baz)".parse().unwrap());
        ser(&egraph);
        de(&egraph);


        let json_rep = serde_json::to_string_pretty(&egraph).unwrap();
        println!("{}", json_rep);
    }


    #[cfg(all(feature = "serde-1", feature = "serde_json"))]
    #[test]
    fn json_file() {
        let mut egraph = EGraph::<SymbolLang, ()>::default();
        egraph.add_expr(&"(foo bar baz)".parse().unwrap());
        egraph.to_json_data(None);
        println!("{}", egraph.to_json_string().unwrap());

        println!("--------------------------------");

        let mut new_egraph = EGraph::from_json_str_symbollang(egraph.to_json_string().unwrap().as_str(), ()).unwrap();
        new_egraph.to_json_data(None);
        println!("{}", new_egraph.to_json_string().unwrap());
    }
}

impl<N: Analysis<SymbolLang>> EGraph<SymbolLang, N> {
    pub fn append_roots_from_with_cost<CF: CostFunction<SymbolLang>>(
        &mut self,
        src: &EGraph<SymbolLang, N>,
        src_roots: &[Id],
        cost_fn: CF,
    ) -> (Id, RecExpr<SymbolLang>) {
        let ext = Extractor::new(src, cost_fn);
        assert!(src_roots.len() == 1);
        let (_cost, expr) = ext.find_best(src.find(src_roots[0]));
        let id = self.add_expr(&expr);
        self.rebuild();
        (id, expr)
    }
}

