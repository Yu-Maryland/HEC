"""
MLIR parser (Python) that builds a HyperGraph compatible with graph.HyperGraph,
covering a minimal but useful subset:

- Collect affine_map lines into a dict
- Parse func.func header (arguments as inputs)
- Parse assignment ops for common dialects:
  arith.(addi, addf, muli, mulf, subi, subf, divi, divf, shli, index_cast, constant)
  memref.(load, store)
  affine.(load, store, apply)
- Create Source producers for any input SSA that lacks a known producer

Notes:
- This is an incremental reimplementation aimed at producing a usable intermediate graph.
- Loop/Block structures are not yet reflected; block_level is set to 0 for now.
- DTypes are inferred best-effort from the trailing type annotation or default to None.
"""

from __future__ import annotations
import argparse
import re
from typing import Dict
import preprocess
import json
from dataclasses import asdict
from infix2prefix import infix_to_prefix, tokenize_prefix
from graph import *
from graph import to_prefix_for_expr
from utils import canbeparsedas


# ----------------------
# Helpers
# ----------------------


_RE_ASSIGN = re.compile(
    r'^(?:(%[^\s=]+)\s*=\s*)?([A-Za-z0-9_.]+)\s+([^:]+?)\s*:\s*([^:#"]*)$'
)

_RE_FOR = re.compile(
    r'^([A-Za-z.]+)\s+(%\w+)\s*=\s*([%\w]+)\s+to\s+([%\w]+)(?:\s+step\s+([%\w]+))?\s*\{$'
)

# Regex set (keep original _RE_FOR unchanged; add a more permissive matcher)
_RE_FOR_FLEX = re.compile(
    r'^(affine\.for|scf\.for)\s+(%\w+)\s*=\s*(.*?)\s+to\s*(.*?)\s*(?:step\s*(.*?))?\s*\{$'
)


_RE_BLOCK_END = re.compile(
    r'^\s*\}\s*$'
)

_RE_APPLY = re.compile(
    r'^(%[A-Za-z0-9_]+)\s*=\s*affine\.apply\s+(?=(#[A-Za-z0-9_-]+))(#[A-Za-z0-9_-]+\(\s*[^)]*?\s*\)(?:\s*\[\s*[^\]]*?\s*\])?)$'
)





