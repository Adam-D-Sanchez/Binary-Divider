`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 08:50:20 PM
// Design Name: 
// Module Name: datapath_tb
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


module datapath_tb(

    );

reg [3:0] tb_dividend, tb_divisor;
reg tb_clk,tb_rst;
wire tb_x_ld,tb_x_sl,tb_x_sr,tb_x_en,tb_x_lb,tb_x_rb,tb_y_ld,tb_bm_sel1,tb_r_ld,tb_r_sl,tb_r_sr,tb_r_en,tb_r_lb,tb_c_und,tb_c_ld,tb_c_en,tb_smq_sel2,tb_smr_sel2;
wire tb_zero_flag, tb_lessthan;
wire[1:0] tb_cnt_out;
wire [3:0] tb_quotient, tb_remainder;
reg [17:0] state;

assign {tb_x_ld,tb_x_sl,tb_x_sr,tb_x_en,tb_x_lb,tb_x_rb,tb_y_ld,tb_bm_sel1,tb_r_ld,tb_r_sl,tb_r_sr,tb_r_en,tb_r_lb,tb_c_und,tb_c_ld,tb_c_en,tb_smq_sel2,tb_smr_sel2}=state;

datapath DUT(.divisor(tb_divisor),.dividend(tb_dividend),.clk(tb_clk),.rst(tb_rst),.x_ld(tb_x_ld),.x_sl(tb_x_sl),.x_sr(tb_x_sr),.x_en(tb_x_en),.x_lb(tb_x_lb),.x_rb(tb_x_rb),.y_ld(tb_y_ld),.bm_sel1(tb_bm_sel1),.r_ld(tb_r_ld),.r_sl(tb_r_sl),.r_sr(tb_r_sr),.r_en(tb_r_en),.r_lb(tb_r_lb),.c_und(tb_c_und),.c_ld(tb_c_ld),.c_en(tb_c_en), .smq_sel2(tb_smq_sel2), .smr_sel2(tb_smr_sel2),.cnt_out(tb_cnt_out),.zero_flag(tb_zero_flag),.lessthan(tb_lessthan),.quotient(tb_quotient),.remainder(tb_remainder));

parameter  IDLE=18'b000000_0_0_00000_000_00, LOAD=18'b100000_1_0_10000_010_00, INITSHIFT=18'b010100_0_0_01010_000_00, RESTORE=18'b010100_0_0_01010_000_00, SUB=18'b000000_0_1_10000_000_00, SET=18'b010101_0_0_01010_001_00, FINALSHIFT=18'b000000_0_0_00110_000_00, OUT=18'b000000_0_0_00000_000_11, ERROR=18'b000000_0_0_00000_000_00, DECREMENT=20'b000000_0_0_00000_001_0000;

task CHANGECLOCK;
begin	
#5;
tb_clk=1;
#5;
tb_clk=0;
end
endtask 

initial begin
tb_rst=1;
    CHANGECLOCK;
tb_rst=0;

    state=IDLE;
    CHANGECLOCK;
    
tb_dividend=4'b0;
tb_divisor=4'b0;
    state=LOAD;
    CHANGECLOCK;
    
    state=INITSHIFT;
    CHANGECLOCK;

	   if(!tb_zero_flag) begin $display("Zero flag failed."); $stop; end
    CHANGECLOCK;
	   if (tb_zero_flag) begin $display("Zero flag test passed."); end

// Moving on to real manipulation This time, 12 / 4. Expected result is 3 remainder 0.
    state=IDLE;
    CHANGECLOCK;

tb_dividend=4'b1100; //12 This block will load into the registers 
tb_divisor=4'b0100; //4
    state=LOAD;
    CHANGECLOCK;

    state=INITSHIFT;
    CHANGECLOCK;

    state=DECREMENT;
    CHANGECLOCK;

    state=RESTORE; //2 Restores needed for this to complete.
    CHANGECLOCK;

    state=DECREMENT;
    CHANGECLOCK;

    state=RESTORE;
    CHANGECLOCK;

    state=DECREMENT;
    CHANGECLOCK;

    state=SUB; //2 sets of sub and reset needed to get this to complete.
    CHANGECLOCK;

    state=SET;
    CHANGECLOCK;

    state=DECREMENT;
    CHANGECLOCK;

    state=SUB;
    CHANGECLOCK;

    state=SET;
    CHANGECLOCK;

    state=FINALSHIFT;
    CHANGECLOCK;

    state=OUT;
    CHANGECLOCK;
if(tb_quotient!=4'b0011)begin $display("Error in the quotient"); $stop; end
if(tb_remainder!=4'b0000)begin $display("Error in the remainder"); $stop; end
$display("All tests passed");
$finish;

end

endmodule
