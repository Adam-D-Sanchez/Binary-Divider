
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 08:26:30 PM
// Design Name: 
// Module Name: DivCalc
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


module DivCalc(
	input go, clk, rst,
	input [3:0] DVND, DVSR,
	output done, error,
	output [3:0] QTNT, RMDR,CURR
    );

wire A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
wire[2:0]AA;

Calc_CU Controller(.clk(clk),.rst(rst),.zero_flag(S),.lessthan(T),.go(go),.x_ld(A),.x_sl(B),.x_sr(C),.x_en(D),.x_lb(E),.x_rb(F),.y_ld(G),.bm_sel1(H),.r_ld(I),.r_sl(J),.r_sr(K),.r_en(L),.r_lb(M),.c_und(N),.c_ld(O),.c_en(P),.smq_sel2(Q),.smr_sel2(R),.Current(CURR),.cnt_out(AA),.done(done),.error(error));
datapath Manipulator(.clk(clk),.rst(rst),.quotient(QTNT),.remainder(RMDR),.divisor(DVSR),.dividend(DVND),.cnt_out(AA),.zero_flag(S),.lessthan(T),.x_ld(A),.x_sl(B),.x_sr(C),.x_en(D),.x_lb(E),.x_rb(F),.y_ld(G),.bm_sel1(H),.r_ld(I),.r_sl(J),.r_sr(K),.r_en(L),.r_lb(M),.c_und(N),.c_ld(O),.c_en(P),.smq_sel2(Q),.smr_sel2(R));
endmodule
