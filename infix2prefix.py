# -*- coding: utf-8 -*-

# ====== benchmarks.py ======
import random
import time
import re
import math
from typing import List, Tuple, Union, Dict

# =======================
# Infix  ->  Prefix
# =======================

# Lexer: match keywords first, then %name, then identifiers/numbers/parens/single-char ops
# =======================
# Infix  ->  Prefix
# =======================

# Lexer: include comma; prefer keywords, then %name, then identifiers/numbers/parens/single-char ops
_INF_TOK = re.compile(r"""
    \s*
    (?: (floordiv|ceildiv|mod)           # 1: keyword (multi-char binary)
      | (%[A-Za-z0-9_]+)                 # 2: %ssa-name
      | ([A-Za-z_][A-Za-z0-9_]*)         # 3: identifier (incl. max/min)
      | (\d+)                            # 4: number
      | ([(),])                          # 5: paren/comma
      | ([-+*/%])                        # 6: single-char operator (incl. modulo %)
    )
""", re.X)


def _tokenize_infix(s: str) -> List[str]:
    """Tokenize an infix string into tokens."""
    out: List[str] = []
    i = 0
    n = len(s)
    while i < n:
        m = _INF_TOK.match(s, i)
        if not m:
            raise ValueError(f"Bad token near: {s[i:i+20]!r}")
        tok = next(g for g in m.groups() if g is not None)
        out.append(tok)
        i = m.end()

    # Insert implicit multiply IMUL, with higher precedence than explicit '*'
    def is_value_start(t: str) -> bool:
        # Start of a value: digit, %name, identifier, '('
        return t == '(' or t[:1].isdigit() or t[:1] == '%' or t[:1].isalpha()

    def is_value_end(t: str) -> bool:
        # End of a value: digit, %name, identifier, ')'
        return t == ')' or t[:1].isdigit() or t[:1] == '%' or t[:1].isalpha()

    with_imul: List[str] = []
    for j, tok in enumerate(out):
        if j > 0:
            prev = out[j - 1]

            def is_value_start(t: str) -> bool:
                return t == '(' or t[:1].isdigit() or t[:1] == '%' or t[:1].isalpha()

            def is_value_end(t: str) -> bool:
                return t == ')' or t[:1].isdigit() or t[:1] == '%' or t[:1].isalpha()

            # Consider implicit multiply only when value_end is followed by value_start
            if is_value_end(prev) and is_value_start(tok):
                # 0) Do not insert IMUL before function calls: min( / max(
                if tok == '(' and prev[:1].isalpha() and prev.lower() in {'max', 'min'}:
                    pass
                # 1) Parentheses adjacency: ")(" -> IMUL
                elif prev == ')' and tok == '(':
                    with_imul.append('IMUL')
                # 2) identifier/constant/")" directly followed by "("
                elif tok == '(' and prev not in {'(', '+', '-', '*', '/', '%', 'floordiv', 'ceildiv', 'mod', ','}:
                    with_imul.append('IMUL')
                # 3) ")" followed by identifier/constant/%name
                elif prev == ')' and tok not in {')', ',', '+', '-', '*', '/', '%', 'floordiv', 'ceildiv', 'mod'}:
                    with_imul.append('IMUL')
                # 4) identifier/constant/%name adjacent to identifier/constant/%name
                elif (tok not in {'+', '-', '*', '/', '%', 'floordiv', 'ceildiv', 'mod', ')', ','}
                      and prev not in {'(', '+', '-', '*', '/', '%', 'floordiv', 'ceildiv', 'mod', ','}):
                    with_imul.append('IMUL')

        with_imul.append(tok)

    return with_imul

    

# Pratt parser: give IMUL higher precedence so A * 4c parses as A * (4 ⊙ c)
PREC = {
    '+': 10, '-': 10,
    'IMUL': 60,                        # implicit multiply (stronger than '*')
    '*': 50, '/': 50, '%': 50,
    'mod': 50, 'floordiv': 50, 'ceildiv': 50,
}
RIGHT_ASSOC = set()                    # all left-associative

# AST: binary ('op', left, right); unary minus ('NEG', node); call ('CALL', name, [args]); leaf is str
Node = Union[Tuple[str, 'Node', 'Node'], Tuple[str, 'Node'], Tuple[str, str, List['Node']], str]

