"""
Architecture overview (updated)

Goal
- Model MLIR dataflow as a bipartite-style directed graph on top of networkx.DiGraph:
  - Two node kinds: Operation nodes (e.g., "Arith_Addi_0") and Data nodes (e.g., "%0", "%arg5", "bedge3")
  - Directed edges: producer_op -> data_node -> consumer_op (one producer, multiple consumers per data)

Design highlights
- Strong typing with enums (DataType, Dialect, and each dialect's Op enum) mirroring the C++ `_op_type`/`_dtype`.
  Ensures only valid Dialect/Op/Dtype combinations are used.
- Metadata lives on the networkx graph:
  - Operation node attributes: dialect/op/dtype/dimension/line/block_level/input_data/output_data
  - Data node attributes: dtype/dimension/line/producer/consumers

Invariants
- (dialect, op) must be a valid combination for the dialect (enforced by enums)
- dtype must come from DataType
- Each data hyper-edge has exactly one producer and zero or more consumers

Main components
- Enums: `DataType`, `Dialect`, and op enums for each dialect (ArithOp, MemrefOp, FuncOp, ScfOp, AffineOp, SSOp, AssignOp, BlockOp)
- Operation: an operation instance (name, dialect, op kind, dtype, dims, source line, block nesting level, input/output names)
- DataEdge: data metadata (name, dtype, dims, line, producer, consumers)
- HyperGraph:
  - add_operation: add/update an op node, validate types, and attach full metadata on the graph
  - add_data_edge: add a data node (dtype/dimension/line/producer/consumers in one shot), connect producer->data and data->consumers
  - update_edge_add_consumer: append a consumer for an existing data node (add data_node->consumer_op edge)
  - operations/edges: metadata queries; to_networkx: return the live networkx.DiGraph with attributes

Notes
- This module requires networkx at runtime.
"""

from __future__ import annotations

from enum import Enum
from typing import Dict, List, Optional, Tuple, List

# Core now relies on networkx
import networkx as nx
from ordered_set import OrderedSet  # type: ignore
from egraph import *
from utils import check_types, find_brace_pairs, split
from infix2prefix import infix_to_prefix
import re



def parse_mlir_datatype_and_shape(s: str) -> Tuple[str, List[int]]:
    s = (s or "").strip().lower()
    if not s:
        return ("none", [])
    if '<' in s and '>' in s:
        core = s[s.find('<') + 1 : s.rfind('>')].strip()
        assert ("<" not in core and ">" not in core and "x" in core), f"Invalid MLIR type format: {s}"
        parts = [p for p in core.split('x') if p]
        dtype = parts[-1]
        dims = [int(p) if p.isdigit() else -1 for p in parts[:-1]]
        return (dtype, dims)
    else:
        assert ("<" not in s and ">" not in s), f"Invalid MLIR type format: {s}"
        return (s,[])

# Inline map; optional max/min wrapper (no outer parentheses)
_RE_INLINE_MAP = re.compile(
    r'^(?:(max|min)\s+)?(#[A-Za-z0-9_-]+\(\s*[^)]*?\s*\)(?:\s*\[\s*[^\]]*?\s*\])?)$'
)


def to_prefix_for_expr(expr: str, affine_maps: Dict[str, str]) -> str:
    """Normalize a for-header fragment into a prefix string consumable by _lower_prefix_into_graph."""
    s = expr.strip()
    m = _RE_INLINE_MAP.match(s)
    if m:
        wrap = m.group(1)       # "max" / "min" / None
        invk = m.group(2)       # "#mapX(%...)[%...]"
        mname = re.match(r'#([A-Za-z0-9_-]+)\(', invk)
        assert mname, f"Malformed map invocation: {expr}"
        key = f"#{mname.group(1)}"
        assert key in affine_maps, f"Unknown affine_map {key}"
        infix = flatten_affine_map(affine_maps[key], invk)
        pairs = find_brace_pairs(infix, "(", ")")
        has_outer = ((0,0),(0,len(infix)-1)) in pairs

        if wrap:
            # If wrapped: remove existing outer parentheses (if any), then wrap once
            core = infix[1:-1] if has_outer else infix
            infix = f"{wrap}({core})"
        else:
            # Otherwise ensure exactly one layer of outer parentheses
            if not has_outer:
                infix = f"({infix})"
        return infix_to_prefix(infix)

    # Leaf token: directly return as a prefix atom
    if s.startswith('%') or s.isdigit():
        return s

    # Fallback: convert infix to prefix (supports max/min(...) and general arithmetic)
    return infix_to_prefix(s)



