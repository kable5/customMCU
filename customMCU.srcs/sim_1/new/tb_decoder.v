`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UTD, Dr. Bhatia CE 6370.001
// Engineer: Kristopher Ables
// 
// Create Date: 04/19/2022 12:33:42 PM
// Design Name: 
// Module Name: tb_decoder
// Project Name: customMCU
// Target Devices: Zybo Z-10
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


module tb_decoder();

    reg [15:0] inst;
    wire iff, rw, ra, md, ms, mw, ma, me, mf;
    wire [2:0] fs;
    wire [1:0] mb;
    
    decoder UUT (.inst(inst), .iff(iff), .rw(rw), .ra(ra), .md(md), .ms(ms), .mw(mw), .mb(mb), .fs(fs), .ma(ma), .me(me), .mf(mf));
    
    initial
    begin
        //LDA
        inst = 16'b0000_0000_0000_0000;
        #10;
        //LDB
        inst = 16'b0001_0000_0000_0000;
        #10;
        //STA
        inst = 16'b0010_0000_0000_0000;
        #10;
        //STB
        inst = 16'b0011_0000_0000_0000;
        #10;
        //JMP
        inst = 16'b0100_0000_0000_0000;
        #10;
        //JSR
        inst = 16'b1000_0000_0000_0000;
        #10;
        //PUSHA
        inst = 16'b1010_0000_0000_0000;
        #10;
        //POPA
        inst = 16'b1100_0000_0000_0000;
        #10;
        //RET
        inst = 16'b1110_0000_0000_0000;
        #10;
        //ADD
        inst = 16'b0111_0001_0000_0000;
        #10;
        //AND
        inst = 16'b0111_0010_0000_0000;
        #10;
        //CLA
        inst = 16'b0111_0011_0000_0000;
        #10;
        //CLB
        inst = 16'b0111_0100_0000_0000;
        #10;
        //CMB
        inst = 16'b0111_0101_0000_0000;
        #10;
        //INCB
        inst = 16'b0111_0110_0000_0000;
        #10;
        //DECB
        inst = 16'b0111_0111_0000_0000;
        #10;
        //CLC
        inst = 16'b0111_1000_0000_0000;
       #10;
       //CLZ
        inst = 16'b0111_1001_0000_0000;
        #10;
        //ION
        inst = 16'b0111_1010_0000_0000;
        #10;
        //IOF
        inst = 16'b0111_1011_0000_0000;
        #10;
        //SC
        inst = 16'b0111_1100_0000_0000;
        #10;
        //SZ
        inst = 16'b0111_1101_0000_0000;
        #10;
        $finish;
     end
endmodule