class _TS:
    def __init__(self, toks: List[str]):
        self.toks = toks
        self.i = 0
    def peek(self) -> str:
        return self.toks[self.i] if self.i < len(self.toks) else ''
    def next(self) -> str:
        t = self.peek()
        if t:
            self.i += 1
        return t


def _nud(ts: _TS) -> Node:
    t = ts.next()
    if t == '(':
        expr = _parse(ts, 0)
        if ts.next() != ')':
            raise ValueError("Expected ')'")
        return expr
    if t == '-':                       # Unary minus as a prefix operator
        rhs = _parse(ts, 100)
        return ('NEG', rhs)
    # Function calls: only recognize max/min( ... )
    if t.lower() in {'max', 'min'} and ts.peek() == '(':
        ts.next()  # consume '('
        args: List[Node] = []
        # Allow one or more arguments separated by commas
        if ts.peek() == ')':
            raise ValueError(f"{t}() expects at least 1 argument")
        args.append(_parse(ts, 0))
        while ts.peek() == ',':
            ts.next()
            args.append(_parse(ts, 0))
        if ts.next() != ')':
            raise ValueError("Expected ')' after function arguments")
        return ('CALL', t.lower(), args)
    # Otherwise: number / identifier / %name
    return t


def _led(ts: _TS, left: Node, op: str) -> Node:
    lbp = PREC[op]
    rbp = lbp + (0 if op in RIGHT_ASSOC else 1)  # left-associative
    right = _parse(ts, rbp)
    return (op, left, right)



def _parse(ts: _TS, min_bp: int) -> Node:
    left = _nud(ts)
    while True:
        op = ts.peek()
        if op not in PREC:
            break
        bp = PREC[op]
        if bp < min_bp:
            break
        ts.next()
        left = _led(ts, left, op)
    return left



def _to_prefix(n: Node) -> str:
    if isinstance(n, str):
        return n
    if isinstance(n, tuple) and n[0] == 'NEG':
        return f"(inv {_to_prefix(n[1])})"     # map unary minus to inv
    if isinstance(n, tuple) and n[0] == 'CALL':
        name, args = n[1], n[2]
        return f"({name} " + " ".join(_to_prefix(a) for a in args) + ")"
    op = n[0] if n[0] != 'IMUL' else '*'      # print IMUL as '*'
    return f"({op} {_to_prefix(n[1])} {_to_prefix(n[2])})"


def infix_to_prefix(s: str) -> str:
    """
    Convert infix to Lisp-style prefix.
    - Supports: +, -, *, /, %, mod, floordiv, ceildiv
    - Supports: unary minus (printed as inv)
    - Supports: implicit multiply with higher precedence than '*'
    - Supports: %SSA names (e.g., %0, %arg2)
    - Supports: variadic max()/min()
    """
    toks = _tokenize_infix(s)
    ts = _TS(toks)
    ast = _parse(ts, 0)
    if ts.peek():
        raise ValueError("Trailing tokens after parse")
    return _to_prefix(ast)


# =======================
# Prefix  Evaluator
# =======================

# Prefer %name first to avoid splitting %1 into '%' and '1'; include 'inv' keyword
_PFX_RE = re.compile(
    r"\s*(\(|\)|floordiv|ceildiv|mod|inv|min|max|%[A-Za-z0-9_]+|[A-Za-z_][A-Za-z0-9_]*|\d+|[-+*/%])"
)

def tokenize_prefix(s: str) -> List[str]:
    out: List[str] = []
    i = 0
    while i < len(s):
        m = _PFX_RE.match(s, i)
        if not m:
            raise ValueError(f"bad prefix near {s[i:i+20]!r}")
        out.append(m.group(1))
        i = m.end()
    return [t for t in out if t.strip()]

