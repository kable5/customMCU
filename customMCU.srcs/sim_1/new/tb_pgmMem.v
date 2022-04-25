`timescale 1ns / 1ps

module tb_pgmMem();

    reg[7:0] addr;
    reg reset;
    wire[15:0] dataOut;
    pgmMem UUT(.reset(reset), .addr(addr), .dataOut(dataOut));
    
    initial
    begin    
        addr <= 8'b0;
        reset = 1'b1;
        #10;
        reset = 1'b0;
        #10;
    
        $finish;
    end
endmodule
