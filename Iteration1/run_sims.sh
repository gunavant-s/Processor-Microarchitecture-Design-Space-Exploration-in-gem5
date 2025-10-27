#!/bin/bash

# --- Design Identification ---
# CHANGE THIS FOR EACH ITERATION (e.g., "Iteration1", "Iteration2", "BestDesign")
DESIGN_NAME="Iteration1" # <-- EXAMPLE: Start with your first iteration name

# --- Allowed Microarchitectural Parameters ---
# Use '-' to skip adding a parameter (gem5 will use its default)

# 1. Machine Width
CPU_TYPE="RiscvO3CPU" # Required, sets the base CPU model (Out-of-Order)
FETCH_WIDTH=8         # Corresponds to fetchWidth
DECODE_WIDTH=8        # Corresponds to decodeWidth
ISSUE_WIDTH=8        # Corresponds to issueWidth

# 2. Dynamic Branch Predictor size & 3. Branch Target Buffer
# These are often linked. Use '-' to let gem5 use defaults.
BP_LOCAL_PRED_SIZE=1024 # Parameter: system.cpu[:].branchPred.localPredictorSize
BP_BTB_ENTRIES=512    # Parameter: system.cpu[:].branchPred.BTBEntries
BP_BTB_TAG_SIZE=9    # Related BTB parameter (often adjusted with BTBEntries)

# 4. Load/Store Queue Size
LQ_ENTRIES=32         # Parameter: system.cpu[:].LQEntries
SQ_ENTRIES=32         # Parameter: system.cpu[:].SQEntries

# 5. Number of Integer ALUs and Multiplier/Divider Units
# Corresponds to FUList indices. Use '-' to let gem5 use defaults.
# Index 0: IntALU
FU_INT_ALU_COUNT=5
# Index 1: IntMultDiv (Often combined, includes multiplier and divider)
FU_INT_MULT_DIV_COUNT=2

# 6. Number of Floating-point ALUs and Multiplier/Divider Units
# Corresponds to FUList indices. Use '-' to let gem5 use defaults.
# Index 2: FP_ALU
FU_FP_ALU_COUNT=1
# Index 3: FP_MultDiv (Often combined, includes multiplier and divider)
FU_FP_MULT_DIV_COUNT=1

# 7. Caches (Size, Associativity)
# Use '-' to skip adding a parameter (gem5 uses defaults if --caches enabled)
ENABLE_CACHES=true    # Flag: --caches (enables L1 caches)
ENABLE_L2CACHE=true   # Flag: --l2cache (adds an L2 cache)

L1I_SIZE="16kB"       # Param: --l1i_size
L1I_ASSOC=2           # Param: --l1i_assoc
L1D_SIZE="256kB"      # Param: --l1d_size
L1D_ASSOC=32          # Param: --l1d_assoc
L2_SIZE="1MB"         # Param: --l2_size
L2_ASSOC=8            # Param: --l2_assoc
# CACHELINE_SIZE=64   # Often fixed, but can be changed with --cacheline_size if allowed by estimator

# 8. Number of Memory Ports
# Corresponds to FUList index 8. Use '-' to let gem5 use defaults.
# Index 8: RdWrPort (Represents Load/Store Units accessing memory)
FU_MEM_RDWR_COUNT=2

# --- Benchmarks to Run ---
# Assumes benchmark binaries (CCe, CRf, EM5, MC) are in the current directory
BENCHMARKS=(CCe CRf EM5 MC)

# --- Script Logic ---

# Create base directory for this design's results
mkdir -p "$DESIGN_NAME"
echo "Starting simulations for design: $DESIGN_NAME"
echo "------------------------------------"

# Define the stats output file path and clear/create it
STATS_OUT_FILE="${DESIGN_NAME}/mips_avg.txt"
echo "Design: $DESIGN_NAME Raw Stats" > "$STATS_OUT_FILE"
echo "==========================" >> "$STATS_OUT_FILE"

