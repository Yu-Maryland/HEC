# HEC: Equivalence Checking via Equality Saturation

[![Paper](https://img.shields.io/badge/Paper-ACM%20DL-blue)](https://dl.acm.org/doi/10.5555/3768039.3768108)

HEC is an MLIR-fronted framework that uses e-graphs to **prove** source-to-source transformations correct (control-flow and datapath). It normalizes MLIR, lowers it into an e-graph friendly form, and uses a customized `egg` backend with dynamic + static rewrites (tiling, unrolling, fusion, algebraic simplification, const folding) to certify equivalence. The ATC’25 paper (LaTeX sources in `atc_25_HEC/`) shows HEC scaling to 100K+ lines of PolyBenchC MLIR in ~40 minutes and uncovering real `mlir-opt` bugs (loop boundary checks and fusion RAW violations).

## ✨ What’s special
- 🧠 **Holistic MLIR-aware front end**: Preprocesses SSA, parses affine/loop constructs, and builds a typed hypergraph that unifies variable renaming, loop decomposition, and op tracking—covering both control-flow and datapath transformations.
- 🧩 **Hybrid transformation-aware rewrites**: Static datapath rules plus dynamic control-flow rules (tiling, unrolling, fusion, algebraic simplification, const folding) embedded in `egg`, adaptable to runtime-dependent patterns.
- 🔍 **Proof-oriented extraction**: Equality saturation explores the transformation space; minimal-cost extraction certifies equivalence and spots divergences.
- ✅ **Formal verification with Z3**: Dynamic loop transformations (unrolling) are formally verified using Z3 SMT solver to ensure arithmetic iteration-count identities hold before applying rewrites.
- 🧪 **Real-world validation & findings**: Scales to 100K+ lines of PolyBenchC MLIR in ~40 minutes; uncovered `mlir-opt` bugs (loop boundary checks and fusion read-after-write violations).

## 🔄 Static vs Dynamic Rewrite Rules

HEC employs two categories of rewrite rules to handle the diverse transformations in MLIR optimization:

### Static Rules (Pattern-Based)
These are traditional e-graph rewrite rules encoded as simple pattern-match-and-replace operations:
- **Algebraic simplification**: `x + 0 → x`, `x * 1 → x`, associativity, commutativity
- **Constant folding**: `2 + 3 → 5`
- **Datapath identities**: arithmetic and logical identities that hold universally

Static rules are always safe to apply—they're encoded directly in the e-graph rewrite system and proven correct by construction.

### Dynamic Rules (Runtime-Dependent)
These handle complex **control-flow transformations** that depend on runtime loop parameters and require semantic analysis:
- **Loop tiling**: Splits loops into blocked iterations with specific tile sizes
- **Loop unrolling**: Merges adjacent loop segments with different step sizes
- **Loop fusion**: Combines consecutive loops under data-dependency constraints

Dynamic rules use **custom Applier implementations** that:
1. Pattern-match on loop structure in the e-graph
2. Extract runtime parameters (bounds, step sizes)
3. **Verify arithmetic correctness via Z3** (for unrolling)
4. Construct the transformed loop only if verification passes

### Z3-Based Formal Verification

For **loop unrolling**, HEC uses the Z3 SMT solver to formally verify that merging two adjacent loops preserves iteration semantics. Specifically, when merging loops with parameters `(a1, b1, c1)` and `(a2, b2, c2)`:

```
Loop 1: for i in range(a1, b1, step=c1)
Loop 2: for i in range(a2, b2, step=c2)  // where b1 == a2
```

Before applying the merge, Z3 proves the **iteration-count identity**:
```
relu(⌈(k-a1)/c1⌉) · (c1/c2) + relu(⌈(b2-k)/c2⌉) = relu(⌈(b2-a1)/c2⌉)
```

Where `relu(x) = max(0, x)` and `k = b1 = a2` is the boundary point. This ensures the merged loop executes the exact same number of iterations. Z3 searches for counterexamples to the negation of this formula—**Unsat** means the transformation is provably correct, and only then does HEC apply the rewrite.

This SMT-backed verification lets HEC safely explore aggressive loop transformations while maintaining **soundness guarantees** that purely syntactic e-graph rewrites cannot provide.

## 📂 Repository layout
- `mlir/` — PolyBench-style MLIR kernels with many optimized variants.
- `mlir_parser.py` — MLIR → hypergraph → serialized e-graph (JSON per program line).
- `preprocess.py` — SSA renaming/normalization used by the parser.
- `checker/` — Rust driver that merges e-graphs, runs the rewrite set, and reports equivalence.
- `egg/` — Local fork of `egg` with added rewrites and static Z3 linkage (`static-link-z3`).

## 🛠️ Prerequisites
- Python 3.9+ (`networkx`, `ordered-set`, `numpy` via `requirements.txt`).
- Rust toolchain 1.89 (`rustup toolchain install 1.89`).
- Build tools for the bundled Z3 build: `cmake`, `gcc/clang`, system linker.

## ⚙️ Setup
```bash
cd HEC
pip install -r requirements.txt
cd checker
cargo build --release
```

## ▶️ Run an equivalence check (example)
From the repo root, pipe each program (baseline first) into the checker:
```bash
(
  python mlir_parser.py -i mlir/2mm/2mm.mlir
  python mlir_parser.py -i mlir/2mm/unroll_16_unroll_16_2mm.mlir
) | cargo run --release --manifest-path checker/Cargo.toml
```
What happens step by step:
1) `mlir_parser.py` normalizes the MLIR (SSA renaming), builds a hypergraph, then prints a serialized e-graph JSON (one line per program).
2) The Rust checker reads all lines, merges them into one e-graph, and runs the domain rewrites (tiling, unrolling, fusion, algebraic/const folding).
3) After equality saturation, it extracts the lowest-cost expression per root and compares every program against program 0.

What you’ll see in the log:
- Best extracted expression for each program.
- Equivalence summary: for each non-baseline program, “equivalent” if there is a shared e-class id (non-empty list), otherwise “NOT equivalent.”
- Runtime, iteration count, and e-graph size for situational awareness.

Compare more than two programs by adding more `mlir_parser.py -i …` lines; **program 0 is always the baseline** (the first line of input) and every other program is checked against it. If a path is wrong or a parse fails, the checker exits early with an error to keep results trustworthy.

## 🔧 Useful commands
- Normalize MLIR only: `python preprocess.py -i mlir/2mm/2mm.mlir -o /tmp/normalized.mlir --mode rename`
- Parser only (prints JSON): `python mlir_parser.py -i mlir/2mm/2mm.mlir`
- Adjust logging: `RUST_LOG=info cargo run --release --manifest-path checker/Cargo.toml`

## 🩺 Troubleshooting
- Edition errors → `rustup override set 1.89` in the repo.
- Z3 build issues → ensure `cmake` and a C/C++ compiler are installed; rebuild `cargo clean -p z3-sys && cargo build --release --manifest-path checker/Cargo.toml`.
- Large benchmarks → reduce rewrite set or pick smaller MLIR variants to keep node/iteration limits in check.

## 📖 Citation
If you use HEC, please cite:
```bibtex
@article{yin2025hec,
  title={HEC: Equivalence Verification Checking for Code Transformation via Equality Saturation},
  author={Yin, Jiaqi and Song, Zhan and Agostini, Nicolas Bohm and Tumeo, Antonino and Yu, Cunxi},
  journal={arXiv preprint arXiv:2506.02290},
  year={2025}
}
```
