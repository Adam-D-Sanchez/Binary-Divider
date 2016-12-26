`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2016 01:31:20 PM
// Design Name: 
// Module Name: mdbcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mdBCD(
input [4:0] B,
output reg [3:0] C10,C1 //coded 10 and coded 1

    );
//this module takes a binary input and outputs a BCD for each digit in decimal.
//Borrowed from http://www.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html
    
integer K;

    always@(B)
    begin
    C10= 4'b0;//starts off as both being zero
    C1=4'b0;
    
    for(K=4; K>=0; K=K-1)//runs for all four bits of input
    begin
    if (C10>=5)// if any BCD is greater than 5, add 3 to allow the appropriate shift
        begin //into the next digit
        C10=C10+3;
        end
    if (C1>=5)
        begin
        C1=C1+3;
        end

    C10 = C10 << 1;
    C10[0]=C1[3];
    C1 = C1 << 1;
    C1[0]=B[K]; //starts the shifting here 
   end
 end
    
endmodule