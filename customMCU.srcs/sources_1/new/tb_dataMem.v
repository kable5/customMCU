`timescale 1ns / 1ps

module tb_data_mem();
reg clk;
reg wr_en;
reg [15:0] data_in;
reg [11:0] addr;
wire [15:0] data_out;

dataMem UUT(.clk(clk), .data_in(data_in), .data_out(data_out), .wr_en(wr_en), .addr(addr));
    initial
    begin
        clk =1;
        
        wr_en =1;
        addr = 16'd4095;
        data_in = 16'b0000_0011;
        #10;
        
        wr_en = 0;
        #10;   
        
        wr_en =1;
        addr = 16'd4094;
        data_in = 16'b0000_1111;
        #10;
                
        wr_en = 0;
        #10;   
        
        wr_en =1;
        addr = 16'd4094;
        data_in = 16'b0001_0000;
        #10;
                        
        wr_en = 0;
        #10;     
        
        addr = 16'd4095;
        #10; 
        $finish;
    end 
    always
    begin
        #5;
        clk = ~clk;
    end
endmodule