# Loop through benchmarks
for BENCH in "${BENCHMARKS[@]}"; do
    echo "Running benchmark: $BENCH ..."

    # Define output directory for this specific run
    OUTDIR="${DESIGN_NAME}/${BENCH}_out"
    STATS_IN_FILE="${OUTDIR}/stats.txt"

    # --- Construct gem5 command ---
    CMD="build/RISCV/gem5.opt -d \"$OUTDIR\" ./configs/deprecated/example/se.py"

    # Add CPU type (Required)
    CMD+=" --cpu-type=$CPU_TYPE"

    # Add core width parameters (Conditional)
    [[ "$FETCH_WIDTH" != "-" ]] && CMD+=" -P 'system.cpu[:].fetchWidth=$FETCH_WIDTH'"
    [[ "$DECODE_WIDTH" != "-" ]] && CMD+=" -P 'system.cpu[:].decodeWidth=$DECODE_WIDTH'"
    [[ "$ISSUE_WIDTH" != "-" ]] && CMD+=" -P 'system.cpu[:].issueWidth=$ISSUE_WIDTH'"

    # Add Cache options (Conditional)
    if [ "$ENABLE_CACHES" = true ]; then
        CMD+=" --caches"
        [[ "$L1I_SIZE" != "-" ]] && CMD+=" --l1i_size=$L1I_SIZE"
        [[ "$L1I_ASSOC" != "-" ]] && CMD+=" --l1i_assoc=$L1I_ASSOC"
        [[ "$L1D_SIZE" != "-" ]] && CMD+=" --l1d_size=$L1D_SIZE"
        [[ "$L1D_ASSOC" != "-" ]] && CMD+=" --l1d_assoc=$L1D_ASSOC"
        if [ "$ENABLE_L2CACHE" = true ]; then
            CMD+=" --l2cache"
            [[ "$L2_SIZE" != "-" ]] && CMD+=" --l2_size=$L2_SIZE"
            [[ "$L2_ASSOC" != "-" ]] && CMD+=" --l2_assoc=$L2_ASSOC"
        fi
        # [[ "$CACHELINE_SIZE" != "-" ]] && CMD+=" --cacheline_size=$CACHELINE_SIZE" # Uncomment if needed/allowed
    fi

    # Add Branch Predictor options (Conditional)
    [[ "$BP_LOCAL_PRED_SIZE" != "-" ]] && CMD+=" -P 'system.cpu[:].branchPred.localPredictorSize=$BP_LOCAL_PRED_SIZE'"
    [[ "$BP_BTB_ENTRIES" != "-" ]] && CMD+=" -P 'system.cpu[:].branchPred.BTBEntries=$BP_BTB_ENTRIES'"
    [[ "$BP_BTB_TAG_SIZE" != "-" ]] && CMD+=" -P 'system.cpu[:].branchPred.BTBTagSize=$BP_BTB_TAG_SIZE'"

    # Add FU counts (Conditional)
    [[ "$FU_INT_ALU_COUNT" != "-" ]] && CMD+=" -P 'system.cpu[:].fuPool.FUList[0].count=$FU_INT_ALU_COUNT'"
    [[ "$FU_INT_MULT_DIV_COUNT" != "-" ]] && CMD+=" -P 'system.cpu[:].fuPool.FUList[1].count=$FU_INT_MULT_DIV_COUNT'"
    [[ "$FU_FP_ALU_COUNT" != "-" ]] && CMD+=" -P 'system.cpu[:].fuPool.FUList[2].count=$FU_FP_ALU_COUNT'"
    [[ "$FU_FP_MULT_DIV_COUNT" != "-" ]] && CMD+=" -P 'system.cpu[:].fuPool.FUList[3].count=$FU_FP_MULT_DIV_COUNT'"
    [[ "$FU_MEM_RDWR_COUNT" != "-" ]] && CMD+=" -P 'system.cpu[:].fuPool.FUList[8].count=$FU_MEM_RDWR_COUNT'"

    # Add LSQ entries (Conditional)
    [[ "$LQ_ENTRIES" != "-" ]] && CMD+=" -P 'system.cpu[:].LQEntries=$LQ_ENTRIES'"
    [[ "$SQ_ENTRIES" != "-" ]] && CMD+=" -P 'system.cpu[:].SQEntries=$SQ_ENTRIES'"

    # Add benchmark executable (Required)
    CMD+=" -c ./$BENCH"

    # --- Execute the command ---
    # echo "Command: $CMD" # Optional: Uncomment to print the command for debugging
    eval $CMD

    # --- Extract Stats and Append to File ---
    if [ $? -eq 0 ] && [ -f "$STATS_IN_FILE" ]; then
        echo "" >> "$STATS_OUT_FILE"
        echo "Benchmark: $BENCH" >> "$STATS_OUT_FILE"
        grep '^simInsts ' "$STATS_IN_FILE" >> "$STATS_OUT_FILE"
        grep '^simSeconds ' "$STATS_IN_FILE" >> "$STATS_OUT_FILE"
        echo "Finished $BENCH. Stats extracted. Results are in $OUTDIR"
    else
        echo "ERROR: gem5 simulation failed for $BENCH or $STATS_IN_FILE not found!"
        echo "" >> "$STATS_OUT_FILE"
        echo "Benchmark: $BENCH" >> "$STATS_OUT_FILE"
        echo "  Error: Simulation failed or stats file missing" >> "$STATS_OUT_FILE"
    fi
    echo "------------------------------------"

done

echo "All simulations for design $DESIGN_NAME complete."
echo "Raw stats written to $STATS_OUT_FILE."
echo "Full output directories are inside the '$DESIGN_NAME' folder."
