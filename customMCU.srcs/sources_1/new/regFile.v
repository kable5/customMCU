`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 07:07:20 PM
// Design Name: 
// Module Name: regFile
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


module regFile(
    input clk,
    input reset,
    input wr_en,
    input reg_addr,
    input [15:0] in_data,
    output [15:0] A_data,
    output [15:0] B_data
    );
    
    reg [15:0] registers [1:0];
    
    always @(negedge clk or negedge reset)
    begin
        if(reset)
        begin
            registers[0] <= 0;
            registers[1] <= 0;
        end
        else if (wr_en == 1)
            registers[reg_addr] <= in_data;
    end
    assign A_data = registers[0];
    assign B_data = registers[1];
endmodule

