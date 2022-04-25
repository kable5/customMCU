`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 09:39:52 AM
// Design Name: 
// Module Name: tb_mcu
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


module tb_mcu();

    reg clk, reset;
    
    MCU UUT(.clk(clk), .reset(reset));
    
    initial
    begin
        clk=0;
        reset=1;
        #5;
        reset = 0;
        #400;
    end
    
    initial
    begin
        #1000;
        $finish;
    end
    
    always
    begin
        #10;
        clk=~clk;
    end
endmodule
