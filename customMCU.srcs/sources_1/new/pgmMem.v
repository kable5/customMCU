`timescale 1ns / 1ps
module pgmMem(
    input reset,
    input [7:0] addr,
    output [15:0] dataOut
    );
    
    reg [15:0] mem [255:0];
    always @(negedge reset)
    begin
        mem[0] = 16'b0111_0110_0000_0000;   //incb
    end
    
    assign dataOut = mem[addr];
endmodule
