`timescale 1ns / 1ps
module pgmMem(
    input reset,
    input [7:0] addr,
    output [15:0] dataOut
    );
    
    reg [15:0] mem [255:0];
    always @(negedge reset)
    begin
        mem[0] = 16'b0001_0001_0000_0100;   //ldb
        mem[1] = 16'b0000_0001_0000_0010;   //lda
        mem[2] = 16'b0111_0101_0000_0000;   //cmb
        mem[3] = 16'b0111_0110_0000_0000;   //incb
        mem[4] = 16'b0111_0001_0000_0000;   //add
        mem[5] = 16'b0001_0001_0000_0011;   //ldb
        mem[6] = 16'b0111_0010_0000_0011;   //and
        mem[7] = 16'b0010_0000_0101_0000;   //sta
        mem[8] = 16'b0010_0000_0101_0000;   //ldb
    end
    
    assign dataOut = mem[addr];
endmodule
