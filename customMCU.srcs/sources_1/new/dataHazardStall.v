`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2021 07:39:27 PM
// Design Name: 
// Module Name: dataHazardStall
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


module dataHazardStall(
    input RW,DA,DAP,MF,
    input [1:0] MB,
    input MA,
    output DHS
    );
    
    reg compA;
    reg ha;
    reg hb;
    reg tempDHS;
    
    always @ (*)
    begin
        if(DA == DAP | (MA==1&&MF==1)) compA = 1;
        else compA = 0;
        ha = ~MA & RW & compA;
        hb = ~(MB[0]|MB[1]) & RW & compA;
        tempDHS = ~(ha|hb);
    end
    assign DHS = tempDHS;
endmodule
