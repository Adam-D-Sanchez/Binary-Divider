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
scenarios, to validate the order in which the control unit would work.

datapath_tb.v -- This is a test bench which throws a few values into the 
datapath to make sure that the datapath works as intended. 

===================================sim_1/new===================================

Calc_CU.v -- This is the control unit for the binary divider. Based upon the input
signals to the calculator, and the status signals from the datapath, the control unit
decides which state to enter next, and which values to provide to the datapath to 
perform the intended function during each state. 

DivCalc.v -- This is the top module for the division calculator. This is a purely
black box level module, with instantiations of the control unit and the datapath.

Divider.v -- This is the file to implement on the Digilent FPGA. There are a few
different instantiations which provide a clock signal, a debouncer for the buttons, 
and other modules which make binary outputs from the calculator be readable to a user
in a visual format on the 7 segments on the Digilent FPGA.

b27.v -- This module was heavily inspired by Donald Hung's provided code for a 
previous lab. This module takes in any binary number and outputs the correct signals
to be displayed on a 7 segment display.

bigmux.v -- This module is for a multiplexer used in the datapath. This specific one 
provides the input to the R (Remainder) register.

bigshiftdreg.v -- This module is a 5 bit shift register. It is used in the datapath to 
hold the value of R (Remainder) in the calculator.

clk_gen.v -- This module is provided by Donald Hung. It is used to take in the 100MHz clock
and convert to a 5kHz clock and a 4 second clock.

comparator.v -- This module is a 4 bit comparator. It is used in the datapath and
compares the value between the Y (Divisior) and R (Remainder) register, an essential 
part of the binary division algorithm on which this calculator is designed.

datapath.v -- This module is the overall datapath, which manipulates the inputs based
on the algorithm to provide the intended outputs.

debounce2.v -- This module is provided by Donald Hung to compensate for the imperfections
inherent in a button. To make sure the clock doesn't change multiple times per button press.
It waits for a steady signal before outputting a high or low.

dreg.v -- This is a 4 bit D Register. It is used in the datapath for holding the Y 
(Divisor) value. 

led_mux.v -- This module is provided by Donald Hung, to display all the values on the 7 
segment display. Decides where to put individual digits.

mdbcd.v -- This module takes in a 4 bit binary number and converts it into multiple BCD
values, to make the 7 segment more readable.

smallmux.v -- This module is another mux, used to write a 0 to the output registers while
waiting for the calculator to perform the operations.

smallshiftdreg.v This module is a 4 bit shift register. It is used in the datapath 
to hold the value of X (Dividend, eventually quotient) in the calculator. 

subtractor.v -- This module performs 4 bit binary subtraction.

ud_counter.v -- This module is a counter. It is used in the datapth to keep track of 
the number of cycles passed. When 4 DECREMENT states have occured, the counter will output
a flag which is a status signal to the control unit, to move on to an output state.
