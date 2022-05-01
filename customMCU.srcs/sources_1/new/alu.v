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
    input[2:0] FS;
    input[15:0] A;
    input[15:0] B;
    output reg [15:0] F;
    output Z, C;
    reg [15:0] ztemp = 0;
    always @(*)
    begin
        case(FS)
            3'b001: F = A + B;
            3'b010: F = A & B;
            3'b011: F = 0;
            3'b100: F = B + 16'b1;
            3'b101: F = B - 16'b1;
            3'b110: F = ~B;
            3'b111:
            begin
                if(B==0)F = 1; else F=2;
            end
            default: F = 0;
       endcase
       $display("%b", FS);
       $display("%b", F);
       if (F == 16'b0 && FS == 3'b101)
       begin
            $display("made it");
            ztemp = 1;
       end
    end
    
    assign Z = ztemp;
endmodule

