`timescale 1ns/1ps
module tb_mult;
reg clk;
reg rst_n;
reg [3:0] a,b;
wire [7:0] p;
integer checked;
integer errors;
integer i,j;
mult_array DUT(.clk(clk),.rst_n(rst_n),.a(a),.b(b),.p(p));
initial begin
clk=0;
forever #5 clk=~clk;
end
task check_vector;
input [3:0] ta;
input [3:0] tb;
reg [7:0] expected;
begin
@(negedge clk);
a=ta;
b=tb;
expected=ta*tb;
repeat(2) @(posedge clk);
#1;
checked=checked+1;
if(p!==expected) begin
$display("ERROR: a=%0d b=%0d expected=%0d got=%0d",ta,tb,expected,p);
errors=errors+1;
end
end
endtask
initial begin
rst_n=0;
a=0;
b=0;
checked=0;
errors=0;
repeat(2) @(negedge clk);
rst_n=1;
for(i=0;i<16;i=i+1) begin
for(j=0;j<16;j=j+1) begin
check_vector(i,j);
end
end
if(errors==0)
$display("PASS: 256 vectors checked, 0 errors");
else
$display("FAIL: 256 vectors checked, %0d errors",errors);
$finish;
end
initial begin
$dumpfile("mult.vcd");
$dumpvars(0,tb_mult);
end
endmodule