def parse_mlir_to_graph(text: str) -> HyperGraph:
    g = HyperGraph()
    affine_maps: Dict[str, str] = {}

    lines = text.splitlines()

    arg_list = {}

    for line_num, line in enumerate(lines, start=1):  # 1-based line numbers
        s = line.strip()
        if not s or s.startswith("///") or 'return' in s or "module attributes" in s:
            continue
        
        # Parse affine_map definitions and store them
        if "affine_map" in s:
            # Expected format: #map = affine_map<...>
            # Count '>' characters to ensure proper format (should be 2)
            gt_count = s.count('>')
            assert gt_count == 2 and s.endswith('>'), f"Invalid affine_map format: {s}"
            # Split by "=<" to extract map name and definition
            parts = preprocess.split(s,"=<")
            assert len(parts) == 3, f"Invalid affine_map format: {s}"
            assert parts[1].strip() == "affine_map", f"Invalid affine_map format: {s}"
            map_name = parts[0].strip()
            # Store the entire line as the map definition
            affine_maps[map_name] = s
            continue
        # Parse assignment style operations
        if "func.func" in s:
            s = s.strip()[:-1]
            assert (not s.endswith("{")), f"Invalid MLIR format: {s}"
            main_parts = re.split(r"[()@]",re.split(r"[{}]",s)[0])
            assert len(main_parts) == 4, f"Invalid MLIR format: {s}"
            opname, _, params_str, _ = main_parts
            dialect, op = parse_dialect_operation(opname)
            params = {"name":[],"dtype":[],"dims":[]}
            for i in params_str.split(","):
                name, dtype = i.split(":")
                name = name.strip()
                dtype = dtype.strip()
                dtype, dims = parse_mlir_datatype_and_shape(dtype)
                params["name"].append(name)
                params["dtype"].append(dtype)
                params["dims"].append(dims)

            g.add_operation(name=f"block{g.num_dialect[Dialect.BLOCK][BlockOp.BLOCK]}", op_name="block", dialect=Dialect.BLOCK, op=BlockOp.BLOCK, dtype=DataType.NONE, dimension=[], line=line_num, input_data=[], output_data="")
            g.egraph.root_eclasses.append(g.name2id[f"block{g.num_dialect[Dialect.BLOCK][BlockOp.BLOCK]-1}"])
            for _name, _dtype, _dims in zip(params["name"], params["dtype"], params["dims"]):
                g.add_operation(name="source"+_name, op_name=_name, dialect=Dialect.SS, op=SSOp.SOURCE, dtype=datatype_map[_dtype], dimension=_dims, line=line_num, input_data=[], output_data=_name)
            continue

        # if (std::regex_match(line, std::regex(R"(^\s*\}\s*$)"))) {
        #     if (iss.peek() != '\n' && iss.peek() != EOF) {
        #         auto block= todo_blist.back();
        #         block->setPosend(line_num);
        #         todo_blist.pop_back();
        #         done_blist.push_back(block);
        #     }
        # }

        if _RE_BLOCK_END.match(s):
            if line_num != len(lines)-1:
                block = g.todo_blist.pop()
                g._G.nodes[block]["posend"] = line_num
                g.done_blist.append(block)
            continue
        
        if ".for" in s:
            m_for2 = _RE_FOR_FLEX.match(s)
            if m_for2:
                opname = m_for2.group(1)         # affine.for / scf.for
                assert opname in {"affine.for", "scf.for"}
                dialect, op = parse_dialect_operation(opname + "value")
                index = m_for2.group(2)
                if index not in arg_list:
                    arg_list[index] = (index + "_0", 0)
                else:
                    length = arg_list[index][1] + 1
                    arg_list[index] = (index + "_" + str(length), length)
                start_expr = (m_for2.group(3) or "0").strip()
                end_expr   = (m_for2.group(4) or "0").strip()
                step_expr  = (m_for2.group(5) or "1").strip()

                # Key step: normalize to prefix, then reuse _lower_prefix_into_graph directly
                start_pfx = to_prefix_for_expr(start_expr, affine_maps)
                end_pfx   = to_prefix_for_expr(end_expr,   affine_maps)
                step_pfx  = to_prefix_for_expr(step_expr,  affine_maps)

                def lower_prefix_get_data(pfx: str) -> str:
                    toks = tokenize_prefix(pfx)
                    toks = [arg_list[t][0] if t in arg_list else t for t in toks]
                    dn, pos = g._lower_prefix_into_graph(toks, 0, line_num, want_out=None)
                    assert pos == len(toks), "extra tokens after prefix lowering"
                    return dn

                start_dn = lower_prefix_get_data(start_pfx)
                end_dn   = lower_prefix_get_data(end_pfx)
                step_dn  = lower_prefix_get_data(step_pfx)

                if index not in g._G:
                    g.add_operation(name="sourcevariable"+index, op_name="variable"+index,
                                    dialect=Dialect.SS, op=SSOp.SOURCE, dtype=DataType.INDEX,
                                    dimension=[], line=line_num, input_data=[], output_data="variable"+index)

                g.add_operation(name="forvalue"+arg_list[index][0], op_name="forvalue",
                                dialect=dialect, op=op, dtype=DataType.INDEX, dimension=[], line=line_num,
                                input_data=[start_dn, end_dn, step_dn, "variable"+index], output_data=arg_list[index][0])
                g.add_operation(name="forcontrol"+arg_list[index][0], op_name="forcontrol",
                                dialect=dialect, op=parse_operation(dialect, "forcontrol"),
                                dtype=DataType.NONE, dimension=[], line=line_num,
                                input_data=[arg_list[index][0]], output_data="")
                block_output = g.add_operation(name=f"block{g.num_dialect[Dialect.BLOCK][BlockOp.BLOCK]}",
                                            op_name="block", dialect=Dialect.BLOCK, op=BlockOp.BLOCK,
                                            dtype=DataType.NONE, dimension=[], line=line_num,
                                            input_data=[], output_data="")
                g.update_edge_add_consumer(block_output, "forcontrol"+arg_list[index][0])
                continue
            m_for = _RE_FOR.match(s)
            if m_for:
                opname = m_for.group(1)
                assert (opname == "affine.for" or opname == "scf.for"), f"Invalid MLIR format: {s}"
                opname = opname+"value"
                dialect, op = parse_dialect_operation(opname)
                index = m_for.group(2)
                start = m_for.group(3)
                end = m_for.group(4)
                step = m_for.group(5) or "1"
                oprands = [start, end, step]
                oprands = [arg_list[i][0] if i in arg_list else i for i in oprands]
                for _oprand in oprands:
                    if _oprand not in g._G:
                        assert (canbeparsedas(_oprand,float)), f"Invalid MLIR format: {s}"
                        g.add_operation(name=
                        "source"+_oprand, op_name=_oprand, dialect=Dialect.SS, op=SSOp.SOURCE, dtype=DataType.CONSTANT, dimension=[], line=line_num, input_data=[], output_data=_oprand)
                if index not in g._G:
                    g.add_operation(name="sourcevariable"+index, op_name="variable"+index, dialect=Dialect.SS, op=SSOp.SOURCE, dtype=DataType.INDEX, dimension=[], line=line_num, input_data=[], output_data="variable"+index)
                g.add_operation(name="forvalue"+index, op_name="forvalue", dialect=dialect, op=op, dtype=DataType.INDEX, dimension=[], line=line_num, input_data=[start, end, step, "variable"+index], output_data=index)
                g.add_operation(name="forcontrol"+index, op_name="forcontrol", dialect=dialect, op=parse_operation(dialect, "forcontrol"), dtype=DataType.NONE, dimension=[], line=line_num, input_data=[index], output_data="")
                block_output = g.add_operation(name=f"block{g.num_dialect[Dialect.BLOCK][BlockOp.BLOCK]}", op_name="block", dialect=Dialect.BLOCK, op=BlockOp.BLOCK, dtype=DataType.NONE, dimension=[], line=line_num, input_data=[], output_data="")
                g.update_edge_add_consumer(block_output, "forcontrol"+index)
                continue

        m_asn = _RE_ASSIGN.match(s)
        if m_asn:
            # TODO: complete other special cases if needed; affine.apply handled below
            out_ssa = m_asn.group(1) or ""
            opname = m_asn.group(2).replace("_", "")
            oprand = [i.strip() for i in m_asn.group(3).replace("[", ",").replace("]", ",").split(",") if i!=""]
            oprand = [arg_list[i][0] if i in arg_list else i for i in oprand]
            dtype, dims = parse_mlir_datatype_and_shape(m_asn.group(4))
            dtype = dtype.replace(" to ", "")
            dtype = datatype_map[dtype]

            dialect, op = parse_dialect_operation(opname)

            index = g.num_dialect[dialect][op]
            op_name = f"{dialect.value}_{op.value}_{dtype.value}_{len(dims)}"

            # arith.constant case
            for _oprand in oprand:
                if _oprand not in g._G:
                    assert (canbeparsedas(_oprand,float) & ("constant" in op.value)), f"Invalid MLIR format: {s}"
                    g.add_operation(name=
                    "source"+_oprand, op_name=_oprand, dialect=Dialect.SS, op=SSOp.SOURCE, dtype=DataType.CONSTANT, dimension=[], line=line_num, input_data=[], output_data=_oprand)
            g.add_operation(name=op_name+f"_{index}", op_name=op_name, dialect=dialect, op=op, dtype=dtype, dimension=dims, line=line_num, input_data=oprand, output_data=out_ssa)
            continue

        m_apply = _RE_APPLY.match(s)
        if m_apply:
            out_ssa = m_apply.group(1)     # e.g. %0
            map_name = m_apply.group(2)    # e.g. #map0
            map_def  = affine_maps[map_name]
            input_t  = m_apply.group(3)    # e.g. #map0(%a, %b)[%c]

            # 1) Expand affine_map to a single-result infix expression (with d/s substituted)
            map_output = flatten_affine_map(map_def, input_t)

            # 2) Safety: ensure a single outer pair of parentheses for normalization
            infix_brace_pair = preprocess.find_brace_pairs(map_output, left="(", right=")")
            if ((0,0),(0,len(map_output)-1)) not in infix_brace_pair:
                map_output = f"({map_output})"

            # 3) Disallow commas (affine.apply yields a single value)
            assert ("," not in map_output), f"Invalid MLIR format: {s}"

            # 4) Convert to prefix
            prefix_output = infix_to_prefix(map_output)
            prefix_brace_pair = preprocess.find_brace_pairs(prefix_output, left="(", right=")")
            assert ((0,0),(0,len(prefix_output)-1)) in prefix_brace_pair, f"Invalid MLIR format: {s}"

            # 5) Lower the prefix expression into the HyperGraph
            toks = tokenize_prefix(prefix_output)
            toks = [arg_list[t][0] if t in arg_list else t for t in toks]

            _, new_pos = g._lower_prefix_into_graph(
                toks, 0, line_num, want_out=out_ssa   # force the root output to bind to current SSA
            )
            assert new_pos == len(toks), "extra tokens after prefix lowering"
            # res_name should equal out_ssa; if out_ssa already exists, add_operation will raise, consistent with SSA single-assignment
            continue

    return g


def main() -> None:
    parser = argparse.ArgumentParser(description="Parse MLIR to HyperGraph and print basic stats")
    parser.add_argument("-i", "--input", required=True)
    args = parser.parse_args()
    with open(args.input, "r") as f:
        mlir = f.read()
    mlir = preprocess.preprocess_mlir(mlir,"rename")
    # print(mlir)
    g = parse_mlir_to_graph(mlir)
    json_string = json.dumps(asdict(g.egraph), ensure_ascii=False)
    print(json_string)


if __name__ == "__main__":
    main()