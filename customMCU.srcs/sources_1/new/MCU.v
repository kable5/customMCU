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
//////////////////////////////////////////////////////////////////////////////////


module MCU(
    input clk,
    input reset
    );
    
    reg [7:0] INTVEC;
    reg [11:0] stack;
    reg Z,C,I;
    
    wire [11:0] outm_c;
    wire branchDet = ~Decode_EX[4]|(Decode_EX[3]&~z);
    
    //IF reg/wires
    reg [7:0] IF_PC;
    
    wire [15:0] inst;
    
    //DOF reg/wires
    reg [15:0] DOF_PC;
    reg [15:0] DOF_IR;
    
    wire  iff, rw, ra, md, ms, mw, ma, mf;
    wire [2:0] fs;
    wire [1:0] me,bs;
    wire [1:0] fullmf = {~fs[2], mf};
    wire [15:0] out_rega, out_regb, me_out, ma_out, mf_out;
    
    //EX reg/wires
    reg [11:0] EX_PC;
    reg [15:0] Bus_b, Bus_a;
    reg [11:0] Bus_addr;
    reg [10:0] Decode_EX;
    
    wire [15:0] outm_b;
    wire [15:0] F, m_bus;
    wire [11:0] BrA;
    wire DHS,z,c;
    
    //WB reg/wires
    reg [3:0] Decode_WB;
    reg [15:0] Bus_F, Bus_mem;
    
    wire [15:0] outm_d;
    wire [11:0] outm_s;
    
    mux4x2 muxC(.a(IF_PC+1), .b(BrA), .c(Bus_b[11:0]), .d(BrA), .sel(Decode_EX[4:3]),
                       .out(outm_c));
    
    //IF modules
    pgmMem PgmMem_unit(.reset(reset), .addr(IF_PC),
                        .dataOut(inst));
    
    //DOF modules
    decoder Decoder_unit(.inst(DOF_IR),
                        .iff(iff), .rw(rw), .ra(ra), .md(md), .ms(ms), .mw(mw), .bs(bs), .fs(fs), .ma(ma), .me(me), .mf(mf));               
    regFile regFile_unit(.clk(clk), .reset(reset), .wr_en(Decode_WB[3]), .reg_addr(Decode_WB[2]), .in_data(outm_d),
                        .A_data(out_rega), .B_data(out_regb));
    mux4x2 muxE(.a(out_regb), .b(mf_out), .c(16'b0|Z), .d(16'b0|C), .sel(me),
                .out(me_out));
    mux2x1 muxA(.a(DOF_PC), .b(out_rega), .sel(ma),
                .out(ma_out));
    mux4x2 muxF(.a(16'b0|stack), .b(16'b0|DOF_IR[11:0]), .c(stack+1), .d(16'b0|DOF_IR[11:0]),.sel(fullmf),
                .out(mf_out));
                
    //EX Modules
    alu ALU_unit(.FS(Decode_EX[2:0]), .A(Bus_a), .B(Bus_b), 
                .F(F), .Z(z), .C(z));
    mux2x1 muxB (.a(Bus_a), .b(Bus_b), .sel(Decode_EX[7]),
                    .out(outm_b));
    dataMem Data_Mem_Unit(.clk(clk), .wr_en(Decode_EX[5]),.reset(reset), .addr(Bus_addr), .data_in(outm_b),
                            .data_out(m_bus));
     dataHazardStall Data_Stall_Unit(.RW(Decode_EX[9]), .DA(Decode_EX[8]), .DAP(ra),.MA(ma), .MB(me), .MF(mf),
                                        .DHS(DHS));
     adder BrAdd(.a(DOF_PC), .b(F), .out(BrA));
     //WB Modules
     mux2x1 muxD (.a(Bus_F), .b(Bus_mem), .sel(Decode_WB[1]),
                    .out(outm_d));
     mux2x1 muxS (.a(16'b0|stack), .b(Bus_F), .sel(Decode_WB),
                    .out(outm_s));
    
    always @ (negedge reset)
    begin
        stack = 12'hFFF;
        Z = 0;
        C = 0;
        I = 0;
        INTVEC = 8'b1000_0000;
        
        IF_PC = 0;
        DOF_PC=0;
        DOF_IR = 16'hFFFF;
        Decode_EX = 0;
        Decode_WB = 0;
        Bus_F = 0;
    end
    
    always @ (posedge clk)
    begin
        if(DHS && ~I)IF_PC <= outm_c;
        if(DHS && I) IF_PC <= INTVEC;
        
        if(DHS)DOF_PC <= IF_PC;
        if(DHS) DOF_IR <= inst | ~{16{branchDet}};
        
        //EX Stage
        if(DHS) EX_PC <= DOF_PC;
        
        I <= iff;
        Decode_EX[9] <= rw & branchDet & DHS;
        Decode_EX[8] <= ra & DHS;
        Decode_EX[7] <= md;
        Decode_EX[6] <= ms;
        Decode_EX[5] <= mw & DHS & branchDet;
        Decode_EX[4:3] <= bs & {2{DHS}} & {2{branchDet}};
        Decode_EX[2:0] <= fs;
        
        Bus_b <= me_out;
        Bus_a <= ma_out;
        Bus_addr <= mf_out;
        
        //WB Stage
        Bus_F <= F;
        Bus_mem <= m_bus;
        Z <= z;
        C <= c;
        
        Decode_WB[3] <= Decode_EX[9];
        Decode_WB[2] <= Decode_EX[8];
        Decode_WB[1] <= Decode_EX[7];
        Decode_WB[0] <= Decode_EX[6];
        
        stack <= outm_s;
        
    end
endmodule
