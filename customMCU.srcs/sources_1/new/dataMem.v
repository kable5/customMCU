`timescale 1ns / 1ps

module dataMem(
    input clk, wr_en, reset,
    input[11:0] addr,
    input[15:0] data_in,
    output reg [15:0] data_out
    );
    
    reg[15:0]mem[4095:0];
    always@(negedge clk)
    begin
        if(wr_en)
            mem[addr] <= data_in;
        else 
            data_out <= mem[addr];
    end
    
    always@(negedge reset)
    begin
        mem[0] <= 16'hABCD;
        mem[16'h0100] <= 16'h0000;
        mem[16'h0101] <= 16'h0001;
        mem[16'h0102] <= 16'h0002;
        mem[16'h0103] <= 16'h0003;
        mem[16'h0104] <= 16'h0005;
        mem[16'h0105] <= 16'hAAAA;
        mem[16'h0106] <= 16'h0009;
        mem[16'h0107] <= 16'h0007;
        
    end
    
    //assign data_out = tempOut;
endmodule
