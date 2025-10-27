# Iteration 0: Performance Results

## MIPS per Benchmark

MIPS (Millions of Instructions Per Second) is calculated using the formula:
`MIPS = simInsts / (simSeconds * 1,000,000)`

---

### Benchmark: CCe
- **simInsts:** 80,446
- **simSeconds:** 0.000040
- **Calculation:** `80,446 / 40 = 2011.15 MIPS`
- **Result: 2011.15 MIPS**

---

### Benchmark: CRf
- **simInsts:** 167,889
- **simSeconds:** 0.000056
- **Calculation:** `167,889 / 56 = 2998.02 MIPS`
- **Result: 2998.02 MIPS**

---

### Benchmark: EM5
- **simInsts:** 39,329
- **simSeconds:** 0.000033
- **Calculation:** `39,329 / 33 = 1191.79 MIPS`
- **Result: 1191.79 MIPS**

---

### Benchmark: MC
- **simInsts:** 260,515
- **simSeconds:** 0.000099
- **Calculation:** `260,515 / 99 = 2631.46 MIPS`
- **Result: 2631.46 MIPS**

---

## Overall Performance (MIPS)

Overall performance is calculated by dividing the *sum of all instructions* by the *sum of all execution time*, as per the project requirements.

**Formula:**
`Overall MIPS = Σ(simInsts) / ( Σ(simSeconds) * 1,000,000 )`

**1. Sum Total Instructions:**
`80,446 + 167,889 + 39,329 + 260,515 = 548,179`

**2. Sum Total Time:**
`0.000040 + 0.000056 + 0.000033 + 0.000099 = 0.000228`

**3. Final Calculation:**
`548,179 / (0.000228 * 1,000,000) = 548,179 / 228 = 2404.29 MIPS`

**Overall Performance: 2404.29 MIPS**
