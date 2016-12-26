`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 07:38:15 PM
// Design Name: 
// Module Name: Calc_CU
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


module Calc_CU(
	input clk, rst, zero_flag, lessthan, go,
	input [2:0] cnt_out,
	output reg x_ld,x_sl,x_sr,x_en,x_lb,x_rb,y_ld,bm_sel1,r_ld,r_sl,r_sr,r_en,r_lb,c_und,c_ld,c_en, smq_sel2, smr_sel2, error, done,
    output [3:0] Current
    );

parameter IDLE=4'b0, LOAD=4'b0001, INITSHIFT=4'b0010, RESTORE=4'b0011, SUB=4'b0100, SET=4'b0101, FINALSHIFT=4'b0110, OUT=4'b0111, ERROR=4'b1000, DECREMENT=4'b1001;

reg [3:0] CS, NS;
reg [19:0] ctrl_vect;

assign Current=CS;

initial begin
	CS=4'b0;
end

always@(CS, rst, zero_flag, lessthan, go, cnt_out) begin //Next State Logic
	case(CS)
		IDLE: begin //This is the idle default state, if go is enabled it goes to the load state. Otherwise it stays idle
				if(go) NS=LOAD; 
				else   NS=IDLE;
			   end
		LOAD: NS=INITSHIFT; //this has the values loaded into the datapath
		INITSHIFT: begin if (zero_flag) NS=ERROR;
		                 else NS=DECREMENT;
		           end
	    DECREMENT: begin if (lessthan) NS=RESTORE;
	                      else NS=SUB; 
	                 end   
		RESTORE:begin  //performs the restore function, and figures out which to choose next. 
					if(cnt_out==3'b000) NS=FINALSHIFT;
					else NS=DECREMENT;
				end
		SUB: NS=SET;//automatic movement
		SET:begin 
	                if(cnt_out==3'b000) NS=FINALSHIFT;
                    else NS=DECREMENT;
			end
		FINALSHIFT: NS=OUT;//automatically moves to displaying outputs
		default: NS=IDLE;//moves to initial state whether in OUT or ERROR state. 
	endcase
end

always@(posedge clk, posedge rst) begin //State Register
	if(rst) CS<=IDLE; //Synchronous reset
	else CS<=NS;
end

always@(CS) begin
	case (CS)
	IDLE:       ctrl_vect=20'b000000_0_0_00000_000_0000;
	LOAD:       ctrl_vect=20'b100000_1_0_10000_011_0000;
	INITSHIFT:  ctrl_vect=20'b010100_0_0_01010_000_0000;
	DECREMENT:  ctrl_vect=20'b000000_0_0_00000_001_0000;
	RESTORE:    ctrl_vect=20'b010100_0_0_01010_000_0000;
	SUB:        ctrl_vect=20'b000000_0_1_10000_000_0000;
	SET:        ctrl_vect=20'b010101_0_0_01010_000_0000;
	FINALSHIFT: ctrl_vect=20'b000000_0_0_00110_000_0000;
	OUT:        ctrl_vect=20'b000000_0_0_00000_000_1110;
	ERROR:      ctrl_vect=20'b000000_0_0_00000_000_0011;
	endcase
end

always@(CS) begin
x_ld=   ctrl_vect[19];
x_sl=   ctrl_vect[18];
x_sr=   ctrl_vect[17];
x_en=   ctrl_vect[16];
x_lb=   ctrl_vect[15];
x_rb=   ctrl_vect[14];
y_ld=   ctrl_vect[13];
bm_sel1=ctrl_vect[12];
r_ld=   ctrl_vect[11];
r_sl=   ctrl_vect[10];
r_sr=   ctrl_vect[9];
r_en=   ctrl_vect[8];
r_lb=   ctrl_vect[7];
c_und=  ctrl_vect[6];
c_ld=   ctrl_vect[5];
c_en=   ctrl_vect[4];
smq_sel2=ctrl_vect[3];
smr_sel2=ctrl_vect[2];
done=   ctrl_vect[1];
error=  ctrl_vect[0];
end

endmodule
