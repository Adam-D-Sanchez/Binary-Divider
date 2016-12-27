module bigshiftdreg(input clk, rst, ld, sl, sr, en, lb, rb,
	input[4:0] d_in,
	output reg [4:0] q_out
    );

always@(posedge clk) begin //synchronous.
	if (rst) q_out<=5'b0; //reset asserted
	else if (ld) q_out<=d_in;  //load asserted
	else if (sr&&en)q_out<={lb,q_out[4:1]}; //allows shifting to the right. 
	else if (sl&&en) q_out<={q_out[3:0],rb}; //allows shifting to the left.
	else q_out<=q_out; //holds if no other signals are active.
end
endmodule
