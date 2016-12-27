module comparator(input [3:0] A,B,
	output reg lt
    );

always@(*)begin 
if(A<B) lt=1; 
else lt=0;
end

endmodule
