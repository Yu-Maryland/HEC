"""
clear;python preprocess.py -i tile_2_2mm.mlir -o output_cpp.txt --mode both --impl cpp;python preprocess.py -i tile_2_2mm.mlir -o output_python.txt --mode both;diff output_python.txt output_cpp.txt

Preprocessing utilities (Python reimplementation) matching the original C++ logic in
final_verification/verification_2mm/src/utilities.cpp for:

- rename_variables: stabilize SSA names within scopes and normalize constants/loop vars
- apply_placeholder: inject Placeholder4<var> for loop induction variables within loop bodies

The behavior is kept consistent with the original to avoid breaking downstream tools.

Usage (CLI):
  python preprocess.py -i input.mlir -o output.mlir --mode both   # rename + placeholder
  python preprocess.py -i input.mlir -o output.mlir --mode rename # only rename
  python preprocess.py -i input.mlir -o output.mlir --mode placeholder # only placeholder
"""

from __future__ import annotations

from numpy import floor
import argparse
from utils import *
import re






def apply_replacements(lines, replacements, length):
   """
   Apply variable replacements to source lines.
   
   Args:
       lines: List[str] - lines of code
       replacements: Dict[str, Dict[int, Tuple[str, Tuple[Tuple[int, int], Tuple[int, int]]]]] - replacement map
       length: int - total length of the original source (for fractional ordering)
   
   Returns:
       List[str] - updated lines
   """
   for rep in sorted(replacements):
       ranges = []
       inner_map = replacements[rep]
       for replacement in sorted(inner_map.keys()):
           replacement_data = inner_map[replacement]
           start = float(replacement_data[1][0][0]) + float(replacement_data[1][0][1]) / length
           end = float(replacement_data[1][1][0]) + float(replacement_data[1][1][1]) / length
           ranges.append((start, end))
       
       assert have_no_intersection(ranges)
       
       for line_num_pair in sorted(inner_map.keys()):
           new_var = inner_map[line_num_pair][0]
           matchs = inner_map[line_num_pair][1]
           
           # First replacement operation
           lines[matchs[0][0]] = (lines[matchs[0][0]][:matchs[0][1] + 1] + 
                                 replace_whole_word(lines[matchs[0][0]][matchs[0][1] + 1:], rep, new_var))
           
           # Second replacement operation  
           lines[matchs[1][0]] = (replace_whole_word(lines[matchs[1][0]][:matchs[1][1] + 1], rep, new_var) + 
                                 lines[matchs[1][0]][matchs[1][1] + 1:])
           
           # Replacement inside loop body lines
           for i in range(matchs[0][0] + 1, matchs[1][0]):
               lines[i] = replace_whole_word(lines[i], rep, new_var)
   
   return lines


