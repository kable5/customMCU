`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UTD, Dr. Bhatia CE 6370.001
// Engineer: Kristopher Ables
// 
// Create Date: 04/19/2022 12:33:42 PM
// Design Name: 
// Module Name: tb_decoder
// Project Name: customMCU
// Target Devices: Zybo Z-10
// Tool Versions: 
// Description: Sends control signals to the MCU to direct control flow
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// - Double check to make sure that undefined (x) is synthesizable, otherwise set to 0
// - Check SC and SZ control flow to ensure proper functionality
// - Implement custom instructions once details are more apparent
// - Appears ms, me, mf all the same signal, check design and run tests for possible combination
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder(
    input [15:0] inst,
    output iff,
    output rw,
    output ra,
    output md,
    output ms,
    output mw,
    output bs,
    output [2:0] fs,
    output [1:0] ma,
    output me,
    output mf
    );
    
    reg [3:0] opCode;
    reg [3:0] noAdOpCode;
    reg [13:0] tempOut;
    
    always @(*)
    begin
        //iff_rw_ra_md_ms_mw_bs_fs_ma_me_mf
        //TODO: Probably a better way to init this
        opCode[3]<=inst[15];
        opCode[2]<=inst[14];
        opCode[1]<=inst[13];
        opCode[0]<=inst[12];
        case(opCode)
            //LDA
            4'b0000:
            begin
                tempOut <= 14'b0_1_0_1_0_0_0_000_00_0_0;
            end
            //LDB
            4'b0001:
            begin
                tempOut <= 14'b0_1_1_1_0_0_0_000_00_0_0;
            end
            //STA
            4'b0010:
            begin
                tempOut <= 14'b0_0_x_x_0_1_0_xxx_00_0_0;
            end
            //STB
            4'b0011:
            begin
                tempOut <= 14'b0_0_x_x_0_1_0_xxx_00_0_0;
            end
            //JMP
            4'b0100:
            begin
                tempOut <= 14'b0_0_x_x_0_0_1_xxx_00_0_0;
            end
            //JSR
            4'b1000:
            begin
                tempOut <= 14'b0_0_x_x_1_0_1_xxx_00_0_0;
            end
            //PUSHA
            4'b1010:
            begin
                tempOut <= 14'b0_0_x_x_1_1_0_101_00_1_1;
            end
            //POPA
            4'b1100:
            begin
                tempOut <= 14'b0_1_0_1_1_0_0_100_00_1_1;
            end
            //RET
            4'b1110:
            begin
                tempOut <= 14'b0_0_x_x_1_0_0_100_00_1_1;
            end
            //No Address format
            4'b0001:
            begin
                //TODO: As above, probably better way to init
                noAdOpCode[3] <= inst[11];
                noAdOpCode[2] <= inst[10];
                noAdOpCode[1] <= inst[9];
                noAdOpCode[0] <= inst[8];
                
                case(noAdOpCode)
                    //ADD
                    4'b0001:
                    begin
                        tempOut <= 14'b0_1_0_0_0_0_0_001_00_0_0;
                    end
                    //AND
                    4'b0010:
                    begin
                        tempOut <= 14'b0_1_0_0_0_0_0_010_00_0_0;
                    end
                    //CLA
                    4'b0011:
                    begin
                        tempOut <= 14'b0_1_0_0_0_0_0_011_00_0_0;
                    end
                    //CLB
                    4'b0100:
                    begin
                        tempOut <= 14'b0_1_1_0_0_0_0_011_00_0_0;
                    end
                    //CMB
                    4'b0101:
                    begin
                        tempOut <= 14'b0_1_1_0_0_0_0_110_00_0_0;
                    end
                    //INCB
                    4'b0110:
                    begin
                        tempOut <= 14'b0_1_1_0_0_0_0_100_00_0_0;
                    end
                    //DECB
                    4'b0111:
                    begin
                        tempOut <= 14'b0_1_1_0_0_0_0_101_00_0_0;
                    end
                    //CLC
                    4'b1000:
                    begin
                        tempOut <= 14'b0_0_x_x_0_0_0_011_10_0_0;
                    end
                    //CLZ
                    4'b1001:
                    begin
                        tempOut <= 14'b0_0_x_x_0_0_0_011_11_0_0;
                    end
                    //ION
                    4'b1010:
                    begin
                        tempOut <= 14'b1_0_x_x_0_0_0_xxx_00_0_0;
                    end
                    //IOF
                    4'b1011:
                    begin
                        tempOut <= 14'b0_0_x_x_0_0_0_xxx_00_0_0;
                    end
                    //SC
                    4'b1100:
                    begin
                        tempOut <= 14'b0_0_x_x_0_0_0_xxx_00_0_0;
                    end
                    //SZ
                    4'b1101:
                    begin
                        tempOut <= 14'b0_0_x_x_0_0_0_xxx_00_0_0;
                    end
                endcase
            end
        endcase
    end
    
    assign iff = tempOut[13];
    assign rw = tempOut[12];
    assign ra = tempOut[11];
    assign md = tempOut[10];
    assign ms = tempOut[9];
    assign mw = tempOut[8];
    assign bs = tempOut[7];
    assign fs = tempOut[6:4];
    assign ma = tempOut[3:2];
    assign me = tempOut[1];
    assign mf = tempOut[0];
    
endmodule