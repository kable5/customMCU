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
//  1.1 - Adjusted outputs for SC & SZ, included custom instructions
// Additional Comments:
//
// - Double check to make sure that undefined (x) is synthesizable, otherwise set to 0
// - reduce custom insts down to 8 bits
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder(
    input [15:0] inst,
    output [1:0] iff,
    output rw,
    output ra,
    output md,
    output ms,
    output mw,
    output [1:0] bs,
    output [3:0] fs,
    output ma,
    output [1:0] me,
    output mf
    );
    
    reg [3:0] opCode;
    reg [3:0] noAdOpCode;
    reg [15:0] tempOut;
    
    always @(*)
    begin
        //iff_rw_ra_md_ms_mw_bs_fs_ma_me_mf
        //TODO: Probably a better way to init this
        opCode[3]<=inst[15];
        opCode[2]<=inst[14];
        opCode[1]<=inst[13];
        opCode[0]<=inst[12];
        //TODO: As above probably better way to init
        noAdOpCode[3] <= inst[11];
        noAdOpCode[2] <= inst[10];
        noAdOpCode[1] <= inst[9];
        noAdOpCode[0] <= inst[8];
        case(opCode)
            //LDA
            4'b0000:
            begin
                tempOut <= 16'b0_1_0_1_0_0_00_0000_0_00_1;
            end
            //LDB
            4'b0001:
            begin
                tempOut <= 16'b0_1_1_1_0_0_00_0000_0_00_1;
            end
            //STA
            4'b0010:
            begin
                tempOut <= 16'b0_0_0_x_0_1_00_0000_1_00_1;
            end
            //STB
            4'b0011:
            begin
                tempOut <= 16'b0_0_1_x_0_1_00_0000_0_00_1;
            end
            //JMP
            4'b0100:
            begin
                tempOut <= 16'b0_0_x_x_0_0_10_0000_0_01_1;
            end
            //JSR
            4'b1000:
            begin
                tempOut <= 16'b0_0_x_x_1_0_10_0000_0_01_0;
            end
            //PUSHA
            4'b1010:
            begin
                tempOut <= 16'b0_0_x_x_1_1_00_0101_0_01_0;
            end
            //POPA
            4'b1100:
            begin
                tempOut <= 16'b0_1_0_1_1_0_00_0000_0_01_0;
            end
            //RET
            4'b1110:
            begin
                tempOut <= 16'b0_0_x_x_1_0_10_0000_0_01_0;
            end
            //No Address format
            4'b0111:
            begin
                case(noAdOpCode)
                    //ADD
                    4'b0001:
                    begin
                        tempOut <= 16'b0_1_0_0_0_0_00_0001_1_00_1;
                    end
                    //AND
                    4'b0010:
                    begin
                        tempOut <= 16'b0_1_0_0_0_0_00_0010_1_00_1;
                    end
                    //CLA
                    4'b0011:
                    begin
                        tempOut <= 16'b0_1_0_0_0_0_00_0011_1_00_0;
                    end
                    //CLB
                    4'b0100:
                    begin
                        tempOut <= 16'b0_1_1_0_0_0_00_0011_0_00_0;
                    end
                    //CMB
                    4'b0101:
                    begin
                        tempOut <= 16'b0_1_1_0_0_0_00_0110_0_00_0;
                    end
                    //INCB
                    4'b0110:
                    begin
                        tempOut <= 16'b0_1_1_0_0_0_00_0100_0_00_0;
                    end
                    //DECB
                    4'b0111:
                    begin
                        tempOut <= 16'b0_1_1_0_0_0_00_0101_0_00_0;
                    end
                    //CLC
                    4'b1000:
                    begin
                        tempOut <= 16'b0_0_x_x_0_0_00_0011_0_11_0;
                    end
                    //CLZ
                    4'b1001:
                    begin
                        tempOut <= 16'b0_0_x_x_0_0_00_0011_0_10_0;
                    end
                    //ION
                    4'b1010:
                    begin
                        tempOut <= 16'b1_0_0_0_1_1_00_0101_0_01_0;
                    end
                    //IOF
                    4'b1011:
                    begin
                        tempOut <= 16'b0_0_x_x_1_1_00_0000_0_00_0;
                    end
                    //SC
                    4'b1100:
                    begin
                        tempOut <= 16'b0_0_x_x_0_0_11_0111_0_11_0;
                    end
                    //SZ
                    4'b1101:
                    begin
                        tempOut <= 16'b0_0_0_0_0_0_11_0111_0_10_0;
                    end
                    default:
                    begin
                        tempOut <= 16'b0_0_0_0_0_0_00_0000_0_00_0;
                    end
                endcase
            end
            //custom case
            4'b1111:
            begin
                case(noAdOpCode)
                //xor
                4'b0001:
                begin
                    tempOut <= 16'b0_1_1_0_0_0_00_1000_1_00_1;
                end
                //or
                4'b0010:
                begin
                    tempOut <= 16'b0_1_1_0_0_00_1001_1_00_1;
                end
                //shift left
                4'b0011:
                begin
                    tempOut <= 16'b0_1_0_0_0_0_00_1100_1_00_1;
                end
                //shift right
                4'b0100:
                begin
                    tempOut <= 16'b0_1_0_0_0_0_00_1101_1_00_1;
                end
                //shift left by 1
                4'b0101:
                begin
                    tempOut <= 16'b0_1_0_0_0_0_00_1110_1_00_1;
                end
                //shift right by 1
                4'b0110:
                begin
                    tempOut <= 16'b0_1_0_0_0_0_00_1111_1_00_1;
                end
                default:
                begin
                    tempOut <= 16'b0_0_0_0_0_0_0_0000_00_0_0;
                end
                endcase
            end
            default:
            begin
                tempOut <= 16'b0_0_0_0_0_0_0_0000_00_0_0;
            end
            
        endcase
    end
    
    assign iff = tempOut[15];
    assign rw = tempOut[14];
    assign ra = tempOut[13];
    assign md = tempOut[12];
    assign ms = tempOut[11];
    assign mw = tempOut[10];
    assign bs = tempOut[9:8];
    assign fs = tempOut[7:4];
    assign ma = tempOut[3];
    assign me = tempOut[2:1];
    assign mf = tempOut[0];
    
endmodule