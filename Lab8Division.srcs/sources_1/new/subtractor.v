module subtractor(input [3:0] A,B,
	output reg [3:0] C
    );

always@(*)begin
	C=A-B;
end
endmodule
