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


module alu(FS, A, B, F, Z, C);
    input[3:0] FS;
    input[15:0] A;
    input[15:0] B;
    output reg [15:0] F;
    output Z, C;
    reg [15:0] ztemp = 0;
    always @(*)
    begin
        case(FS)
            4'b0001: F = A + B;
            4'b0010: F = A & B;
            4'b0011: F = 0;
            4'b0100: F = B + 16'b1;
            4'b0101: F = B - 16'b1;
            4'b0110: F = ~B;
            4'b0111:
            begin
                if(B==0)F = 1; else F=2;
            end
            4'b1000: F = A ^ B;
            4'b1001: F = A|B;
            4'b1100: F = A << B;
            4'b1101: F = A >> B;
            4'b1110: F = A << 1;
            4'b1111: F = A >> 1;
            default: F = 0;
       endcase
       $display("%b", FS);
       $display("%b", F);
       if (F == 16'b0 && FS == 3'b101)
       begin
            ztemp = 1;
       end
    end
    
    assign Z = ztemp;
endmodule

