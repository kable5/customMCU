`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 07:12:21 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 1.1 - Added case to handle SC and SZ
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(FS, A, B, F);
    input[2:0] FS;
    input[15:0] A;
    input[15:0] B;
    output reg[15:0] F;
    always @(FS)
    begin
        //needs default case
        case(FS)
            3'b001: F = A + B;
            3'b010: F = A & B;
            3'b011: F = 0;
            3'b100: F = B + 16'd1;
            3'b101: F = B - 16'd1;
            3'b110: F = ~A;
            3'b111: if(B==0) F = A+1;
            default: F = 0;
       endcase
    end
endmodule