def eval_prefix(pfx: str, env: Dict[str, int]) -> int:
    """
    Simple prefix evaluator used for property tests:
      - Atoms: decimal integers, identifiers, %name (from env; default 0 if missing)
      - Supports unary (inv x) / (- x); binary (+ a b) etc.
      - Supports variadic (max a b ...), (min a b ...)
    """
    toks = tokenize_prefix(pfx)
    i = 0

    def peek() -> str:
        return toks[i] if i < len(toks) else ''

    def nxt() -> str:
        nonlocal i
        t = peek()
        if t:
            i += 1
        return t

    def atom(tok: str) -> int:
        if tok.isdigit():
            return int(tok)
        return env.get(tok, 0)

    def apply2(op: str, a: int, b: int) -> int:
        if op == '+': return a + b
        if op == '-': return a - b
        if op == '*': return a * b
        if op == '/': return int(a / b)      # C-style truncation toward 0
        if op == '%': return a % b
        if op == 'mod': return a % b
        if op == 'floordiv': return a // b
        if op == 'ceildiv': return math.ceil(a / b)
        raise ValueError(f"unknown binary op {op}")

    def parse() -> int:
        t = nxt()
        if t == '(':
            op = nxt()
            # Collect variadic args until ')'
            args: List[int] = []
            while True:
                if peek() == ')':
                    nxt()  # consume ')'
                    break
                args.append(parse())
            # Reduce
            if op in {'inv', '-'} and len(args) == 1:
                return -args[0]
            if op in {'max', 'min'}:
                if len(args) == 0:
                    raise ValueError(f"{op} needs at least 1 arg")
                return max(args) if op == 'max' else min(args)
            # Binary op
            if len(args) != 2:
                raise ValueError(f"{op} expects 2 args, got {len(args)}")
            return apply2(op, args[0], args[1])
        else:
            return atom(t)

    val = parse()
    if i != len(toks):
        raise ValueError("extra tokens in prefix evaluation")
    return val


# ---- Convert infix into Python-evaluable expression (for cross-check), with max/min support ----

def _py_ident(name: str) -> str:
    # Turn %0, %arg2, etc. into valid Python identifiers
    if name.startswith('%'):
        return '__p' + name[1:]
    return name

def _norm_num(tok: str) -> str:
    # Normalize numbers (strip leading zeros), e.g. "08" -> "8"
    return str(int(tok))

def _ast_from_infix_for_py(s: str):
    ts = _TS(_tokenize_infix(s))
    ast = _parse(ts, 0)
    if ts.peek():
        raise ValueError("Trailing tokens after parse (to-python)")
    return ast

def _ast_to_python_expr(n, name_map: Dict[str, str]) -> str:
    if isinstance(n, str):
        if n.isdigit():
            return _norm_num(n)
        py = _py_ident(n)  # identifier (including %name)
        name_map.setdefault(n, py)
        return py

    if isinstance(n, tuple) and n[0] == 'NEG':
        return f"-( {_ast_to_python_expr(n[1], name_map)} )"

    if isinstance(n, tuple) and n[0] == 'CALL':
        fn = n[1]
        args = ", ".join(_ast_to_python_expr(a, name_map) for a in n[2])
        if fn == 'max':
            return f"pmax({args})"
        if fn == 'min':
            return f"pmin({args})"
        raise ValueError(f"unknown call {fn}")

    op, a, b = n[0], n[1], n[2]
    LA = _ast_to_python_expr(a, name_map)
    RB = _ast_to_python_expr(b, name_map)

    if op == 'IMUL' or op == '*':
        return f"({LA} * {RB})"
    if op == '+':
        return f"({LA} + {RB})"
    if op == '-':
        return f"({LA} - {RB})"
    if op == '/':
        return f"tdiv({LA}, {RB})"          # trunc toward 0
    if op == '%':
        return f"({LA} % {RB})"
    if op == 'mod':
        return f"({LA} % {RB})"
    if op == 'floordiv':
        return f"({LA} // {RB})"
    if op == 'ceildiv':
        return f"ceil_div({LA}, {RB})"
    raise ValueError(f"unknown op in AST -> py: {op}")

def infix_to_python_expr(s: str) -> tuple[str, Dict[str, str]]:
    ast = _ast_from_infix_for_py(s)
    name_map: Dict[str, str] = {}
    py = _ast_to_python_expr(ast, name_map)
    return py, name_map

# Python-side helpers matching eval_prefix semantics
def tdiv(a: int, b: int) -> int:
    return int(a / b)  # trunc toward 0

def ceil_div(a: int, b: int) -> int:
    return math.ceil(a / b)

def pmax(*args: int) -> int:
    return max(args)

def pmin(*args: int) -> int:
    return min(args)

