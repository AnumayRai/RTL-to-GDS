# 4-bit Array Multiplier: RTL to GDSII

## Team Members

- Anumay Rai — Roll Number: 2025122013
- Ashlin K Sunil — Roll Number: 2024102025

## Project Description

Implementation and verification of a 4-bit unsigned array multiplier using Verilog and the SKY130 130 nm process.

The project covers RTL design, functional verification, logic synthesis, static timing analysis, and physical design to generate a final GDSII layout.

## Part A: RTL Design and Verification

### Source Files

- `rtl/full_adder.v`
- `rtl/mult_array.v`
- `tb/tb_mult.v`

### Compilation

```bash
iverilog -g2012 -o sim tb/tb_mult.v rtl/full_adder.v rtl/mult_array.v
```

### Run Simulation

```bash
vvp sim
```

### Verification Result

```text
PASS: 256 vectors checked, 0 errors
```

The testbench exhaustively checks all 256 combinations of the two 4-bit inputs.

### Fault-Injection Verification

A deliberately faulty full-adder implementation was tested separately. The testbench detected 95 errors across 256 vectors.

The correct implementation was restored and subsequently passed all 256 test vectors.

## Part B: Logic Synthesis with Yosys

### Objective

The multiplier RTL was synthesized and mapped to the SKY130 `sky130_fd_sc_hd` standard-cell library using Yosys.

### Synthesis Script

The synthesis script is located at `synth/synth.tcl`.

It reads the RTL source files, synthesizes the design, maps flip-flops and combinational logic to SKY130 standard cells, removes unused logic, generates statistics, and writes the mapped netlist.

### Command Used

```bash
yosys -c synth/synth.tcl
```

### Generated Files

- `synth/synth.tcl`: Yosys synthesis script.
- `synth/mult_array_netlist.v`: Mapped gate-level netlist.
- `synth/mult_array_stat.rpt`: Cell statistics and area report.

### Synthesis Results

| Metric | Result |
|---|---:|
| Total standard cells | 65 |
| Number of flip-flops | 16 |
| Estimated total cell area | 751.9712 µm² |
| Flip-flop area | 400.384 µm² |
| Flip-flop area as a percentage of total | 53.24% |

The 16 flip-flops comprise four registers for input `a`, four for input `b`, and eight for the registered output `p`.

The reported cell area is the synthesis estimate before physical design and routing.

### Gate-Level Simulation

The synthesized netlist was compiled using Icarus Verilog and the SKY130 standard-cell simulation models.

The following commands were run from the project root inside the configured Nix environment.

```bash
iverilog -g2012 -s tb_mult -o sim_synth \
    -I"$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog" \
    tb/tb_mult.v \
    synth/mult_array_netlist.v \
    "$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v" \
    "$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
```

Run the compiled simulation:

```bash
vvp sim_synth
```

### Gate-Level Verification Result

```text
PASS: 256 vectors checked, 0 errors
```

All 256 input combinations passed with zero errors, confirming that the synthesized netlist preserved the tested multiplier behaviour.

### Part B Status

Logic synthesis, standard-cell mapping, generation of the netlist and statistics report, and gate-level simulation are complete.

## Part C: Static Timing Analysis

### Objective

Static Timing Analysis (STA) was performed using OpenSTA on the synthesized gate-level netlist (`synth/mult_array_netlist.v`) under the typical corner (`sky130_fd_sc_hd__tt_025C_1v80.lib`).

### Script and Commands

The timing script is located at `sta/sta.tcl`.

Command to run STA:

```bash
sta sta/sta.tcl
```

### Generated Files

- `sta/sta.tcl`: Timing constraint and analysis script.
- `sta/mult_array_timing.rpt`: Critical path timing report.

### Part C Results

| Metric | Value |
| :--- | :--- |
| Worst slack at $T = 10\text{ ns}$ | 7.324 ns |
| $T_{\text{min}}$ | **2.68 ns** |
| $F_{\text{max}}$ | **373.13 MHz** |
| Slack at $T = T_{\text{min}}$ ($T = 2.68\text{ ns}$) | +0.004 ns (MET) |
| Critical path start point | `_102_` (rising edge-triggered flip-flop `sky130_fd_sc_hd__dfrtp_1`) |
| Critical path end point | `_096_` (rising edge-triggered flip-flop `sky130_fd_sc_hd__dfrtp_1`) |
| Number of cells on the critical path | 8 combinational cells (10 total including launch/capture FFs) |
| Latency | $2 \times T_{\text{min}} = 5.36\text{ ns}$ |
| Throughput | 373.13 million results per second |

