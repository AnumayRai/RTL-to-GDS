# SKY130 standard-cell Liberty file
set lib $::env(LIB)

# Read the RTL source files
yosys read_verilog rtl/full_adder.v rtl/mult_array.v

# Synthesize and flatten the multiplier
yosys synth -top mult_array -flatten

# Map flip-flops and combinational logic to SKY130 cells
yosys dfflibmap -liberty $lib
yosys abc -liberty $lib

# Remove unused logic
yosys opt_clean -purge

# Generate cell statistics and area report
yosys tee -o synth/mult_array_stat.rpt stat -liberty $lib

# Write the gate-level netlist
yosys write_verilog -noattr synth/mult_array_netlist.v
