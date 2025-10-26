This project uses the gem5 simulator to explore the design space of a RISC-V processor, focusing on improving performance (MIPS rating) while adhering to area and transistor count budgets.

## 1. Environment Setup

This project uses Docker to provide a consistent environment with all necessary dependencies.

**Steps:**

1.  **Install Docker Desktop:** Ensure Docker Desktop is installed and running on your host machine (Windows or Ubuntu).
2.  **Create Local Directory:** Create a directory on your host machine to store project files (e.g., `~/gem5` on Ubuntu or `C:\Users\YourUser\gem5` on Windows). This directory will be mounted into the container.
3.  **Start Persistent Container:** Open a terminal (PowerShell/CMD on Windows, Terminal on Ubuntu) and run the following command, replacing `<your_local_gem5_path>` with the actual path from step 2:
    ```bash
    # Example for Ubuntu:
    docker run -d --name gem5_container -v ~/gem5:/gem5 -w /gem5/gem5 ghcr.io/gem5/ubuntu-22.04_all-dependencies:latest sleep infinity

    # Example for Windows (using PowerShell):
    # docker run -d --name gem5_container -v C:/Users/YourUser/gem5:/gem5 -w /gem5/gem5 ghcr.io/gem5/ubuntu-22.04_all-dependencies:latest sleep infinity
    ```
4.  **(Optional) Connect VS Code:**
    * Install the "Remote - Containers" extension in VS Code.
    * Use the Command Palette (`Ctrl+Shift+P`) and select `Remote-Containers: Attach to Running Container...`.
    * Choose `gem5_container`.
    * Once attached, use `File > Open Folder...` and enter `/gem5`.

5.  **Access Container Terminal:**
    * Use the integrated terminal in VS Code (if attached).
    * Or, open a host terminal and run: `docker exec -it gem5_container bash`
    * Navigate to the gem5 source directory: `cd /gem5/gem5`
  
---

## Understanding BTB Parameters

The Branch Target Buffer (BTB) helps predict the target address of taken branches. You can adjust its size and structure using these parameters:

### `BTBEntries`

* **What it is:** Defines the **total number of entries** (slots) in the BTB. Each entry stores information like the predicted target address for a specific branch instruction.
* **Impact:**
    * ➕ **More entries:** Increases the chance of a **BTB hit** (finding the branch info), improving target prediction for taken branches and reducing pipeline stalls, especially for code with many branches.
    * ➖ **More entries:** Increases hardware cost (**area** and **power**).

### `BTBTagSize`

* **What it is:** Specifies the **number of bits** used for the **tag** in each BTB entry. The tag helps uniquely identify which branch an entry belongs to, distinguishing it from other branches that might map to the same BTB index.
* **Impact:**
    * ➕ A **larger tag:** Reduces **aliasing** (incorrect matches where different branches map to the same entry), leading to more accurate target predictions on a hit.
    * ➖ A **larger tag:** Requires more storage bits per entry, increasing overall BTB **area** and **power**. It might also slightly increase **latency**.

---
