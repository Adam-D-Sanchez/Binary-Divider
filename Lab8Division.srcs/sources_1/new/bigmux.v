module bigmux( input sel1,
	input [4:0] in0, in1,
	output reg [4:0] out
    );
always@(*) begin 
	if(sel1) out=in1; 
	else out=in0;
end
endmodule