def rename_variables(mlir_code: str) -> str:
    """
    Rename variables in MLIR code to stabilize SSA-style names.
    
    Args:
        mlir_code: input MLIR code
        
    Returns:
        The MLIR code with normalized names
    """
    lines = mlir_code.splitlines()
    variable_counts = 0
    constant_counts = 0
    arg_count = 0
    replacements = {}

    # Find brace pairs
    pair = find_brace_pairs(mlir_code)
    digit_pair = []
    for p in pair:
        digit_pair.append((
            p[0][0] + p[0][1] / len(mlir_code),
            p[1][0] + p[1][1] / len(mlir_code)
        ))

    depth_at_line = [0] * len(lines)
    in_func = False
    depth = 0

    for i, line in enumerate(lines):
        line = line.rstrip()
        depth_at_line[i] = depth if in_func else 0

        if not in_func:
            if "func.func" in line:
                in_func = True
                assert line.endswith("{"), f"Invalid MLIR format: {line}"
                continue
            else:
                continue
        

        for index, ch in enumerate(line):
            if ch == '{':
                    depth += 1
                    assert index == len(line)-1
                    continue
            elif ch == '}':
                if depth > 0:
                    depth -= 1
                    assert index == len(line)-1
                else:
                    in_func = False

    
    # First pass: identify variables to rename
    for line_num in range(len(lines)):
        line = lines[line_num]
        if line.lstrip().startswith("#"):
            continue
        if "=" in line and "%" in line:
            if ("for" not in line and "func.func" not in line and "constant" not in line):
                # Regular assignment variable rename
                var_name = line[:line.find('=')]
                var_name = re.sub(r'\s+', '', var_name)  # Remove all whitespace
                
                if var_name != f"%{variable_counts}":
                    new_var_name = f"%_{variable_counts}"
                    matchs = find_match(find_brace_pairs(mlir_code), (line_num, line.find("%")), len(mlir_code))
                    if var_name not in replacements:
                        replacements[var_name] = {}
                    replacements[var_name][line_num] = (new_var_name, matchs)
                    variable_counts += 1
                else:
                    variable_counts += 1

            if "func.func" in line:
                # Count function args within func.func definitions
                line = line.strip()[:-1]
                assert (not line.endswith("{")), f"Invalid MLIR format: {line}"
                main_parts = re.split(r"[()@]",re.split(r"[{}]",line)[0])
                assert len(main_parts) == 4, f"Invalid MLIR format: {line}"
                params_str = main_parts[2]

                smallest = -1
                matchs = None
                for i in range(len(digit_pair)):
                    if floor(digit_pair[i][0]) == line_num and digit_pair[i][0] > smallest:
                        smallest = digit_pair[i][0]
                        matchs = pair[i]
                assert matchs[0] != -1 and matchs[1] != -1, f"Invalid MLIR format: {line}"
                

                for i in params_str.split(","):
                    name= i.split(":")[0]
                    name = name.strip()
                    new_var_name = f"%arg_{arg_count}"
                    if name != f"%arg{arg_count}":
                        if name not in replacements:
                            replacements[name] = {}
                        replacements[name][line_num] = (new_var_name, matchs)
                        lines[line_num] = replace_whole_word(lines[line_num], name, new_var_name)

                    arg_count += 1
                    
            elif "constant" in line:
                # Constant renaming
                var_name = line[:line.find('=')]
                var_name = re.sub(r'\s+', '', var_name)  # Remove all whitespace
                
                if var_name != f"%cst_{constant_counts}":
                    new_var_name = f"%cst__{constant_counts}"
                    matchs = find_match(find_brace_pairs(mlir_code), (line_num, line.find("%")), len(mlir_code))
                    if var_name not in replacements:
                        replacements[var_name] = {}
                    replacements[var_name][line_num] = (new_var_name, matchs)
                    constant_counts += 1
                else:
                    constant_counts += 1
            elif "for" in line:
                split_result = split(line, " ")
                var_name = split_result[1]
                var_name = re.sub(r'\s+', '', var_name)  # Remove all whitespace
                
                if var_name != f"%forarg_{depth_at_line[line_num]}":
                    new_var_name = f"%forarg_{depth_at_line[line_num]}"
                    index = -1
                    smallest = float('inf')
                    
                    for i in range(len(digit_pair)):
                        if digit_pair[i][0] > line_num and digit_pair[i][0] < smallest:
                            index = i
                            smallest = digit_pair[i][0]
                    
                    assert index != -1, f"Invalid MLIR format: {line}"                    
                    matchs = pair[index]
                    if var_name not in replacements:
                        replacements[var_name] = {}
                    replacements[var_name][line_num] = (new_var_name, matchs)
                    lines[line_num] = replace_whole_word(lines[line_num], var_name, new_var_name)


    # Second pass: replace all occurrences
    lines = apply_replacements(lines, replacements, len(mlir_code))

    # Final pass: remove temporary prefixes
    for i in range(len(lines)):
        line = lines[i]
        
        # Replace "%_" with "%"
        pos = 0
        while True:
            pos = line.find("%_", pos)
            if pos == -1:
                break
            line = line[:pos] + "%" + line[pos + 2:]
            pos += 1
        
        # Replace "%cst__" with "%cst"
        pos = 0
        while True:
            pos = line.find("%cst__", pos)
            if pos == -1:
                break
            line = line[:pos] + "%cst" + line[pos + 6:]
            pos += 1
        
        # Replace "%arg_" with "%arg"
        pos = 0
        while True:
            pos = line.find("%arg_", pos)
            if pos == -1:
                break
            line = line[:pos] + "%arg" + line[pos + 5:]
            pos += 1

        pos = 0
        while True:
            pos = line.find("%forarg_", pos)
            if pos == -1:
                break
            line = line[:pos] + "%forarg" + line[pos + 8:]
            pos += 1
            
        lines[i] = line

    return '\n'.join(lines) + '\n'

# def rename_variables(mlir_code: str) -> str:
#     """
#     Rename variables in MLIR code to stabilize SSA-style names.
    
#     Args:
#         mlir_code: input MLIR code
        
#     Returns:
#         The MLIR code with normalized names
#     """
#     lines = mlir_code.splitlines()
#     variable_counts = 0
#     constant_counts = 0
#     arg_count = 0
#     replacements = {}

