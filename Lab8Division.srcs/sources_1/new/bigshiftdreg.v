`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 04:35:02 PM
// Design Name: 
// Module Name: bigshiftdreg
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


module bigshiftdreg(input clk, rst, ld, sl, sr, en, lb, rb,
	input[4:0] d_in,
	output reg [4:0] q_out
    );

always@(posedge clk) begin
		 if (rst) q_out<=5'b0;
	else if (ld) q_out<=d_in; 
	else if (sr&&en)q_out<={lb,q_out[4:1]}; 
	else if (sl&&en) q_out<={q_out[3:0],rb};
	else q_out<=q_out;
end
endmodule
