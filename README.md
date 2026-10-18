# 4-bit Array Multiplier: RTL to GDSII

## Team Members

- Anumay Rai — Roll Number: 2025122013
- Ashlin K Sunil — Roll Number: 2024102025

## Project Description

Implementation and verification of a 4-bit unsigned array multiplier using Verilog and the SKY130 130 nm process.

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

Expected successful output:

```text
PASS: 256 vectors checked, 0 errors
```

### Fault-Injection Verification

A deliberately faulty full-adder implementation was tested separately. The testbench detected 95 errors across 256 vectors.

The correct implementation was restored and subsequently passed all 256 test vectors.

## Project Status

- Part A: RTL implementation and functional verification completed.
- Part B: Pending.
- Part C: Pending.
- Part D: Pending.
- Final report: Pending.
