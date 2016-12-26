`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2016 01:58:48 PM
// Design Name: 
// Module Name: Divider
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


module Divider(input [3:0] Divisor, Dividend,
	input clk100MHz, go, button, rst,
	output error, done,
	output [7:0] LEDSEL, LEDOUT
    );


	supply1 [7:0] vcc;
	wire [3:0] QTNT_wire, RMDR_wire, CURR_wire,QTNT_H,QTNT_L,RMDR_H,RMDR_L;
	wire [6:0] B,C,D,E,G;

	clk_gen ClockMaker(.clk100MHz(clk100MHz),.rst(rst),.clk_5KHz(p_clk));
	debounce pushClock(.pb(button),.clk(p_clk),.pb_debounced(clk));
	DivCalc MainDivider(.go(go),.clk(clk),.rst(rst),.DVND(Dividend),.DVSR(Divisor),.done(done),.error(error),.QTNT(QTNT_wire),.RMDR(RMDR_wire),.CURR(CURR_wire));
	b27 CurrentState(.in(CURR_wire),.s(B));
	mdBCD QuotientDisplay(.B(QTNT_wire),.C10(QTNT_H),.C1(QTNT_L));
	mdBCD RemainderDisplay(.B(RMDR_wire),.C10(RMDR_H),.C1(RMDR_L));
	b27 QuotientHigh(.in(QTNT_H),.s(C));
	b27 QuotientLow(.in(QTNT_L),.s(D));
	b27 RemainderHigh(.in(RMDR_H),.s(E));
	b27 RemainderLow(.in(RMDR_L),.s(G));
	led_mux DisplayDigits(.clk(p_clk),.rst(rst),.LED0({1'b1,B}),.LED1(vcc),.LED2(vcc),.LED3(vcc),.LED4({1'b1,C}),.LED5({1'b1,D}),.LED6({1'b1,E}),.LED7({1'b1,G}),.LEDSEL(LEDOUT),.LEDOUT(LEDSEL));
endmodule
