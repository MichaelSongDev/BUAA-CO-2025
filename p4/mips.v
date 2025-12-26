`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:36 11/12/2025 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips(
    input clk,
    input reset
    );


//IFU
    wire [31:0] GRF1;
    wire [25:0] imm26;
    wire [15:0] imm16;
    wire [1:0] IFU_Sel;
    wire zero;
    wire [31:0] pc;
    wire [31:0] pcplus4;
    wire [31:0] Instr;

    IFU IFUModule(.GRF(GRF1),
                  .imm26(imm26),
                  .imm16(imm16),
                  .select(IFU_Sel),
                  .zero(zero),
                  .clk(clk),
                  .reset(reset),
                  .Instr(Instr),
                  .PC(pc),
                  .PCplus4(pcplus4)
    );

    wire [5:0] OpCode;
    wire [4:0] Rs;
    wire [4:0] Rt;
    wire [4:0] Rd;
    wire [4:0] Shamt;
    wire [5:0] Funct;

    assign OpCode = Instr[31:26];
    assign Rs = Instr[25:21];
    assign Rt = Instr[20:16];
    assign Rd = Instr[15:11];
    assign Shamt = Instr[10:6];
    assign Funct = Instr[5:0];

//ImmExt
    wire [31:0] imm32;
    wire ExtOp;

    ImmExt ImmExtModule(.Instr(Instr),
                        .Op(ExtOp),
                        .imm32(imm32),
                        .imm16(imm16)
    );

//imm26
    assign imm26 = Instr[25:0];

//chooseRegAddr
    wire RegDst;
    wire Reg_ra;
    wire [4:0] RegAddr;

    assign RegAddr = (Reg_ra) ? 5'h1f :
                     (RegDst) ? Rt : Rd;

//chooseRegData
    wire MemToReg;
    wire PCToReg;
    wire [31:0] ALU_Data;
    wire [31:0] DM_Data;
    wire [31:0] RegData;

    assign RegData = (PCToReg) ? pcplus4 :
                     (MemToReg) ? DM_Data : ALU_Data;

//RegWE
    wire Controller_RegWE;
    wire RegWE;
    wire [5:0] type;

    chooseRegWE RegWEModule(.Controller_RegWE(Controller_RegWE),
                            .Rs(Rs),
                            .Rt(Rt),
                            .Rd(Rd),
                            .Shamt(Shamt),
                            .type(type),
                            .WE(RegWE)
    );

//GRF
    wire [31:0] GRF2;

    GRF GRFModule(.A1(Rs),
                  .A2(Rt),
                  .A3(RegAddr),
                  .WD(RegData),
                  .clk(clk),
                  .reset(reset),
                  .WE(RegWE),
                  .PC(pc),
                  .RD1(GRF1),
                  .RD2(GRF2)
    );

//chooseALUIn1
    wire [31:0] ALUIn1;
    wire ALUInput1;

    assign ALUIn1 = (ALUInput1) ? {{27{1'b0}}, Shamt} : GRF1;

//chooseALUIn2
    wire [31:0] ALUIn2;
    wire ALUInput2;

    assign ALUIn2 = (ALUInput2) ? imm32 : GRF2;

//ALU
    ALU ALUModule(.in1(ALUIn1),
                  .in2(ALUIn2),
                  .type(type),
                  .out(ALU_Data),
                  .zero(zero)
    );

//DM
    wire DMWE;

    DM DMModule(.Addr(ALU_Data),
                .WD(GRF2),
                .clk(clk),
                .reset(reset),
                .WE(DMWE),
                .PC(pc),
                .Data(DM_Data)
    );

//Controller
    Controller ControllerModule(.OpCode(OpCode),
                                .Funct(Funct),
                                .type(type),
                                .nextPC_Sel(IFU_Sel),
                                .RegWE(Controller_RegWE),
                                .ALUInput1(ALUInput1),
                                .ALUInput2(ALUInput2),
                                .ExtOp(ExtOp),
                                .RegDst(RegDst),
                                .DMWE(DMWE),
                                .MemToReg(MemToReg),
                                .PCToReg(PCToReg),
                                .RegRa(Reg_ra)

    );

    
endmodule
