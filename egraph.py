from dataclasses import dataclass, field
from typing import Dict, List, Tuple

@dataclass
class Serialized_Egraph_Node:
    op: str
    costs: List[Tuple[str, float]]
    children: List[int]
    id: str

@dataclass
class Serialized_Egraph:
    nodes: Dict[int, Dict[int, Serialized_Egraph_Node]] = field(default_factory=dict)
    root_eclasses: List[int] = field(default_factory=list)