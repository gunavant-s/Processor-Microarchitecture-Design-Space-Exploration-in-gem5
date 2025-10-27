# Design Space Exploration Report

This report tracks the design changes and performance improvements across three iterations, starting from a baseline (Iteration 0) and applying targeted microarchitectural enhancements.

## MIPS Rating Comparison

Performance is measured in MIPS (Millions of Instructions Per Second).
* **Individual MIPS:** `simInsts / (simSeconds * 1,000,000)`
* **Overall MIPS:** `Σ(simInsts) / ( Σ(simSeconds) * 1,000,000 )`

| Design | CCe MIPS | CRf MIPS | EM5 MIPS | MC MIPS | **Overall MIPS** | % Change |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Iteration 0** | 2011.15 | 2998.02 | 1191.79 | 2631.46 | **2404.29** | (Baseline) |
| **Iteration 1** | 2298.46 | 3167.72 | 1268.68 | 2631.46 | **2514.58** | **+4.59%** |
| **Iteration 2** | 2298.46 | 3167.72 | 1310.97 | 2631.46 | **2526.17** | **+0.46%** |

---
