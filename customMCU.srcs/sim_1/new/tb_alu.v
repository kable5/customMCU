`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 07:16:42 PM
// Design Name: 
// Module Name: tb_alu
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


module tb_alu();

reg[2:0] FS;
reg[15:0] A;
reg[15:0] B;
wire[15:0] F;
alu UUT(.FS(FS), .A(A), .B(B), .F(F));
initial begin
      FS = 3'b001;
      A = 16'd5;
      B = 16'd2;
      #100   
     
      A = 16'd15;
      B = 16'd0;  
    
    for (integer i = 0; i < 8; i = i + 1) 
    begin

        FS = i;
        #20;
    end
   $finish;
 end

endmodule