# ---------- 1) Golden test cases ----------
GOLDENS: List[Tuple[str, str]] = [
    # Examples
    ("((s0 floordiv 41) * 41)", "(* (floordiv s0 41) 41)"),
    ("%0 + %1 * s0", "(+ %0 (* %1 s0))"),
    ("-(aaa + 2b) * 4c", "(* (inv (+ aaa (* 2 b))) (* 4 c))"),

    # Extra coverage: ceildiv / mod / parentheses & whitespace
    ("(%5 ceildiv 3) + (x mod 5)", "(+ (ceildiv %5 3) (mod x 5))"),
    ("((a+b) * (c - d))", "(* (+ a b) (- c d))"),
    ("a * b + c * d", "(+ (* a b) (* c d))"),
    ("-(x floordiv 2) + y", "(+ (inv (floordiv x 2)) y)"),
    ("(m mod 7) floordiv 2", "(floordiv (mod m 7) 2)"),
    ("(3 + 4) * 5", "(* (+ 3 4) 5)"),
    ("2(3+z)", "(* 2 (+ 3 z))"),
    ("(a+b)(c+d)", "(* (+ a b) (+ c d))"),
    ("w/(x+y)", "(/ w (+ x y))"),
]

def run_golden_tests() -> None:
    print("== Golden tests ==")
    ok = 0
    for i, (inp, expected) in enumerate(GOLDENS, 1):
        got = infix_to_prefix(inp)
        if got != expected:
            print(f"[FAIL] #{i}\n  in : {inp}\n  exp: {expected}\n  got: {got}\n")
        else:
            ok += 1
    print(f"Passed {ok}/{len(GOLDENS)} golden tests.\n")


# ---------- 2) Randomized property tests ----------
OPS = ['+', '-', '*', '/', 'floordiv', 'ceildiv', '%', 'mod']
IDENTS = ['a', 'b', 'c', 'x', 'y', 'z', 's0', 'aaa', '%0', '%1', '%arg2']

class RNode: ...
class RLit(RNode):
    def __init__(self, val: str): self.val = val
class RUn(RNode):
    def __init__(self, op: str, e: RNode): self.op, self.e = op, e
class RBin(RNode):
    def __init__(self, op: str, l: RNode, r: RNode): self.op, self.l, self.r = op, l, r

def gen_expr(depth: int) -> RNode:
    # Leaf: number or identifier
    if depth == 0 or (depth > 0 and random.random() < 0.35):
        if random.random() < 0.6:
            return RLit(str(random.randint(0, 9)))
        else:
            return RLit(random.choice(IDENTS))
    # Unary or binary
    if random.random() < 0.2:
        return RUn('-', gen_expr(depth - 1))
    op = random.choice(OPS)
    return RBin(op, gen_expr(depth - 1), gen_expr(depth - 1))

def infix_of(node: RNode, allow_implicit_mul=True) -> str:
    if isinstance(node, RLit):
        return node.val
    if isinstance(node, RUn):
        # -(expr)
        inner = infix_of(node.e, allow_implicit_mul)
        return f"-({inner})"
    if isinstance(node, RBin):
        L = infix_of(node.l, allow_implicit_mul)
        R = infix_of(node.r, allow_implicit_mul)
        if node.op == '*':
            if allow_implicit_mul and _can_implicit(L, R):
                return f"{L}{R}"     # generate implicit multiply to exercise this path
        return f"({L} {node.op} {R})"
    raise AssertionError("unknown node")

def _can_implicit(L: str, R: str) -> bool:
    # Allow implicit * between value/( ) and value/(
    def is_value(s: str) -> bool:
        return re.fullmatch(r"(%[A-Za-z0-9_]+|[A-Za-z_][A-Za-z0-9_]*|\d+|\(.+\))", s) is not None
    # Avoid cases like (-x)y; require L/R to be values or parenthesized groups
    return is_value(L) and is_value(R)


def run_property_tests(rounds=200, max_depth=4) -> None:
    print("== Property tests (random) ==")
    fails = 0
    for _ in range(rounds):
        ast = gen_expr(random.randint(1, max_depth))
        infix = infix_of(ast, allow_implicit_mul=True)

        # Build env (consistent with parser expectations)
        env: Dict[str, int] = {}
        for name in set(re.findall(r"%[A-Za-z0-9_]+|[A-Za-z_][A-Za-z0-9_]*", infix)):
            if name in {'floordiv','ceildiv','mod'}:
                continue
            env[name] = random.randint(0, 9)
        for k in list(env.keys()):
            if env[k] == 0:
                env[k] = 1  # avoid division by zero

        try:
            # 1) Our prefix path
            pfx = infix_to_prefix(infix)
            val1 = eval_prefix(pfx, env)

            # 2) Python eval path (convert infix into Python expression)
            py_expr, name_map = infix_to_python_expr(infix)
            py_env = {name_map.get(k, k): v for k, v in env.items()}
            # Put helpers into globals and variables into locals
            val2 = eval(py_expr, {'tdiv': tdiv, 'ceil_div': ceil_div}, py_env)

            # 3) Numeric consistency assertion
            if val1 != val2:
                print("[MISMATCH]", infix, "=>", pfx,
                      "\n  py:", py_expr,
                      "\n  env:", env,
                      f"\n  ours={val1}  py={val2}\n")
                fails += 1

        except ZeroDivisionError:
            # Rare unavoidable cases like constant zero divisor: skip
            continue
        except Exception as e:
            print("[EVAL ERR]", infix, "=>", pfx if 'pfx' in locals() else "(no pfx)",
                  "env=", env, "err=", e)
            fails += 1
            continue

    if fails == 0:
        print(f"All {rounds} random tests passed.\n")
    else:
        print(f"{fails} / {rounds} random tests failed.\n")


