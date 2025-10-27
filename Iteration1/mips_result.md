Design: Iteration1 Raw Stats
==========================

Benchmark: CCe
simInsts                                        80446                       # Number of instructions simulated (Count)
simSeconds                                   0.000035                       # Number of seconds simulated (Second)


Benchmark: CRf
simInsts                                       167889                       # Number of instructions simulated (Count)
simSeconds                                   0.000053                       # Number of seconds simulated (Second)

Benchmark: EM5
simInsts                                        39329                       # Number of instructions simulated (Count)
simSeconds                                   0.000031                       # Number of seconds simulated (Second)

Benchmark: MC
simInsts                                       260515                       # Number of instructions simulated (Count)
simSeconds                                   0.000099                       # Number of seconds simulated (Second)

# Iteration 1: Performance Results

## MIPS per Benchmark

MIPS (Millions of Instructions Per Second) is calculated using the formula:
`MIPS = simInsts / (simSeconds * 1,000,000)`

---

### Benchmark: CCe
- **simInsts:** 80,446
- **simSeconds:** 0.000035
80,446 / (0.000035 * 1,000,000) = 80,446 / 35 = 2298.46 MIPS

**Result: 2298.46 MIPS**

---

### Benchmark: CRf
- **simInsts:** 167,889
- **simSeconds:** 0.000053

167,889 / (0.000053 * 1,000,000) = 167,889 / 53 = 3167.72 MIPS

**Result: 3167.72 MIPS**

---

### Benchmark: EM5
- **simInsts:** 39,329
- **simSeconds:** 0.000031

39,329 / (0.000031 * 1,000,000) = 39,329 / 31 = 1268.68 MIPS

**Result: 1268.68 MIPS**

---

### Benchmark: MC
- **simInsts:** 260,515
- **simSeconds:** 0.000099

260,515 / (0.000099 * 1,000,000) = 260,515 / 99 = 2631.46 MIPS

**Result: 2631.46 MIPS**

---

## Overall Performance

(2298.46 + 3167.72 + 1268.68 + 2631.46) / 4 = 9366.32 / 4 = 2341.58 MIPS

**Average MIPS: 2341.58 MIPS**
