`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 08:47:21 PM
// Design Name: 
// Module Name: MCU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
//          .5 - Created up to IF stage
//          .5.1 - Altered to accomodate new diagram
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MCU(
    input clk,
    input reset
    );
    
    reg [11:0] stack;
    reg Z;
    reg C;
    
    //IF reg/wires
    reg [7:0] IF_PC;
    
    wire [15:0] inst;
    
    //DOF reg/wires
    reg [7:0] DOF_PC;
    reg [15:0] DOF_IR;
    
    wire iff, rw, ra, md, ms, mw, ma, mb, mf;
    wire [2:0] fs;
    wire [1:0] me;
    wire [15:0] out_rega, out_regb, me_out, ma_out, mf_out;
    
    //EX reg/wires
    reg [7:0] EX_PC;
    reg [15:0] Bus_b, Bus_a;
    reg [11:0] Bus_addr;
    reg [9:0] Decode_EX;
    
    wire [15:0] outm_b;
    wire [15:0] F, m_bus;
    
    //WB reg/wires
    reg [3:0] Decode_WB;
    reg [15:0] Bus_F, Bus_mem;
    
    wire [15:0] outm_d;
    
    //IF modules
    pgmMem PgmMem_unit(.reset(reset), .addr(IF_PC),
                        .dataOut(inst));
    
    //DOF modules
    decoder Decoder_unit(.inst(DOF_IR),
                        .iff(iff), .rw(rw), .ra(ra), .md(md), .ms(ms), .mw(mw), .mb(mb), .fs(fs), .ma(ma), .me(me), .mf(mf));               
    regFile regFile_unit(.clk(clk), .reset(reset), .wr_en(Decode_WB[3]), .reg_addr(Decode_WB[2]), .in_data(outm_d),
                        .A_data(out_rega), .B_data(out_regb));
    mux4x2 muxE(.a(out_regb), .b(stack), .c(Z), .d(C), .sel(me),
                .out(me_out));
    mux2x1 muxA(.a(DOF_PC), .b(out_rega), .sel(ma),
                .out(ma_out));
    mux2x1 muxF(.a(stack), .b(DOF_IR[11:0]), .sel(mf),
                .out(mf_out));
                
    //EX Modules
    alu ALU_unit(.FS(Decode_EX[2:0]), .A(Bus_a), .B(Bus_b), 
                .F(F));
    mux2x1 muxB (.a(Bus_a), .b(Bus_b), .sel(Decode_EX[7]),
                    .out(m_bus));
    dataMem Data_Mem_Unit(.clk(clk), .wr_en(Decode_EX[4]), .addr(Bus_addr), .data_in(outm_b),
                            .data_out(m_bus));
                            
     //WB Modules
     mux2x1 muxD (.a(Bus_F), .b(Bus_mem), .sel(Decode_WB[1]),
                    .out(outm_d));
    
    always @ (negedge reset)
    begin
        stack = 0;
        Z = 0;
        C = 0;
        
        IF_PC = 0;
        DOF_PC=0;
        Decode_EX = 0;
        Decode_WB = 0;
    end
    
    always @ (posedge clk)
    begin
        IF_PC <= IF_PC+1;
        
        DOF_PC <= IF_PC;
        DOF_IR <= inst;
        
        //EX Stage
        EX_PC <= DOF_PC;
        
        Decode_EX[9] <= iff;
        Decode_EX[8] <= rw;
        Decode_EX[7] <= ra;
        Decode_EX[6] <= md;
        Decode_EX[5] <= ms;
        Decode_EX[4] <= mw;
        Decode_EX[3] <= mb;
        Decode_EX[2:0] <= fs;
        
        Bus_b <= me_out;
        Bus_a <= ma_out;
        
        //WB Stage
        Bus_F <= F;
        Bus_mem <= m_bus;
        
        Decode_WB[3] <= Decode_EX[9];
        Decode_WB[2] <= Decode_EX[8];
        Decode_WB[1] <= Decode_EX[7];
        Decode_WB[0] <= Decode_EX[6];
        
    end
endmodule
