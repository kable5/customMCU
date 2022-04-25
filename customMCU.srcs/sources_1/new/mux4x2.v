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
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    input [1:0] sel,
    output [7:0] out
    );
    reg [7:0] tempOut;
    always @ (*)
    begin 
        if(sel == 0)
            tempOut = a;
        else if(sel == 1)
            tempOut = b;
        else if(sel == 2)
            tempOut = c;
        else if(sel == 3)
            tempOut = d;  
        else tempOut = a;  
    end
    assign out = tempOut;
endmodule
