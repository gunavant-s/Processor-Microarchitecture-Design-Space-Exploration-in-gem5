# Iteration 2: Performance Results

## MIPS per Benchmark

MIPS (Millions of Instructions Per Second) is calculated using the formula:
`MIPS = simInsts / (simSeconds * 1,000,000)`

---

### Benchmark: CCe
- **simInsts:** 80,446
- **simSeconds:** 0.000035
- **Calculation:** `80,446 / 35 = 2298.46 MIPS`
- **Result: 2298.46 MIPS**

---

### Benchmark: CRf
- **simInsts:** 167,889
- **simSeconds:** 0.000053
- **Calculation:** `167,889 / 53 = 3167.72 MIPS`
- **Result: 3167.72 MIPS**

---

### Benchmark: EM5
- **simInsts:** 39,329
- **simSeconds:** 0.000030
- **Calculation:** `39,329 / 30 = 1310.97 MIPS`
- **Result: 1310.97 MIPS**

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
`0.000035 + 0.000053 + 0.000030 + 0.000099 = 0.000217`

**3. Final Calculation:**
`548,179 / (0.000217 * 1,000,000) = 548,179 / 217 = 2526.17 MIPS`

**Overall Performance: 2526.17 MIPS**
