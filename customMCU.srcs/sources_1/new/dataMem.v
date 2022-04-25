`timescale 1ns / 1ps

module dataMem(
    input clk, wr_en,
    input[11:0] addr,
    input[15:0] data_in,
    output [15:0] data_out
    );
    
    reg[15:0]mem[4095:0];
    reg[15:0] tempOut;
    always@(posedge clk)
    begin
        if(wr_en)
            mem[addr] <= data_in;
        else 
            tempOut <= mem[addr];
    end
    
    assign data_out = tempOut;
endmodule