def flatten_affine_map(map_pattern: str, input_string: str) -> str:
    """
    Python reimplementation of flattenAffineMap:
    - Support optional [s...] section
    - Map name must match
    - Use split(..., ",") to split d/s variables and input values (no stripping, matching C++ behavior)
    - Join with single spaces at the end (equivalent to the original concatenateWithCustomSeparator)
    """
    map_regex = re.compile(r"#([A-Za-z0-9_-]+)\s*=\s*affine_map<\s*\(\s*([^)]*?)\s*\)(?:\s*\[\s*([^\]]*?)\s*\])?\s*->\s*\(\s*(.*?)\s*\)\s*>$")
    # input_regex = re.compile(r"#(\w+)\{(.*?)\}(?:\[(.*?)\])?")
    input_regex = re.compile(r"#([A-Za-z0-9_-]+)\(\s*([^)]*?)\s*\)(?:\s*\[\s*([^\]]*?)\s*\])?$")

    m_map = map_regex.search(map_pattern)
    if not m_map or len(m_map.groups()) < 4:
        raise ValueError("Invalid map pattern")

    map_name = m_map.group(1)
    d_vars   = split(m_map.group(2), ",")                 # e.g. ["d0", " d1"]
    s_vars   = split(m_map.group(3), ",") if m_map.group(3) else []
    out_pat  = m_map.group(4)

    m_in = input_regex.search(input_string)
    if not m_in or len(m_in.groups()) < 3 or m_in.group(1) != map_name:
        raise ValueError("Invalid input string or map name mismatch")

    d_inputs = split(m_in.group(2), ",")                  # e.g. ["%arg1", " %arg2"]
    s_inputs = split(m_in.group(3), ",") if m_in.group(3) else []

    # Replace in order (no escaping; consistent with C++ std::regex replace)
    result = out_pat
    for i in range(len(d_vars)):
        if i < len(d_inputs):
            result = re.sub(d_vars[i], d_inputs[i], result)

    for i in range(len(s_vars)):
        if i < len(s_inputs):
            result = re.sub(s_vars[i], s_inputs[i], result)

    # Equivalent to: concatenateWithCustomSeparator(split(result, " "), " ")
    return " ".join(split(result, " "))



# =========================
# Helpers: parse "dialect.operation" into enums
# =========================

def parse_dialect_operation(op_str: str) -> tuple[Dialect, Enum]:
    """Parse a string like "arith.addi" into (Dialect.ARITH, ArithOp.ADDI).

    - Case-insensitive for both dialect and operation
    - Matches operation by enum member name or its value (both case-insensitive)
    - Supported dialects: arith, memref, func, scf, affine, ss, assign, block

    Raises:
        ValueError if cannot recognize dialect or operation.
    """
    s = op_str.strip()

    if '.' not in s:
        raise ValueError(f"Invalid op string '{op_str}'; expected 'dialect.operation'")
    if s.count('.') != 1:
        raise ValueError(f"Invalid op string '{op_str}'; expected exactly one '.' separator")
    d_part, o_part = map(str.strip, s.split('.', 1))

    # Dialect by map (value) or enum name fallback
    d_key = d_part.lower()
    try:
        dialect = dialect_map[d_key]  # type: ignore[name-defined]
    except KeyError:
        raise ValueError(f"Unknown dialect in '{d_part}'")

    op_enum_cls = _DIALECT_TO_OP_ENUM.get(dialect)
    if op_enum_cls is None:
        raise ValueError(f"Dialect '{dialect}' not supported in mapping table")

    # match by enum value using prebuilt dict (all values are lowercase)
    val = o_part.lower()
    m = _ENUM_VALUE_MAP[op_enum_cls].get(val)
    if m is not None:
        return dialect, m

    raise ValueError(f"Unknown operation '{o_part}' for dialect '{dialect.value}'")


