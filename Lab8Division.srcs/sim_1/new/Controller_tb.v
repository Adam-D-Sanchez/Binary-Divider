module Controller_tb(

    );

reg tb_clk, tb_rst, tb_zero_flag, tb_lessthan, tb_go;
reg [2:0] tb_cnt_out;
wire tb_x_ld,tb_x_sl,tb_x_sr,tb_x_en,tb_x_lb,tb_x_rb,tb_y_ld,tb_bm_sel1,tb_r_ld,tb_r_sl,tb_r_sr,tb_r_en,tb_r_lb,tb_c_und,tb_c_ld,tb_c_en, tb_smq_sel2, tb_smr_sel2, tb_error, tb_done;

parameter  IDLE=20'b000000_0_0_00000_000_0000, LOAD=20'b100000_1_0_10000_011_0000, INITSHIFT=20'b010100_0_0_01010_000_0000, RESTORE=20'b010100_0_0_01010_000_0000, SUB=20'b000000_0_1_10000_000_0000, SET=20'b010101_0_0_01010_000_0000, FINALSHIFT=20'b000000_0_0_00110_000_0000, OUT=20'b000000_0_0_00000_000_1110, ERROR=20'b000000_0_0_00000_000_0011, DECREMENT=20'b000000_0_0_00000_001_0000;
Calc_CU DUT(.clk(tb_clk),.rst(tb_rst),.x_ld(tb_x_ld),.x_sl(tb_x_sl),.x_sr(tb_x_sr),.x_en(tb_x_en),.x_lb(tb_x_lb),.x_rb(tb_x_rb),.y_ld(tb_y_ld),.bm_sel1(tb_bm_sel1),.r_ld(tb_r_ld),.r_sl(tb_r_sl),.r_sr(tb_r_sr),.r_en(tb_r_en),.r_lb(tb_r_lb),.c_und(tb_c_und),.c_ld(tb_c_ld),.c_en(tb_c_en), .smq_sel2(tb_smq_sel2), .smr_sel2(tb_smr_sel2),.cnt_out(tb_cnt_out),.zero_flag(tb_zero_flag),.lessthan(tb_lessthan),.go(tb_go),.error(tb_error),.done(tb_done));

wire [19:0] word={tb_x_ld,tb_x_sl,tb_x_sr,tb_x_en,tb_x_lb,tb_x_rb,tb_y_ld,tb_bm_sel1,tb_r_ld,tb_r_sl,tb_r_sr,tb_r_en,tb_r_lb,tb_c_und,tb_c_ld,tb_c_en, tb_smq_sel2, tb_smr_sel2, tb_done, tb_error};

task CHANGECLOCK;
begin	
#5;
tb_clk=1;
#5;
tb_clk=0;
end
endtask 

initial begin

	CHANGECLOCK;
		if(word!=IDLE)begin $display("Error in idle 1"); $stop; end
tb_cnt_out=1;
tb_go=1;
	CHANGECLOCK;
		if(word!=LOAD)begin $display("Error in load"); $stop; end
	CHANGECLOCK;
		if(word!=INITSHIFT)begin $display("Error in INITSHIFT"); $stop; end
	CHANGECLOCK;
	    if(word!=DECREMENT)begin $display("Error in DECREMENT"); $stop; end
tb_lessthan=1;
	CHANGECLOCK;
		if(word!=RESTORE)begin $display("Error in RESTORE"); $stop; end
tb_lessthan=0;
	CHANGECLOCK;
        if(word!=DECREMENT)begin $display("Error in DECREMENT"); $stop; end
tb_cnt_out=3'b000;
	CHANGECLOCK;
		if(word!=SUB)begin $display("Error in SUB"); $stop; end

	CHANGECLOCK;
		if(word!=SET)begin $display("Error in SET"); $stop; end
	CHANGECLOCK;
		if(word!=FINALSHIFT)begin $display("Error in FINALSHIFT"); $stop; end
	CHANGECLOCK;
		if(word!=OUT)begin $display("Error in OUT"); $stop; end
	CHANGECLOCK;
$display("End of good run.");


//Start error'd run.

		if(word!=IDLE)begin $display("Error in idle2"); $stop; end
tb_zero_flag=1;
tb_go=1;
	CHANGECLOCK;
		if(word!=LOAD)begin $display("Error in load2"); $stop; end
tb_go=0;
	CHANGECLOCK;
		if(word!=INITSHIFT)begin $display("Error in INITSHIFT2"); $stop; end
	CHANGECLOCK;
		if(word!=ERROR)begin $display("Error in ERROR State"); $stop; end
	CHANGECLOCK;
		if(word!=IDLE)begin $display("Error in IDLE3"); $stop; end
#5;

$display("Error run tests passed");
$display("All tests passed.");
$finish;

end
endmodule
