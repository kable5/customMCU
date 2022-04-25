`timescale 1ns / 1ps

module tb_reg_file();
    reg clk, wr_en,reg_addr, reset;
    reg [15:0] in_data;
    wire[15:0] A_data;
    wire[15:0] B_data;
    
    always #10 clk =~clk;
    
    regFile UUT(.clk(clk), .wr_en(wr_en), .reg_addr(reg_addr), .reset(reset), .in_data(in_data), .A_data(A_data), .B_data(B_data));
    initial begin
        clk = 0;  
        reset = 1;
        #5;
        reset =0;
        #400;
    end
    initial
    begin
        wr_en = 0;
        reg_addr = 0;
        in_data = 16'b0000_0000_1000_0000;
        #50;
        wr_en = 1;
        #50;
        reg_addr = 1;
        #50;
        $finish;
    end
endmodule
