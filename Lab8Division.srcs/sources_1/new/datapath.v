`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 04:40:04 PM
// Design Name: 
// Module Name: datapath
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


module datapath(input[3:0] divisor, dividend,
input clk,rst,x_ld,x_sl,x_sr,x_en,x_lb,x_rb,y_ld,bm_sel1,r_ld,r_sl,r_sr,r_en,r_lb,c_und,c_ld,c_en, smq_sel2, smr_sel2,
output[2:0] cnt_out,
output zero_flag, lessthan,
output[3:0] quotient, remainder
    );

wire [3:0]x_out,y_out,sub_out;
wire [4:0]r_in,r_out;
smallshiftdreg X_Register(.clk(clk),.rst(rst),.ld(x_ld),.sl(x_sl),.sr(x_sr),.en(x_en),.lb(x_lb),.rb(x_rb),.d_in(dividend),.q_out(x_out));
dreg Y_register(.clk(clk),.rst(rst),.ld(y_ld),.d_in(divisor),.q_out(y_out),.flag(zero_flag));
bigshiftdreg R_Register(.clk(clk),.rst(rst),.en(r_en),.ld(r_ld),.sl(r_sl),.sr(r_sr),.lb(r_lb),.rb(x_out[3]),.d_in(r_in),.q_out(r_out));
bigmux R_input(.sel1(bm_sel1),.in0(5'b0),.in1({1'b0,sub_out}),.out(r_in));
subtractor subtraction(.A(r_out[4:0]),.B(y_out),.C(sub_out));
ud_counter count(.clk(clk),.rst(rst),.und(c_und),.ld(c_ld),.en(c_en),.start(3'b100),.count_out(cnt_out));
smallmux QuotientMux(.sel2(smq_sel2),.in0(4'b0),.in1(x_out),.out(quotient));
smallmux RemainderMux(.sel2(smr_sel2),.in0(4'b0),.in1(r_out[3:0]),.out(remainder));
comparator	LessThan (.A(r_out[3:0]),.B(y_out),.lt(lessthan));
endmodule
