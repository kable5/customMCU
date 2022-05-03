`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2022 03:20:58 PM
// Design Name: 
// Module Name: branchHandler
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


module branchHandler(

    );
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2021 04:38:24 PM
// Design Name: 
// Module Name: branchHandler
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


module branchHandler(
    input reset,
    input [1:0] BS,
    input PS,
    input Z,
    output [1:0] sel,
    output detector
    );
    reg [1:0] tempSel;
    reg tempDet;
    always @(*)
    begin
        tempSel = {BS[1],(BS[0]&(BS[1]|(PS^Z)))};
        tempDet = ~(tempSel[1]|tempSel[0]);
    end
    assign sel=tempSel;
    assign detector=tempDet;
endmodule
