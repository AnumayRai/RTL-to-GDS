# 4-bit Array Multiplier: RTL to GDSII

## Team Members

- Anumay Rai — Roll Number: 2025122013
- Ashlin K Sunil — Roll Number: 2024102025

## Project Description

This project implements a 4-bit unsigned structural array multiplier using Verilog and the SKY130 130 nm process.

The project covers RTL design, exhaustive functional verification, logic synthesis, gate-level simulation, static timing analysis, physical design, and GDSII layout generation.

## Part A: RTL Design and Verification

### Source Files

- `rtl/full_adder.v`: Full-adder module.
- `rtl/mult_array.v`: Structural 4-bit unsigned array multiplier.
- `tb/tb_mult.v`: Testbench for functional verification.

### Compilation and Simulation

Run from the project root:

```bash
iverilog -g2012 -o sim tb/tb_mult.v rtl/full_adder.v rtl/mult_array.v
vvp sim
gtkwave mult.vcd
```

### Verification Results

```text
PASS: 256 vectors checked, 0 errors
```

The testbench exhaustively checks all 256 combinations of the two 4-bit inputs.

The multiplier uses 12 directly instantiated full adders. The input operands are registered, and the 8-bit product is registered. The design uses an active-low asynchronous reset, `rst_n`.

### Fault-Injection Verification

A deliberately faulty full-adder implementation was tested separately. In `rtl/full_adder.v`, the sum equation was temporarily changed from `a ^ b ^ cin` to `a ^ b`, and the testbench was recompiled and run:

```bash
iverilog -g2012 -o sim_faulty tb/tb_mult.v rtl/full_adder.v rtl/mult_array.v
vvp sim_faulty
```

Result:

```text
FAIL: 256 vectors checked, 95 errors
```

The testbench detected 95 errors across 256 vectors.

The correct implementation was restored and subsequently passed all 256 test vectors.

### Worked Example

The selected operands are:

$$
A=8=1000_2,\qquad B=7=0111_2
$$

Their product is:

$$
P=A\times B=8\times7=56
$$

In 8-bit binary:

$$
P=56=00111000_2
$$