#     # Find brace pairs
#     pair = find_brace_pairs(mlir_code)
#     digit_pair = []
#     for p in pair:
#         digit_pair.append((
#             p[0][0] + p[0][1] / len(mlir_code),
#             p[1][0] + p[1][1] / len(mlir_code)
#         ))
    
#     # First pass: identify variables to rename
#     for line_num in range(len(lines)):
#         line = lines[line_num]
#         if line.lstrip().startswith("#"):
#             continue
#         if "=" in line and "%" in line:
#             if ("for" not in line and "func.func" not in line and "constant" not in line):
#                 # Regular assignment variable rename
#                 var_name = line[:line.find('=')]
#                 var_name = re.sub(r'\s+', '', var_name)  # Remove all whitespace
                
#                 if var_name != f"%{variable_counts}":
#                     new_var_name = f"%_{variable_counts}"
#                     matchs = find_match(find_brace_pairs(mlir_code), (line_num, line.find("%")), len(mlir_code))
#                     if var_name not in replacements:
#                         replacements[var_name] = {}
#                     replacements[var_name][line_num] = (new_var_name, matchs)
#                     variable_counts += 1
#                 else:
#                     variable_counts += 1
                    
#             elif "constant" in line:
#                 # Constant renaming
#                 var_name = line[:line.find('=')]
#                 var_name = re.sub(r'\s+', '', var_name)  # Remove all whitespace
                
#                 if var_name != f"%cst_{constant_counts}":
#                     new_var_name = f"%cst__{constant_counts}"
#                     matchs = find_match(find_brace_pairs(mlir_code), (line_num, line.find("%")), len(mlir_code))
#                     if var_name not in replacements:
#                         replacements[var_name] = {}
#                     replacements[var_name][line_num] = (new_var_name, matchs)
#                     constant_counts += 1
#                 else:
#                     constant_counts += 1
                    
#             elif "func.func" in line:
#                 # Count function args within func.func definitions
#                 line = line.strip()[:-1]
#                 assert (not line.endswith("{")), f"Invalid MLIR format: {line}"
#                 main_parts = re.split(r"[()@]",re.split(r"[{}]",line)[0])
#                 assert len(main_parts) == 4, f"Invalid MLIR format: {line}"
#                 params_str = main_parts[2]

#                 smallest = -1
#                 matchs = None
#                 for i in range(len(digit_pair)):
#                     if floor(digit_pair[i][0]) == line_num and digit_pair[i][0] > smallest:
#                         smallest = digit_pair[i][0]
#                         matchs = pair[i]
#                 assert matchs[0] != -1 and matchs[1] != -1, f"Invalid MLIR format: {line}"
                

#                 for i in params_str.split(","):
#                     name= i.split(":")[0]
#                     name = name.strip()
#                     new_var_name = f"%arg_{arg_count}"
#                     if name != f"%arg{arg_count}":
#                         if name not in replacements:
#                             replacements[name] = {}
#                         replacements[name][line_num] = (new_var_name, matchs)
#                         lines[line_num] = replace_whole_word(lines[line_num], name, new_var_name)

#                     arg_count += 1
                
#             elif "for" in line:
#                 split_result = split(line, " ")
#                 var_name = split_result[1]
#                 var_name = re.sub(r'\s+', '', var_name)  # Remove all whitespace
                
#                 if var_name != f"%arg{arg_count}":
#                     new_var_name = f"%arg_{arg_count}"
#                     index = -1
#                     smallest = float('inf')
                    
#                     for i in range(len(digit_pair)):
#                         if digit_pair[i][0] > line_num and digit_pair[i][0] < smallest:
#                             index = i
#                             smallest = digit_pair[i][0]
                    
#                     assert index != -1, f"Invalid MLIR format: {line}"                    
#                     matchs = pair[index]
#                     if var_name not in replacements:
#                         replacements[var_name] = {}
#                     replacements[var_name][line_num] = (new_var_name, matchs)
#                     lines[line_num] = replace_whole_word(lines[line_num], var_name, new_var_name)
#                 arg_count += 1

#     # Second pass: replace all occurrences
#     lines = apply_replacements(lines, replacements, len(mlir_code))

#     # Final pass: remove temporary prefixes
#     for i in range(len(lines)):
#         line = lines[i]
        
#         # Replace "%_" with "%"
#         pos = 0
#         while True:
#             pos = line.find("%_", pos)
#             if pos == -1:
#                 break
#             line = line[:pos] + "%" + line[pos + 2:]
#             pos += 1
        
