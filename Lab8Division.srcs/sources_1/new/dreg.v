module dreg(input clk, ld, rst,
	input [3:0] d_in,
	output reg [3:0] q_out,
	output reg flag
    );

always@(posedge clk) begin
		  if (rst) q_out<=4'b0;
	else  if (ld) q_out<= d_in;
	else q_out<=q_out;
end

always@(q_out)begin //checks for divide by zero error
if (q_out==4'b0) flag=1;
else flag=0;
end
endmodule
