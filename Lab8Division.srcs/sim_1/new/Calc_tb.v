`timescale 1ns / 1ps

module Calc_tb(

    );

reg tb_go, tb_clk, tb_rst;
reg [3:0] tb_DVND, tb_DVSR;
wire tb_done, tb_error;
wire [3:0] tb_QTNT, tb_RMDR;
integer M,N; //M will be the dividend, N will be the divisor.

	DivCalc DUT(.go(tb_go), //instantiation of unit under test.
.clk(tb_clk),
.rst(tb_rst),
.DVND(tb_DVND),
.DVSR(tb_DVSR),
.done(tb_done),
.error(tb_error),
.QTNT(tb_QTNT),
.RMDR(tb_RMDR));

task CHANGECLOCK; //task done to make code more readable. 
begin	
#5;
tb_clk=1;
#5;
tb_clk=0;
end
endtask 

initial begin
	
	tb_rst=1; //make sure all possible places are reset;
		CHANGECLOCK;
	tb_rst=0;

	//BEGIN EXHAUSTIVE LOOP TESTS
	tb_go=1;
	for(M=0;M<16;M=M+1) begin
		for(N=0;N<16;N=N+1) begin
			tb_DVND=M;
			tb_DVSR=N;
			while(!tb_done) begin
				CHANGECLOCK;
			end

			if(N==0 && tb_error==0) begin $display("Failed to catch divide by zero error at %d for the dividend.",M); $stop; end
			else if((M/N)!=tb_QTNT) begin $display("Quotient failed with %d / %d",M,N); $stop; end
			if((M%N)!=tb_RMDR) begin $display("Remainder failed with %d / %d",M,N); $stop; end
            if(!tb_done) begin $display("Done signal failed at %d / %d.",M,N); $stop; end
            
			CHANGECLOCK;
		end
	end
    $display("All tests passed.");
	$finish;

end


endmodule
