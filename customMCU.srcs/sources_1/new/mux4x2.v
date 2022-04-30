`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 10:12:30 AM
// Design Name: 
// Module Name: mux4x2
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


module mux4x2(
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,
    input [15:0] d,
    input [1:0] sel,
    output reg [15:0] out
    );
    always @ (*)
    begin 
        if(sel == 0)
            out = a;
        else if(sel == 1)
            out = b;
        else if(sel == 2)
            out = c;
        else if(sel == 3)
            out = d;  
        else out = a;  
    end
endmodule
