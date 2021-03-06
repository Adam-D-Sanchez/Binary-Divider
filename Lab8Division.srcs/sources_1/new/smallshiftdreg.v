module smallshiftdreg(input clk, rst, ld, sl, sr, en, lb, rb,
	input[3:0] d_in,
	output reg [3:0] q_out
    );

always@(posedge clk) begin
		 if (rst) q_out<=4'b0;
	else if (ld) q_out<=d_in; 
	else if (sr&&en)q_out<={lb,q_out[3:1]}; 
	else if (sl&&en) q_out<={q_out[2:0],rb};
	else q_out<=q_out;
end
endmodule
