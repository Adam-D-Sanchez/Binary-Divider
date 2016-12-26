`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 04:28:43 PM
// Design Name: 
// Module Name: dreg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dreg(input clk, ld, rst,
	input [3:0] d_in,
	output reg [3:0] q_out,
	output reg flag
    );

always@(posedge clk) begin
		  if (rst) q_out<=4'b0;
	else  if (ld) q_out<= d_in;
	else q_out<=q_out;
end

always@(q_out)begin //checks for divide by zero error
if (q_out==4'b0) flag=1;
else flag=0;
end
endmodule