The hand-worked solution (using Anumay Rai's roll number 2025122013: last digit 3, so A = 3 + 5 = 8) is stored in:

- `report/8-7Multiply.pdf`

The waveform evidence for this example is stored in:

- `report/multiplier_waveform_8x7_cursor1.png`
- `report/multiplier_waveform_8x7_cursor2.png`

### Block Diagram

The block diagram showing the 16 AND gates, 12 full adders and the input/output registers is stored in:

- `report/Structural 4-Bit Unsigned Array Multiplier Model.drawio.svg`

The testbench applies inputs at a falling clock edge and checks the output after two rising clock edges. The first rising edge registers the inputs, and the next rising edge registers the corresponding product.

## Part B: Logic Synthesis with Yosys

### Objective

The multiplier RTL was synthesized and mapped to the SKY130 `sky130_fd_sc_hd` standard-cell library using Yosys.

### Synthesis Script

The synthesis script is located at `synth/synth.tcl`.

It reads the RTL, synthesizes the design, maps the logic to standard cells, generates statistics, and writes the mapped gate-level netlist.

### Command Used

```bash
yosys -c synth/synth.tcl
```

### Generated Files

- `synth/synth.tcl`: Synthesis script.
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

Run the following commands from the project root inside the configured Nix environment:

```bash
iverilog -g2012 -s tb_mult -o sim_synth \
    -I"$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog" \
    tb/tb_mult.v \
    synth/mult_array_netlist.v \
    "$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v" \
    "$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"

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

Static Timing Analysis (STA) was performed using OpenSTA on the synthesized gate-level netlist, `synth/mult_array_netlist.v`, under the typical corner using the `sky130_fd_sc_hd__tt_025C_1v80.lib` timing library.

### Script and Commands

The timing script is located at `sta/sta.tcl`.

Run the analysis from the project root. The Liberty file is selected through `LIB`:

```bash
export LIB="$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"

# Run 1: T = 10 ns (set T 10 in sta/sta.tcl)
sed -i 's/^set T 2.68/set T 10/' sta/sta.tcl
sta -exit sta/sta.tcl | tee sta/sta_10ns.log
cp sta/mult_array_timing.rpt sta/mult_array_timing_10ns.rpt

# Run 2: T = Tmin rounded to 0.01 ns = 2.68 ns (final setting of sta/sta.tcl)
sed -i 's/^set T 10/set T 2.68/' sta/sta.tcl
sta -exit sta/sta.tcl | tee sta/sta_2p68ns.log
cp sta/mult_array_timing.rpt sta/mult_array_timing_2p68ns.rpt
```

Console output: `worst slack max 7.32` at 10 ns and `worst slack max 0.00` at 2.68 ns.

The script reads the timing library and mapped netlist, defines the clock and I/O delays, reports worst slack, and generates the critical-path timing report.

### Timing Results

At a clock period of 10 ns, the measured worst slack was 7.324 ns.

The estimated minimum clock period is:

$$
T_{\min}=T-\text{WNS}
$$

$$
T_{\min}=10-7.324=\boxed{2.676\text{ ns}}
$$

The corresponding maximum frequency is:

$$
F_{\max}=\frac{1000}{T_{\min}}
$$

$$
F_{\max}=\frac{1000}{2.676}
=\boxed{373.69\text{ MHz}}
$$

The timing script was also run at a clock period of 2.68 ns. The reported critical-path slack was +0.004 ns, indicating that the path met timing under the stated constraints at that rounded period.

### Part C Results

| Metric | Value |
|---|---:|
| Worst slack at $T=10\text{ ns}$ | 7.324 ns |
| Calculated minimum period, $T_{\min}$ | 2.676 ns |
| Calculated maximum frequency, $F_{\max}$ | 373.69 MHz |
| Critical-path slack at $T=2.68\text{ ns}$ | +0.004 ns (MET) |
| Critical-path start point | `_102_` |
| Critical-path end point | `_096_` |
| Combinational cells on the critical path | 8 |
| Total cells including launch and capture flip-flops | 10 |
| Two-cycle latency at $T_{\min}$ | 5.352 ns |
| Throughput at $F_{\max}$ | 373.69 million results per second |

The latency value is calculated as two clock periods at the estimated minimum period:

$$
L=2T_{\min}=2(2.676)=\boxed{5.352\text{ ns}}
$$

The throughput is the reciprocal of the minimum clock period expressed in seconds. It represents the clock-cycle result rate, not a claim that the design has one-cycle latency.

### Critical-Path Cell Sequence

The critical path starts at flip-flop `_102_` and ends at flip-flop `_096_`.

The cells along the path, in order, are:

1. `_102_` — `dfrtp_1` launch flip-flop
2. `_042_` — `and4_1`
3. `_048_` — `nor3_1`
4. `_050_` — `o21ai_0`
5. `_061_` — `maj3_1`
6. `_072_` — `xnor2_1`
7. `_082_` — `maj3_1`
8. `_087_` — `maj3_1`
9. `_089_` — `xnor3_1`
10. `_096_` — `dfrtp_1` capture flip-flop

There are eight combinational cells between the two flip-flops. The mapped path includes logic associated with the multiplier's partial-product and carry-computation network.

### Timing Report Files

- `sta/sta.tcl`: STA script, configured for a 2.68 ns clock period.
- `sta/mult_array_timing.rpt`: Critical-path report generated by the STA script.
- `sta/mult_array_timing_10ns.rpt`: Report for the 10 ns analysis.
- `sta/mult_array_timing_2p68ns.rpt`: Report for the 2.68 ns analysis.

### Part C Status

The calculated minimum period and maximum frequency are recorded above. The 2.68 ns run reported +0.004 ns slack for the critical path.

## Part D: Physical Design and GDSII Generation

### Objective

Physical design was performed using LibreLane and its integrated EDA tools. The flow includes floorplanning, placement, clock-tree synthesis, routing, parasitic extraction, timing analysis, and physical verification.

### Configuration

The final physical-design configuration is stored in `pnr/config.json`.

| Parameter | Value |
|---|---|
| Design name | `mult_array` |
| Clock port | `clk` |
| Final clock period | 7.5 ns |
| Floorplan sizing | `absolute` |
| Die area | `[0, 0, 150, 150]` µm |
| Total die area | 22,500 µm² |

Earlier runs investigated timing closure at different clock periods. The final deliverables correspond to the repeated 7.5 ns implementation.

### Clock-Period Selection

The starting period follows the assignment rule, $1.2\times T_{\min}$ from Part C rounded up to the next 0.5 ns:

$$
1.2\times 2.676=3.211\text{ ns}\;\rightarrow\;3.5\text{ ns}
$$

When a run failed setup timing, `CLOCK_PERIOD` was increased by 0.5 ns and the flow was run again (3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5 ns). The first passing period was 7.5 ns.

LibreLane analyses setup timing at nine process/voltage/temperature corners. The worst setup slack `timing__setup__ws` in `metrics.json` is the minimum over all of them and is set by the slow corner `ss_100C_1v60` (1.60 V, 100 °C). The final 7.5 ns run meets setup timing at every corner; its typical-corner (`nom_tt_025C_1v80`) setup slack is 3.817 ns.

### Commands Used

Run from the `pnr/` directory inside the Nix/LibreLane environment:

```bash
cd pnr
librelane config.json
cp runs/VERIFY_7P5_REPEAT/final/metrics.json metrics.json
cp runs/VERIFY_7P5_REPEAT/final/gds/mult_array.gds mult_array.gds
klayout mult_array.gds
```

For each attempt, `CLOCK_PERIOD` in `config.json` was edited and `librelane config.json` was run again; every attempt is listed in the table below.

### Final Physical-Design Results

The final implementation was verified using LibreLane at a 7.5 ns clock period. A repeated run with the same configuration was also completed.

| Metric | Final result |
|---|---:|
| Clock period | 7.5 ns |
| Worst setup slack | +0.456391 ns |
| Total negative setup slack (TNS) | 0 |
| Setup violations | 0 |
| Routing DRC errors | 0 |
| Magic DRC errors | 0 |
| KLayout DRC errors | 0 |
| LVS errors | 0 |
| LVS property failures | 0 |
| Core area | 17,759.5 µm² |
| Routed wirelength | 2,500 µm |
| Instances after place and route | 4,831 total (339 standard cells excluding fill/decap) |

The recorded results indicate that the repeated 7.5 ns implementation passed setup timing, routing DRC, and LVS checks. The saved signoff metrics are in `pnr/metrics.json`.

### Clock-Period Verification

The following runs were recorded during the timing-closure investigation.

| Run tag | Clock period | Worst setup slack (ns) | Setup violations |
|---|---:|---:|---:|
| `RUN_2026-10-24_20-38-54` | 3.5 ns | -2.093688 | 15 |
| `RUN_2026-10-25_01-53-19` | 4.0 ns | -1.593688 | 15 |
| `RUN_2026-10-25_02-04-14` | 4.5 ns | -1.093721 | 12 |
| `RUN_2026-10-25_02-40-47` | 5.0 ns | -0.595666 | 9 |
| `RUN_2026-10-25_02-45-27` | 5.5 ns | -0.106871 | 5 |
| `RUN_2026-10-25_02-28-42` | 6.0 ns | -0.040062 | 3 |
| `RUN_2026-10-25_02-50-24` | 6.5 ns | -0.155348 | 6 |
| `RUN_2026-10-25_04-15-04` | 6.5 ns | -0.155348 | 6 |
| `RUN_2026-10-25_04-17-52` | 7.0 ns | -0.043609 | 2 |
| `RUN_2026-10-25_04-22-50` | 7.5 ns | +0.456391 | 0 |
| `VERIFY_7P5_REPEAT` | 7.5 ns | +0.456391 | 0 |
| `VERIFY_8P0` | 8.0 ns | +0.956391 | 0 |
| `VERIFY_8P5` | 8.5 ns | +1.456391 | 0 |

Negative setup slack indicates that the timing constraint was not met in that run. The 7.5 ns implementation and the two longer-period verification runs recorded positive worst setup slack and zero setup violations.

The table reports timing metrics only. DRC and LVS claims are restricted to the final implementation results shown above rather than extrapolated to runs for which this summary does not list those metrics.

### Physical-Design Deliverables

- `pnr/config.json`: Configuration for the final 7.5 ns implementation.
- `pnr/metrics.json`: Signoff metrics from the repeated 7.5 ns run.
- `pnr/mult_array.gds`: GDSII layout from the repeated 7.5 ns implementation.
- `report/mult_array_layout_whole_die_clean.png`: Complete die layout screenshot.
- `report/mult_array_layout_zoomed.png`: Zoomed-in layout screenshot.

### Part D Status

The final 7.5 ns implementation, GDSII output, saved metrics, and layout screenshots are available. The reported signoff results show zero setup violations, zero routing DRC errors, and zero LVS errors.

## Final Report

The consolidated report is `report/report.pdf`. It contains the completed results tables for Parts B, C and D, the waveform, hand-worked example and block diagram for Part A, both layout screenshots, the record of all physical-design runs, and the answers to Questions 1–6.

## Final Project Status

| Stage | Status |
|---|---|
| Part A: RTL design and exhaustive functional verification | Completed |
| Part B: Logic synthesis and gate-level simulation | Completed |
| Part C: Static timing analysis | Completed |
| Part D: Physical design and GDSII generation | Completed |
| README documentation | Updated in this version |
| Final consolidated PDF report | Completed: `report/report.pdf` |
