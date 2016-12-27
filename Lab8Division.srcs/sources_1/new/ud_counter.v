module ud_counter(input clk, und, ld, rst, en,
	input[2:0] start,
	output reg [2:0] count_out
    );

always@(posedge clk) begin
			if(rst)  count_out=3'b000; //Synchronous reset
			else if(en) begin
			     if(ld) count_out=start;
			     else if (und) count_out=count_out+3'b01;
			     else count_out=count_out-3'b01;
			    end 
			 else count_out=count_out;
end
endmodule