def parse_operation(Dialect: Dialect, op_str: str) -> Enum:
    primary = f"{Dialect.name.upper()}Op"
    secondary = f"{Dialect.name.title()}Op"
    op_cls = _globals.get(primary) or _globals.get(secondary)
    op = _ENUM_VALUE_MAP[op_cls].get(op_str)
    if op is not None:
        return op
    raise ValueError(f"Unknown operation '{op_str}' for dialect '{Dialect.value}'")




# =========================
# Enums (kept strict)
# =========================


class DataType(Enum):
    NONE = "none"
    INDEX = "index"
    I32 = "i32"
    I64 = "i64"
    F32 = "f32"
    F64 = "f64"
    I1INDEX = "i1index"
    I4INDEX = "i4index"
    I8INDEX = "i8index"
    I16INDEX = "i16index"
    I32INDEX = "i32index"
    I64INDEX = "i64index"
    CONSTANT = "constant"


class Dialect(Enum):
    ARITH = "arith"
    MEMREF = "memref"
    FUNC = "func"
    SCF = "scf"
    AFFINE = "affine"
    SS = "ss"
    ASSIGN = "assign"
    MATH = "math"
    BLOCK = "block"

class MathOp(Enum):
    FLOORDIV = "floordiv"
    CEILDIV = "ceildiv"
    MOD = "mod"
    PERCENT = "%"
    DIV = "/"
    MUL = "*"
    ADD = "+"
    SUB = "-"
    INV = "inv"
    MAX = "max"
    MIN = "min"


class ArithOp(Enum):
    NONE = "none"
    ADDI = "addi"
    MULI = "muli"
    ADDF = "addf"
    MULF = "mulf"
    SUBF = "subf"
    SUBI = "subi"
    DIVF = "divf"
    DIVI = "divi"
    SHLI = "shli"
    ORI = "ori"
    XORI = "xori"
    ANDI = "andi"
    CMPI = "cmpi"
    CONSTANT = "constant"
    INDEXCAST = "indexcast"


class MemrefOp(Enum):
    NONE = "none"
    LOAD = "load"
    STORE = "store"


class FuncOp(Enum):
    NONE = "none"
    FUNC = "func"
    RETURN = "return"


class ScfOp(Enum):
    NONE = "none"
    FORVALUE = "forvalue"
    FORCONTROL = "forcontrol"
    IF = "if"


class AffineOp(Enum):
    NONE = "none"
    FORVALUE = "forvalue"
    FORCONTROL = "forcontrol"
    IF = "if"
    LOAD = "load"
    STORE = "store"
    APPLY = "apply"


class SSOp(Enum):
    NONE = "none"
    SOURCE = "source"
    SINK = "sink"


class AssignOp(Enum):
    ASSIGN = "assign"


class BlockOp(Enum):
    BLOCK = "block"


# Mapping Dialect -> its allowed operation enum class (constructed by naming convention)
# Convention:
#  - Primary: <Dialect.name (UPPER)> + "Op", e.g., SS -> SSOp
#  - Secondary: <Dialect.name (Title Case)> + "Op", e.g., ARITH -> ArithOp
_DIALECT_TO_OP_ENUM: dict[Dialect, type[Enum]] = {}
_globals = globals()
for d in Dialect:
    primary = f"{d.name.upper()}Op"
    secondary = f"{d.name.title()}Op"
    op_cls = _globals.get(primary) or _globals.get(secondary)
    if op_cls is None:
        raise RuntimeError(f"Cannot locate Op enum class for dialect '{d.name}'. Tried: {primary}, {secondary}")
    _DIALECT_TO_OP_ENUM[d] = op_cls  # type: ignore[assignment]

dialect_map = {k: d for d in Dialect for k in {d.value.lower(), d.name.lower()}}

# Auto-build string -> DataType enum map (supports both enum value and name, lowercased)
datatype_map = {k: t for t in DataType for k in {t.value.lower(), t.name.lower()}}


