`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 04:23:04 PM
// Design Name: 
// Module Name: ud_counter
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


module ud_counter(input clk, und, ld, rst, en,
	input[2:0] start,
	output reg [2:0] count_out

    );

always@(posedge clk) begin
			if(rst)  count_out=3'b000; //Synchronous reset
			else if(en) begin
			     if(ld) count_out=start;
			     else if (und) count_out=count_out+3'b01;
			     else count_out=count_out-3'b01;
			    end 
			 else count_out=count_out; 
	 
	 
//    case({rst,ld,en,und})
//        1000: count_out=2'b00;//reset
//        0100: count_out=start; //loaded
//        0011: begin if(count_out==2'b11) begin  count_out=2'b00; end else count_out=count_out+2'b01; end //increment
//        0001: begin if(count_out==2'b00) begin  count_out=2'b11; end else count_out=count_out-2'b01;  end//decrement
//        default: count_out=count_out;
//    endcase
end
endmodule