# ---------- 3) Simple performance test ----------
def run_perf(n=2) -> None:
    print("== Perf ==")
    samples = [
        "((s0 floordiv 41) * 41)",
        "%0 + %1 * s0",
        "-(aaa + 2b) * 4c",
        "((a+b) * (c - d)) + ((w+x) * (y+z))",
        "((%5 ceildiv (3 + a)) * (b + c mod 7))",
    ]
    # Prepare a larger sample pool
    pool = []
    for _ in range(n):
        pool.append(random.choice(samples))

    t0 = time.time()
    for s in pool:
        infix_to_prefix(s)
    t1 = time.time()
    dt = t1 - t0
    print(f"{n} conversions in {dt:.3f}s  ->  {n/dt:,.0f} expr/s\n")


if __name__ == "__main__":
    print(infix_to_prefix("((s0 floordiv 41) * 41)"))
    # -> (* (floordiv s0 41) 41)

    print(infix_to_prefix("-(aaa + 2b) * 4c"))
    # -> (* (- (+ aaa (* 2 b))) (* 4 c))

    print(infix_to_prefix("%0 + %1 * s0"))
    # -> (+ %0 (* %1 s0))

    # eval example
    p = infix_to_prefix("((s0 floordiv 41) * 41)")
    print(eval_prefix(p, {"s0": 123}))  # simple test
    print(infix_to_prefix("((s0 floordiv 41) * 41)"))

    print(infix_to_prefix("%0 + %1 * s0"))

    print(infix_to_prefix("-(a + 3) * 2"))

    print(infix_to_prefix("-(aaa + b) * c"))

    print(infix_to_prefix("a mod 5 + b"))

    infix_to_prefix("a+b+c+d")

    print(infix_to_prefix("((_3b floordiv 41) * 41)"))

    print(infix_to_prefix("-(aaa + 2b) * 4c"))

    run_golden_tests()
    run_property_tests(rounds=300, max_depth=5)
    run_perf(30000)

    print(infix_to_prefix("5"))

    print(infix_to_prefix("5+6"))

    print(infix_to_prefix("5+6*7"))

    print(infix_to_prefix("5+6*7/8"))

    print(infix_to_prefix("5+6*7/8%9"))
    infix_to_prefix("min(a,b,c)")
    print(infix_to_prefix("max(-(aaa + 2b) * 4c,a mod 5 + b,((s0 floordiv 41) * 41))"))
    print(infix_to_prefix("(max(-(aaa + 2b) * 4c,a mod 5 + b,((s0 floordiv 41) * 41)) floordiv _3b) * ((_3b floordiv 41) * 41)"))
    print(infix_to_prefix("min(a,b,c)"))

    print(infix_to_prefix("a/b/c"))

    infix = "a/b/c"



    env: Dict[str, int] = {}
    for name in set(re.findall(r"%[A-Za-z0-9_]+|[A-Za-z_][A-Za-z0-9_]*", infix)):
        if name in {'floordiv','ceildiv','mod'}:
            continue
        env[name] = random.randint(0, 9)
    for k in list(env.keys()):
        if env[k] == 0:
            env[k] = 1  # avoid division by zero
    # 1) Our prefix path
    pfx = infix_to_prefix(infix)
    val1 = eval_prefix(pfx, env)
    # 2) Python eval path (convert infix to Python expression)
    py_expr, name_map = infix_to_python_expr(infix)
    py_env = {name_map.get(k, k): v for k, v in env.items()}
    # Put helpers in globals and variables in locals
    val2 = eval(py_expr, {'tdiv': tdiv, 'ceil_div': ceil_div}, py_env)
    print(val1, val2)
