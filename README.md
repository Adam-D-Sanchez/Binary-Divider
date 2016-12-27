# Binary-Divider
This is the 8th Lab for CMPE 125 at San Jose State University. This is 
allowed to perform 4 bit division, with 4 bit operands, 4 bit quotient, and 4 bit 
remainder. 

Besides the constraint file, all files are written in Verilog. 

By directory:

===================================constrs_1/new===================================

DividerFPGA.xdc -- This is a file written to have the Verilog code work with real 
hardware. It is a file type decided by Xilinx, and is specifically formatted to 
work on the Digilent/Xilinx Hardware. Pins are specified to have the design 
validated on actual hardware.

===================================sim_1/new===================================

Calc_tb.v -- This is a testbench which tests all possible combinations of the
inputs, and reads the values at the outputs when the done signal is asserted.
It is a self checking test bench which stops if an incorrect value is reached,
and prints a message to assist in troubleshooting.

Controller_tb.v -- This is a testbench which reads the outputs from the control
unit, based on the state. The test bench also runs through a few different 
scenarios, to validat the order in which the test bench would work.

datapath_tb.v -- This is a test bench which throws a few values into the 
datapath to make sure that the datapath works as intended. 

===================================sim_1/new===================================

Work in progress. 
