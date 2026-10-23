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

**Status: Pending**

This stage will use OpenSTA to analyse the critical path, calculate the minimum clock period and maximum operating frequency, and generate the timing report.

## Part D: Physical Design and GDSII Generation

**Status: Pending**

This stage will use LibreLane to perform physical design, generate the final GDSII layout, and obtain the required implementation metrics and DRC/LVS results.

## Final Report

**Status: Pending**

The final report will consolidate the results, completed tables, required screenshots, design analysis, and answers to the assignment questions.
