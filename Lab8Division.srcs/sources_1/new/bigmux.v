`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 04:31:46 PM
// Design Name: 
// Module Name: bigmux
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


module bigmux( input sel1,
	input [4:0] in0, in1,
	output reg [4:0] out
    );
always@(*) begin 
	if(sel1) out=in1; 
	else out=in0;
end
endmodule
