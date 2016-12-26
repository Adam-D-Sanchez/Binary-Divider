`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 04:33:20 PM
// Design Name: 
// Module Name: smallmux
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


module smallmux(input sel2,
	input [3:0] in0, in1,
	output reg [3:0] out
    );
always@(*) begin 
	if(sel2) out=in1; 
	else out=in0;
end
endmodule