# Precompute lookup cache once at import: enum class -> { value(lower): member }
# Build from the central `_DIALECT_TO_OP_ENUM` to avoid manual maintenance when extending dialects.
_ENUM_VALUE_MAP: dict[type[Enum], dict[str, Enum]] = {
    enum_cls: {str(member.value).lower(): member for member in enum_cls}
    for enum_cls in set(_DIALECT_TO_OP_ENUM.values())
}



# =========================
# Core data model (all metadata is attached on networkx)
# =========================


class HyperGraph:
    """Directed graph model: Operation and Data are nodes; edges represent production and consumption.

    Constraints:
    - Dialect/Op/Dtype validated by enums
    - Each data has at most one producer and multiple consumers
    """

    def __init__(self) -> None:
        # Live networkx.DiGraph
        self._G: nx.DiGraph = nx.DiGraph()
        # Count (Dialect, Op) occurrences for stats (initialized to 0, maintained in add_operation)
        self.num_dialect: Dict[Dialect, Dict[Enum, int]] = {}
        for d, enum_cls in _DIALECT_TO_OP_ENUM.items():
            self.num_dialect[d] = {member: 0 for member in enum_cls}
        self._pseudo_node_count: int = 0
        self.egraph: Serialized_Egraph = Serialized_Egraph()
        self.name2id: Dict[str, int] = {}
        self.todo_blist = []
        self.done_blist = []
        self.iv_data_of: Dict[str, str] = {}


    # ---------- Validation helpers ----------
    
    def _validate_op(self, dialect: Dialect, op: Enum) -> None:
        # Validate: op must be a member of the dialect's op enum
        if dialect not in _DIALECT_TO_OP_ENUM:
            raise ValueError(f"Unsupported dialect: {dialect}")
        op_enum = _DIALECT_TO_OP_ENUM[dialect]
        if not isinstance(op, op_enum):
            raise ValueError(f"Operation {op} not valid for dialect {dialect}; expected {op_enum.__name__}")

    
    def _validate_dtype(self, dtype: DataType) -> None:
        # Validate dtype is a DataType
        if not isinstance(dtype, DataType):
            raise ValueError(f"Invalid dtype: {dtype}")

    # No extra snapshot structure is maintained; all metadata is stored on _G

    # ---------- Operation management ----------
    
    def add_operation(
        self,
        name: str,
        op_name: str,
        dialect: Dialect,
        op: Enum,
        dtype: DataType,
        dimension: List[int],
        line: int,
        input_data: Optional[List[str]] = None,
        output_data: Optional[str] = "",
    ) -> str:
        """Add or update an operation node.

        If an op of the same name exists, update idempotently. This will:
        1) Validate types
        2) Register input/output data names as hyper-edges
        3) Attach the op to the corresponding data hyper-edges
        4) Keep the internal hypergraph consistent
        """
        if name in self._G and self._G.nodes[name].get("kind") == "op":
            return
        self._validate_op(dialect, op)
        self._validate_dtype(dtype)
        if output_data == "":
            output_data = f"%pseudo_{self._pseudo_node_count}"
            self._pseudo_node_count += 1
        block_level = self.todo_blist[-1] if len(self.todo_blist) > 0 else ""
        # All metadata lives on _G; ensure op node exists and sync attributes
        if name not in self._G:
            self._G.add_node(name, kind="op")
        self._G.nodes[name].update({
            "kind": "op",
            "op_name": op_name,
            "dialect": dialect.value,
            "op": op.value if hasattr(op, 'value') else str(op),
            "dtype": dtype.value,
            "dimension": dimension,
            "line": int(line),
            "block_level": block_level,
            "input_data": [],
            "output_data": output_data,
        })
        eid = len(self.egraph.nodes)
        self.egraph.nodes[eid] = {0: Serialized_Egraph_Node(op=op_name, costs=[], children=[], id=f"")}
        self.name2id[name] = eid
        # Increase count for this (dialect, op)
        self.num_dialect[dialect][op] += 1
        for _oprand in input_data:
            self.update_edge_add_consumer(data_name=_oprand, consumer_op=name)
        self.add_data_edge(name=output_data, dtype=dtype, dimension=dimension, line=line, producer=name)
        if dialect == Dialect.BLOCK:
            assert op == BlockOp.BLOCK, f"Block operation must be BlockOp.BLOCK"
            self.todo_blist.append(name)
        return output_data

    # ---------- Data edge management ----------
    
    def add_data_edge(
        self,
        name: str,
        dtype: DataType,
        dimension: List[int],
        line: int,
        producer: Optional[str] = None,
    ) -> None:
        """Create a new data node (no updating existing ones), and connect producer->data and data->consumers.

        Constraints:
        - Must provide a producer that already exists as an Operation node
        - If the data edge exists, raise; use update_edge_add_consumer to append consumers
        """
        self._validate_dtype(dtype)
        if name in self._G and self._G.nodes[name].get("kind") == "data":
            raise ValueError(f"Edge {name} already exists; use update_edge_add_consumer() to append consumers")
        if producer is None:
            raise ValueError(f"Edge {name} must have a producer; got None")
        if producer not in self._G or self._G.nodes[producer].get("kind") not in ["op", "block"]:
            raise ValueError(f"Producer op '{producer}' not found or not an op node; add the operation first")

        if len(self.todo_blist) > 0:
            block_name = self.todo_blist[-1]
            block_node = self._G.nodes[block_name]
            self._G.add_edge(name,block_name)
            block_node["input_data"].append(name)
            block_eid = self.name2id[block_name]
            self.egraph.nodes[block_eid][0].children.append(self.name2id[producer])
        else:
            block_name = ""
        # New: write all metadata to the data node at once
        if name not in self._G:
            self._G.add_node(name, kind="data")
        self._G.nodes[name].update({
            "kind": "data",
            "dtype": dtype.value,
            "dimension": dimension,
            "line": int(line),
            "producer": producer,
            "consumers": OrderedSet([block_name]),
            "block_level": block_name,
        })
        # Sync producer/consumer input_data/output_data metadata
        prod_out = self._G.nodes[producer].get("output_data")
        if prod_out in (None, ""):
            self._G.nodes[producer]["output_data"] = name
        elif prod_out != name:
            raise ValueError(f"Producer '{producer}' already has output_data '{prod_out}', cannot overwrite with '{name}'")
        # Connect producer_op -> data_node (producer already validated as an op)
        self._G.add_edge(producer, name)
        return

    
    def update_edge_add_consumer(self, data_name: str, consumer_op: str) -> None:
        """Append a consumer to an existing data edge.

        Requirements:
        - data_name must already exist (created via add_data_edge)
        - Only append a consumer; do not modify dtype/dimension/line/producer
        """
        if data_name not in self._G or self._G.nodes[data_name].get("kind") != "data":
            raise ValueError(f"Edge {data_name} does not exist; create it with add_data_edge() first")
        # Consumer must exist and be an op
        if consumer_op not in self._G or self._G.nodes[consumer_op].get("kind") != "op":
            raise ValueError(f"Consumer op '{consumer_op}' not found or not an op node; add the operation first")
        # Update the data node's consumers list and connect data_node -> consumer_op
        self._G.add_edge(data_name, consumer_op)
        # Maintain order and uniqueness via OrderedSet
        consumers = self._G.nodes[data_name].get("consumers")
        assert isinstance(consumers, OrderedSet), "consumers must be an OrderedSet"
        consumers.add(consumer_op)
        self._G.nodes[data_name]["consumers"] = consumers
        # Sync consumer's input_data metadata (OrderedSet)
        cin = self._G.nodes[consumer_op].get("input_data")
        assert isinstance(cin, List), f"input_data of op '{consumer_op}' must be an List"
        cin.append(data_name)
        consumer_id = self.name2id[consumer_op]
        producers = list(self._G.predecessors(data_name))
        assert len(producers) == 1, f"Data '{data_name}' has multiple producers: {producers}"
        producer_id = self.name2id[producers[0]]
        self.egraph.nodes[consumer_id][0].children.append(producer_id)
        self._G.nodes[consumer_op]["input_data"] = cin


        block_name = self._G.nodes[data_name].get("block_level")
        if self._G.has_edge(data_name,block_name):
            self._G.remove_edge(data_name,block_name)
            self._G.nodes[block_name]["input_data"].remove(data_name)
            self.egraph.nodes[self.name2id[block_name]][0].children.remove(self.name2id[producers[0]])
            consumers.remove(block_name)
        return


    
    def predecessors(self, op_name: str) -> List[str]:
        in_edges = self._G.predecessors(op_name)
        predecessors = []
        for edge in in_edges:
            predecessors.extend(self._G.predecessors(edge))
        return predecessors

    
    def successors(self, op_name: str) -> List[str]:
        out_edges = self._G.successors(op_name)
        successors = []
        for edge in out_edges:
            successors.extend(self._G.successors(edge))
        return successors

    
    def _ensure_data_node(self, name: str, line_num: int) -> str:
        """Ensure a leaf (constant or existing SSA) has a data node; create a source constant if needed."""
        if name in self._G and self._G.nodes[name].get("kind") == "data":
            return name
        # Existing source op should have created a data node; recheck here
        if name in self._G and self._G.nodes[name].get("kind") == "op":
            # Normally not reached; op node's output_data already created the data node
            return name
        if name.isdigit():
            # Constant: create a source constant node
            self.add_operation(
                name="source"+name,
                op_name=name,
                dialect=Dialect.SS,
                op=SSOp.SOURCE,
                dtype=DataType.CONSTANT,
                dimension=[],
                line=line_num,
                input_data=[],
                output_data=name,
            )
            return name
        # Variable: usually func.func args / earlier SSA exist; otherwise fallback to a source (index)
        if name not in self._G:
            self.add_operation(
                name="source"+name,
                op_name=name,
                dialect=Dialect.SS,
                op=SSOp.SOURCE,
                dtype=DataType.INDEX,
                dimension=[],
                line=line_num,
                input_data=[],
                output_data=name,
            )
        return name

    
    def _add_math_node(self, op_str: str, inputs: List[str], line_num: int, out_ssa: Optional[str]) -> str:
        """
        Create a Dialect.MATH op and return its output data name.
        - egraph node's op field uses raw strings: floordiv/ceildiv/mod/inv/max/min/+/-/*//%
        - dtype is not encoded in the op name; graph node dtype is NONE for these ops
        """
        # Parse into MathOp (must be supported)
        op_enum = parse_operation(Dialect.MATH, op_str)

        # Count to generate a unique graph node name (graph key only, not the egraph op name)
        idx = self.num_dialect[Dialect.MATH][op_enum]

        # egraph op field: use the raw operator string
        op_name_for_egraph = op_str

        # Graph node name readable and unique; add a prefix for clarity
        node_name = f"math_{op_str}_{idx}"

        # Write to Graph / egraph:
        # - op_name is what's recorded in egraph (raw operator)
        # - dtype is irrelevant for these ops; use DataType.NONE
        return self.add_operation(
            name=node_name,
            op_name=op_name_for_egraph,              # egraph.nodes[...][0].op will be like "*", "+", "floordiv"
            dialect=Dialect.MATH,
            op=op_enum,
            dtype=DataType.NONE,                      # dtype agnostic for these ops
            dimension=[],
            line=line_num,
            input_data=inputs,
            output_data=(out_ssa or ""),
        )

    
    def _lower_prefix_into_graph(self, tokens: List[str], pos: int, line_num: int, want_out: Optional[str]) -> Tuple[str, int]:
        """
        Recursively lower the prefix expression into the graph.
        Return (result_data_name, new_pos).
        """
        def peek() -> str:
            return tokens[pos] if pos < len(tokens) else ''
        nonlocal_pos = pos

        def nxt() -> str:
            nonlocal nonlocal_pos
            t = tokens[nonlocal_pos] if nonlocal_pos < len(tokens) else ''
            if t:
                nonlocal_pos += 1
            return t

        t = nxt()
        if t == '(':
            op = nxt()
            args_datas: List[str] = []
            # Read until ')'
            while True:
                if tokens[nonlocal_pos] == ')':
                    nxt()  # consume ')'
                    break
                res, nonlocal_pos = self._lower_prefix_into_graph(tokens, nonlocal_pos, line_num, None)
                args_datas.append(res)

            # Unary inv
            if op == 'inv':
                assert len(args_datas) == 1, f"inv expects 1 arg, got {len(args_datas)}"
                out = self._add_math_node('inv', args_datas, line_num, want_out)
                return out, nonlocal_pos

            # Variadic max/min
            if op in {'max', 'min'}:
                assert len(args_datas) >= 1, f"{op} needs at least 1 arg"
                out = self._add_math_node(op, args_datas, line_num, want_out)
                return out, nonlocal_pos

            # Binary ops
            if op in {'+','-','*','/','%','floordiv','ceildiv','mod'}:
                assert len(args_datas) == 2, f"{op} expects 2 args, got {len(args_datas)}"
                out = self._add_math_node(op, args_datas, line_num, want_out)
                return out, nonlocal_pos

            raise ValueError(f"unknown op in prefix: {op}")
        else:
            # Leaf: constant or SSA/identifier
            dn = self._ensure_data_node(t, line_num)
            return dn, nonlocal_pos

    # ---------- Queries ----------
    @property
    def operations(self) -> Dict[str, Dict]:
        return {n: dict(self._G.nodes[n]) for n in self._G.nodes if self._G.nodes[n].get("kind") == "op"}

    @property
    def edges(self) -> Dict[str, Dict]:
        return {n: dict(self._G.nodes[n]) for n in self._G.nodes if self._G.nodes[n].get("kind") == "data"}

    
    def to_networkx(self) -> nx.DiGraph:
        """Return the live networkx.DiGraph (node/edge attributes attached)."""
        return self._G


