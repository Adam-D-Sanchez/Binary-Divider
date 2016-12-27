module smallmux(input sel2,
	input [3:0] in0, in1,
	output reg [3:0] out
    );
always@(*) begin 
	if(sel2) out=in1; 
	else out=in0;
end
endmodule