Cells along critical path (in order):
`_102_` (dfrtp_1) $\to$ `_042_` (and4_1) $\to$ `_048_` (nor3_1) $\to$ `_050_` (o21ai_0) $\to$ `_061_` (maj3_1) $\to$ `_072_` (xnor2_1) $\to$ `_082_` (maj3_1) $\to$ `_087_` (maj3_1) $\to$ `_089_` (xnor3_1) $\to$ `_096_` (dfrtp_1).

## Part D: Physical Design and GDSII Generation

### Objective

Physical design was performed using LibreLane, integrating OpenROAD, Magic, KLayout, and Netgen. The flow includes floorplanning, placement, clock tree synthesis (CTS), routing, parasitic extraction, and signoff verification.

### Configuration

Configuration file: `pnr/config.json`

| Parameter | Value |
|---|---|
| Design name | `mult_array` |
| Clock port | `clk` |
| Final clock period | **7.5 ns** |
| Floorplan sizing | `absolute` |
| Die area | `[0, 0, 150, 150]` µm |
| Die area | 22,500 µm² |

The final configuration uses a 7.5 ns clock period. Earlier clock-period runs were used to investigate timing closure.

### Final Physical-Design Results

The final implementation was verified using LibreLane at a 7.5 ns clock period. A second run with the same configuration was completed to check reproducibility.

| Metric | Final result |
|---|---:|
| Clock period | 7.5 ns |
| Worst setup slack | **+0.456391 ns** |
| Total negative setup slack (TNS) | 0 |
| Setup violations | 0 |
| Routing DRC errors | 0 |
| LVS errors | 0 |
| LVS property failures | 0 |

The repeated 7.5 ns run passed the setup timing, routing DRC, and LVS checks. The saved signoff metrics are in `pnr/metrics.json`.

### Clock-Period Verification

The following runs were completed to investigate timing closure and verify the final configuration.

| Run tag | Clock period | Worst setup slack (ns) | Setup violations | Routing DRC errors | LVS errors |
|---|---:|---:|---:|---:|---:|
| `RUN_2026-10-24_20-38-54` | 3.5 ns | -2.093688 | 15 | See run metrics | See run metrics |
| `RUN_2026-10-25_01-53-19` | 4.0 ns | -1.593688 | 15 | See run metrics | See run metrics |
| `RUN_2026-10-25_02-04-14` | 4.5 ns | -1.093721 | 12 | See run metrics | See run metrics |
| `RUN_2026-10-25_02-40-47` | 5.0 ns | -0.595666 | 9 | See run metrics | See run metrics |
| `RUN_2026-10-25_02-45-27` | 5.5 ns | -0.106871 | 5 | See run metrics | See run metrics |
| `RUN_2026-10-25_02-28-42` | 6.0 ns | -0.040062 | 3 | See run metrics | See run metrics |
| `RUN_2026-10-25_02-50-24` | 6.5 ns | -0.155348 | 6 | See run metrics | See run metrics |
| `RUN_2026-10-25_04-17-52` | 7.0 ns | -0.043609 | 2 | 0 | 0 |
| `RUN_2026-10-25_04-22-50` | 7.5 ns | +0.456391 | 0 | 0 | 0 |
| `VERIFY_7P5_REPEAT` | 7.5 ns | +0.456391 | 0 | 0 | 0 |
| `VERIFY_8P0` | 8.0 ns | +0.956391 | 0 | 0 | 0 |
| `VERIFY_8P5` | 8.5 ns | +1.456391 | 0 | 0 | 0 |

The final 7.5 ns configuration passed the required setup timing, routing DRC, and LVS checks. The 8.0 ns and 8.5 ns runs also passed. The earlier runs demonstrate the timing-closure investigation. The results above distinguish the recorded timing failures from the final passing implementation.

### Part D Deliverables

- `pnr/config.json`: Physical-design configuration.
- `pnr/metrics.json`: Signoff metrics from the repeated 7.5 ns run.
- `pnr/mult_array.gds`: GDSII layout copied from the repeated 7.5 ns run.
- `report/mult_array_layout_whole_die.png`: Complete die layout screenshot.
- `report/mult_array_layout_zoomed.png`: Zoomed-in layout screenshot.
- `report/Part_D_Report.md`: Detailed physical-design analysis and clock-period sweep.