if __name__ == "__main__":
    # Minimal self-check:
    # 1) Create three ops: one producer, two consumers
    # 2) Create a data edge %2 with a producer and an initial consumer
    # 3) Append a second consumer
    # 4) Print nodes/edges to verify structure and attributes
    g = HyperGraph()

    # Add ops first so data edges can reference the producer

    g.add_operation(
        name="%2",
        op_name = "%2",
        dialect=Dialect.SS,
        op=SSOp.SOURCE,
        dtype=DataType.NONE,
        dimension=[],
        line=10,
        input_data=[],
        output_data="%2",
    )
    g.add_operation(
        name="%0",
        op_name = "%0",
        dialect=Dialect.SS,
        op=SSOp.SOURCE,
        dtype=DataType.NONE,
        dimension=[],
        line=10,
        input_data=[],
        output_data="%0",
    )
    g.add_operation(
        name="%1",
        op_name = "%1",
        dialect=Dialect.SS,
        op=SSOp.SOURCE,
        dtype=DataType.NONE,
        dimension=[],
        line=10,
        input_data=[],
        output_data="%1",
    )
    g.add_operation(
        name="Arith_Addi_0",
        op_name = "arith_addi_2",
        dialect=Dialect.ARITH,
        op=ArithOp.ADDI,
        dtype=DataType.I32,
        dimension=[-1,900],
        line=10,
        input_data=["%0", "%1"],
        output_data="%3",
    )
    g.add_operation(
        name="Arith_Mulf_1",
        op_name = "arith_mulf_2",
        dialect=Dialect.ARITH,
        op=ArithOp.MULF,
        dtype=DataType.F32,
        dimension=[-1,900],
        line=11,
        input_data=["%2"],
        output_data="",
    )
    g.add_operation(
        name="Arith_Addf_2",
        op_name = "arith_addi_2",
        dialect=Dialect.ARITH,
        op=ArithOp.ADDF,
        dtype=DataType.F32,
        dimension=[-1,900],
        line=12,
        input_data=["%2"],
        output_data="",
    )

    # Append the second consumer
    g.update_edge_add_consumer("%2", "Arith_Addf_2")

    G = g.to_networkx()
    print("Nodes (with attributes):")
    for n, attrs in G.nodes(data=True):
        print(n, attrs)
    print("\nEdges (with attributes):")
    for u, v, attrs in G.edges(data=True):
        print(f"{u} -> {v}", attrs)
    print("\nConsumers of %2:", list(G.nodes["%2"]["consumers"]))