#         # Replace "%cst__" with "%cst"
#         pos = 0
#         while True:
#             pos = line.find("%cst__", pos)
#             if pos == -1:
#                 break
#             line = line[:pos] + "%cst" + line[pos + 6:]
#             pos += 1
        
#         # Replace "%arg_" with "%arg"
#         pos = 0
#         while True:
#             pos = line.find("%arg_", pos)
#             if pos == -1:
#                 break
#             line = line[:pos] + "%arg" + line[pos + 5:]
#             pos += 1
            
#         lines[i] = line

#     return '\n'.join(lines) + '\n'



def apply_placeholder(mlir_code: str) -> str:
    """
    Add a placeholder prefix to for-loop induction variables in MLIR code.
    
    Args:
        mlir_code: input MLIR code
        
    Returns:
        MLIR code with placeholders inserted
    """
    lines = mlir_code.splitlines()
    replacements = {}

    # Find brace pairs
    pair = find_brace_pairs(mlir_code)
    digit_pair = []
    for p in pair:
        digit_pair.append((
            p[0][0] + p[0][1] / len(mlir_code),
            p[1][0] + p[1][1] / len(mlir_code)
        ))

    for line_num in range(len(lines)):
        line = lines[line_num]
        if "for" in line:
            split_result = split(line, " ")
            var_name = split_result[1]  # Direct access (mirrors C++ behavior)
            var_name = re.sub(r'\s+', '', var_name)  # Remove all whitespace
            new_var_name = "Placeholder4" + var_name
            
            index = -1
            smallest = float('inf')
            for i in range(len(digit_pair)):
                if digit_pair[i][0] > line_num and digit_pair[i][0] < smallest:
                    index = i
                    smallest = digit_pair[i][0]
            
            if index != -1:
                matchs = pair[index]
                if var_name not in replacements:
                    replacements[var_name] = {}
                replacements[var_name][line_num] = (new_var_name, matchs)

    # Apply replacements
    lines = apply_replacements(lines, replacements, len(mlir_code))

    # Reassemble
    return '\n'.join(lines) + '\n'




def preprocess_mlir(mlir_code: str, mode: str = 'both') -> str:
    """Run rename_variables and/or apply_placeholder in the requested order.

    mode: 'both' | 'rename' | 'placeholder'
    """
    if mode == 'rename':
        return rename_variables(mlir_code)
    # if mode == 'placeholder':
    #     return apply_placeholder(mlir_code)
    # both: rename first, then placeholder (matches original flow in mlir2egg.cpp)
    renamed = rename_variables(mlir_code)
    # return apply_placeholder(renamed)
    return renamed

def main() -> None:
    parser = argparse.ArgumentParser(description='MLIR preprocessing reimplementation (rename + placeholder). If -o is omitted, prints to stdout.')
    parser.add_argument('-i', '--input', required=True, help='Input MLIR file')
    parser.add_argument('-o', '--output', required=False, help='Output MLIR file (optional, prints to stdout if omitted)')
    parser.add_argument('--mode', choices=['both', 'rename', 'placeholder'], default='both')
    parser.add_argument('--impl', choices=['py', 'cpp'], default='py', help='Use pure Python or C++ compatibility helper')
    args = parser.parse_args()

    if args.impl == 'cpp':
        # Call the compiled C++ helper to ensure byte-identical output with original
        import subprocess, shlex, tempfile, os
        if args.output:
            cmd = f"./code_baseline/cpp_preprocess/tmp_cpp_preprocess {args.mode} {shlex.quote(args.input)} {shlex.quote(args.output)}"
            res = subprocess.run(cmd, shell=True)
            if res.returncode != 0:
                raise SystemExit(res.returncode)
        else:
            with tempfile.NamedTemporaryFile(delete=False, suffix='.mlir') as tmp:
                tmp_path = tmp.name
            try:
                cmd = f"./code_baseline/cpp_preprocess/tmp_cpp_preprocess {args.mode} {shlex.quote(args.input)} {shlex.quote(tmp_path)}"
                res = subprocess.run(cmd, shell=True)
                if res.returncode != 0:
                    raise SystemExit(res.returncode)
                with open(tmp_path, 'r') as f:
                    print(f.read(), end='')
            finally:
                try:
                    os.unlink(tmp_path)
                except Exception:
                    pass
    else:
        with open(args.input, 'r') as f:
            code = f.read()
        out_code = preprocess_mlir(code, mode=args.mode)
        out_text = out_code  # keep exact formatting; do not force trailing newline
        if args.output:
            with open(args.output, 'w') as f:
                f.write(out_text)
        else:
            print(out_text, end='')


if __name__ == '__main__':
    main()