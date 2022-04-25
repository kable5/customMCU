`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 10:14:47 AM
// Design Name: 
// Module Name: mux2x1
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


module mux2x1(
    input [15:0] a,
    input [15:0] b,
    input sel,
    output reg[15:0] out
    );
    always @ (*)
    begin 
        if(sel == 0)
            out = a;
        else out = b;
    end
endmodule
