`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Mngineer: 
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
    input reset,
    input [31:0] i_inst_rdata,
    input [31:0] m_data_rdata,
    output w_grf_we,
    output [4:0] w_grf_addr,
    output [31:0] w_grf_wdata,
    output [31:0] w_inst_addr,
    output [31:0] i_inst_addr,
    output [31:0] m_data_addr,
    output [31:0] m_data_wdata,
    output [3:0] m_data_byteen,
    output [31:0] m_inst_addr
    );


//----------------------------------Fetch Zone----------------------------------//
    wire [31:0] F_PC;
    wire [31:0] F_PCplus8;
    wire [31:0] F_Instr;



//----------------------------------Decode Zone---------------------------------//
    wire [31:0] D_PC;
    wire [31:0] D_PCplus8;

    wire [31:0] D_Instr;
    wire [5:0] D_OpCode;
    wire [4:0] D_Rs;
    wire [4:0] D_Rt;
    wire [4:0] D_Rd;
    wire [4:0] D_Shamt;
    wire [5:0] D_Funct;
    wire [15:0] D_Imm16;
    wire [25:0] D_Imm26;

    wire [4:0] D_A1;
    wire [4:0] D_A2;
    wire [4:0] D_A3;
    wire [31:0] D_RD1;
    wire [31:0] D_RD2;

    wire [31:0] D_Imm32;

    wire D_zero;

    wire D_RegDst;
    wire [1:0] D_nextPC_Sel;
    wire D_ExtOp;
    wire D_RegRa;
    wire [5:0] D_type;
    wire [3:0] D_t_rs;
    wire [3:0] D_t_rt;
    wire [3:0] D_t;



//----------------------------------Execute Zone---------------------------------//
    wire [31:0] E_PC;
    wire [31:0] E_PCplus8;
    wire [31:0] E_RD1;
    wire [31:0] E_RD2;
    wire [4:0] E_A3;
    wire [31:0] E_Imm32;

    wire [31:0] E_Instr;
    wire [5:0] E_OpCode;
    wire [4:0] E_Rs;
    wire [4:0] E_Rt;
    wire [4:0] E_Rd;
    wire [4:0] E_Shamt;
    wire [5:0] E_Funct;
    wire [15:0] E_Imm16;
    wire [25:0] E_Imm26;

    wire [31:0] E_ALUIn1;
    wire [31:0] E_ALUIn2;
    wire [31:0] E_ALUOut;
    wire E_ALUInput1;
    wire E_ALUInput2;

    wire [31:0] E_MDUOut;
    wire E_isMFHILO;

    wire [31:0] E_fixedOutput;

    wire E_start;
    wire E_busy;

    wire [5:0] E_type;
    wire [3:0] E_t_rs;
    wire [3:0] E_t_rt;
    wire [3:0] E_t;



//----------------------------------Memory Zone----------------------------------//
    wire [31:0] M_PC;
    wire [31:0] M_PCplus8;
    wire [31:0] M_ALUOut;
    wire [31:0] M_RD2;
    wire [4:0] M_A3;

    wire [31:0] M_Instr;
    wire [5:0] M_OpCode;
    wire [4:0] M_Rs;
    wire [4:0] M_Rt;
    wire [4:0] M_Rd;
    wire [4:0] M_Shamt;
    wire [5:0] M_Funct;
    wire [15:0] M_Imm16;
    wire [25:0] M_Imm26;

    wire [31:0] M_Addr;
    wire [3:0] M_DMWE;
    wire [31:0] M_MemoryWriteData;
    wire [31:0] M_fixedMemoryWriteData;
    wire [31:0] M_Data;
    wire [31:0] M_fixedData;

    wire [5:0] M_type;
    wire [3:0] M_t_rs;
    wire [3:0] M_t_rt;
    wire [3:0] M_t;



//--------------------------------WriteBack Zone---------------------------------//
    wire [31:0] W_PC;
    wire [31:0] W_PCplus8;
    wire [31:0] W_ALUOut;
    wire [31:0] W_Data;

    wire [31:0] W_Instr;
    wire [5:0] W_OpCode;
    wire [4:0] W_Rs;
    wire [4:0] W_Rt;
    wire [4:0] W_Rd;
    wire [4:0] W_Shamt;
    wire [5:0] W_Funct;
    wire [15:0] W_Imm16;
    wire [25:0] W_Imm26;

    wire [4:0] W_A3;
    wire [31:0] W_RegWriteData;

    wire W_MemToReg;
    wire W_PCToReg;
    wire W_ControllerRegWE;
    wire W_RegWE;
    wire [5:0] W_type;
    wire [3:0] W_t_rs;
    wire [3:0] W_t_rt;
    wire [3:0] W_t;



//-----------------------------------Forward-------------------------------------//
    wire [31:0] D_fixedRD1;
    wire [31:0] D_fixedRD2;
    wire [31:0] E_fixedRD1;
    wire [31:0] E_fixedRD2;
    wire [31:0] M_fixedRD2;

    wire [3:0] D_t_rs_use;
    wire [3:0] D_t_rt_use;
    wire [3:0] D_t_new;

    wire [3:0] E_t_rs_use;
    wire [3:0] E_t_rt_use;
    wire [3:0] E_t_new;

    wire [3:0] M_t_rs_use;
    wire [3:0] M_t_rt_use;
    wire [3:0] M_t_new;

    wire [3:0] W_t_rs_use;
    wire [3:0] W_t_rt_use;
    wire [3:0] W_t_new;

    wire E_isPCplus8;
    wire M_isPCplus8;

    wire D_RD1_from_E_PCplus8;
    wire D_RD2_from_E_PCplus8;

    wire D_RD1_from_M_PCplus8;
    wire D_RD2_from_M_PCplus8;
    wire E_RD1_from_M_PCplus8;
    wire E_RD2_from_M_PCplus8;

    wire D_RD1_from_M;
    wire D_RD2_from_M;
    wire E_RD1_from_M;
    wire E_RD2_from_M;

    wire D_RD1_from_W;
    wire D_RD2_from_W;
    wire E_RD1_from_W;
    wire E_RD2_from_W;
    wire M_RD2_from_W;



//------------------------------------Stall--------------------------------------//
    wire PC_en;
    wire FD_en;
    wire DE_en;
    wire EM_en;
    wire MW_en;

    wire FD_reset;
    wire DE_reset;
    wire EM_reset;
    wire MW_reset;

    wire isMULTDIV;

    wire D_stall;



//------------------------------------Module-------------------------------------//

//Fetch Zone
    IFU IFUModule(.GRF(D_fixedRD1),
                  .imm26(D_Imm26),
                  .imm16(D_Imm16),
                  .select(D_nextPC_Sel),
                  .zero(D_zero),
                  .PC_en(PC_en),
                  .clk(clk),
                  .reset(reset),
                  .F_PC(F_PC),
                  .F_PCplus8(F_PCplus8));
    
    FD FDModule(.clk(clk),
                .reset(reset),
                .FD_en(FD_en),
                .FD_reset(FD_reset),
                .F_Instr(F_Instr),
                .F_PC(F_PC),
                .F_PCplus8(F_PCplus8),
                .D_Instr(D_Instr),
                .D_PC(D_PC),
                .D_PCplus8(D_PCplus8));

//Decode Zone
    Controller D_ControllerModule(.OpCode(D_OpCode),
                                  .Funct(D_Funct),
                                  .type(D_type),
                                  .nextPC_Sel(D_nextPC_Sel),
                                  .ExtOp(D_ExtOp),
                                  .RegDst(D_RegDst),
                                  .RegRa(D_RegRa),
                                  .t_rs(D_t_rs),
                                  .t_rt(D_t_rt),
                                  .t(D_t));
    GRF GRFModule(.clk(clk),
                  .reset(reset),
                  .WE(W_RegWE),
                  .A1(D_A1),
                  .A2(D_A2),
                  .A3(W_A3),
                  .WD(W_RegWriteData),
                  .RD1(D_RD1),
                  .RD2(D_RD2),
                  .PC(W_PC));

    ImmExt ImmExtModule(.Instr(D_Instr),
                        .Op(D_ExtOp),
                        .imm16(D_Imm16),
                        .imm32(D_Imm32));

    zero ZeroModule(.in1(D_fixedRD1),
                    .in2(D_fixedRD2),
                    .type(D_type),
                    .zero(D_zero));

    DE DEModule(.clk(clk),
                .reset(reset),
                .DE_en(DE_en),
                .DE_reset(DE_reset),
                .D_Instr(D_Instr),
                .D_PC(D_PC),
                .D_PCplus8(D_PCplus8),
                .D_RD1(D_fixedRD1),
                .D_RD2(D_fixedRD2),
                .D_A3(D_A3),
                .D_imm32(D_Imm32),
                .E_Instr(E_Instr),
                .E_PC(E_PC),
                .E_PCplus8(E_PCplus8),
                .E_RD1(E_RD1),
                .E_RD2(E_RD2),
                .E_A3(E_A3),
                .E_imm32(E_Imm32));

//Execute Zone
    Controller E_ControllerModule(.OpCode(E_OpCode),
                                  .Funct(E_Funct),
                                  .type(E_type),
                                  .ALUInput1(E_ALUInput1),
                                  .ALUInput2(E_ALUInput2),
                                  .isMFHILO(E_isMFHILO),
                                  .start(E_start),
                                  .t_rs(E_t_rs),
                                  .t_rt(E_t_rt),
                                  .t(E_t));
    
    ALU ALUModule(.in1(E_ALUIn1),
                  .in2(E_ALUIn2),
                  .type(E_type),
                  .out(E_ALUOut));

    MDU MDUModule(.clk(clk),
                  .reset(reset),
                  .in1(E_ALUIn1),
                  .in2(E_ALUIn2),
                  .type(E_type),
                  .start(E_start),
                  .out(E_MDUOut),
                  .busy(E_busy));

    EM EMModule(.clk(clk),
                .reset(reset),
                .EM_en(EM_en),
                .EM_reset(EM_reset),
                .E_Instr(E_Instr),
                .E_PC(E_PC),
                .E_PCplus8(E_PCplus8),
                .E_ALUOut(E_fixedOutput),
                .E_RD2(E_fixedRD2),
                .E_A3(E_A3),
                .M_Instr(M_Instr),
                .M_PC(M_PC),
                .M_PCplus8(M_PCplus8),
                .M_ALUOut(M_ALUOut),
                .M_RD2(M_RD2),
                .M_A3(M_A3));

//Memory Zone
    Controller M_ControllerModule(.OpCode(M_OpCode),
                                  .Funct(M_Funct),
                                  .type(M_type),
                                  .t_rs(M_t_rs),
                                  .t_rt(M_t_rt),
                                  .t(M_t));

    DMSave DMSaveModule(.addr(M_Addr),
                        .data(M_MemoryWriteData),
                        .type(M_type),
                        .WE(M_DMWE),
                        .fixed_data(M_fixedMemoryWriteData));

    DMLoad DMLoadModule(.addr(M_Addr),
                        .data(M_Data),
                        .type(M_type),
                        .fixed_data(M_fixedData));

    MW MWModule(.clk(clk),
                .reset(reset),
                .MW_en(MW_en),
                .MW_reset(MW_reset),
                .M_Instr(M_Instr),
                .M_PC(M_PC),
                .M_PCplus8(M_PCplus8),
                .M_A3(M_A3),
                .M_ALUOut(M_ALUOut),
                .M_DMData(M_fixedData),
                .W_Instr(W_Instr),
                .W_PC(W_PC),
                .W_PCplus8(W_PCplus8),
                .W_A3(W_A3),
                .W_ALUOut(W_ALUOut),
                .W_DMData(W_Data));

//WriteBack Zone
    Controller W_ControllerModule(.OpCode(W_OpCode),
                                  .Funct(W_Funct),
                                  .type(W_type),
                                  .MemToReg(W_MemToReg),
                                  .RegWE(W_ControllerRegWE),
                                  .PCToReg(W_PCToReg),
                                  .t_rs(W_t_rs),
                                  .t_rt(W_t_rt),
                                  .t(W_t));

    chooseRegWE chooseRegWEModule(.Controller_RegWE(W_ControllerRegWE),
                                  .Rs(W_Rs),
                                  .Rt(W_Rt),
                                  .Rd(W_Rd),
                                  .Shamt(W_Shamt),
                                  .type(W_type),
                                  .WE(W_RegWE));


//------------------------------------Assign-------------------------------------//

//Fetch Zone
    //extern IM
    assign F_Instr = i_inst_rdata;
    assign i_inst_addr = F_PC;

//Decode Zone
    assign D_OpCode = D_Instr[31:26];
    assign D_Rs = D_Instr[25:21];
    assign D_Rt = D_Instr[20:16];
    assign D_Rd = D_Instr[15:11];
    assign D_Shamt = D_Instr[10:6];
    assign D_Funct = D_Instr[5:0];
    assign D_Imm16 = D_Instr[15:0];
    assign D_Imm26 = D_Instr[25:0];

    assign D_A1 = D_Rs;
    assign D_A2 = D_Rt;
    assign D_A3 = (D_RegRa) ? 5'b11111 : 
                  (D_RegDst) ? D_Rt : D_Rd;

//Excute Zone
    assign E_OpCode = E_Instr[31:26];
    assign E_Rs = E_Instr[25:21];
    assign E_Rt = E_Instr[20:16];
    assign E_Rd = E_Instr[15:11];
    assign E_Shamt = E_Instr[10:6];
    assign E_Funct = E_Instr[5:0];
    assign E_Imm16 = E_Instr[15:0];
    assign E_Imm26 = E_Instr[25:0];

    assign E_ALUIn1 = (E_ALUInput1) ? E_Shamt : E_fixedRD1;
    assign E_ALUIn2 = (E_ALUInput2) ? E_Imm32 : E_fixedRD2;

    assign E_fixedOutput = (E_isMFHILO) ? E_MDUOut : E_ALUOut;

//Memory Zone
    assign M_OpCode = M_Instr[31:26];
    assign M_Rs = M_Instr[25:21];
    assign M_Rt = M_Instr[20:16];
    assign M_Rd = M_Instr[15:11];
    assign M_Shamt = M_Instr[10:6];
    assign M_Funct = M_Instr[5:0];
    assign M_Imm16 = M_Instr[15:0];
    assign M_Imm26 = M_Instr[25:0];    

    assign M_Addr = M_ALUOut;
    assign M_MemoryWriteData = M_fixedRD2;

    //extern DM
    assign m_data_addr = M_Addr;
    assign m_data_wdata = M_fixedMemoryWriteData;
    assign m_data_byteen = M_DMWE;
    assign M_Data = m_data_rdata;
    assign m_inst_addr = M_PC;

//WriteBack Zone
    assign W_OpCode = W_Instr[31:26];
    assign W_Rs = W_Instr[25:21];
    assign W_Rt = W_Instr[20:16];
    assign W_Rd = W_Instr[15:11];
    assign W_Shamt = W_Instr[10:6];
    assign W_Funct = W_Instr[5:0];
    assign W_Imm16 = W_Instr[15:0];
    assign W_Imm26 = W_Instr[25:0];    

    assign W_RegWriteData = (W_PCToReg) ? W_PCplus8 :
                            (W_MemToReg) ? W_Data : 
                            W_ALUOut;

    assign w_grf_addr = W_A3;
    assign w_grf_wdata = W_RegWriteData;
    assign w_grf_we = W_RegWE;
    assign w_inst_addr = W_PC;

//forward
    assign D_fixedRD1 = (D_RD1_from_E_PCplus8) ? E_PCplus8 :
                        (D_RD1_from_M_PCplus8) ? M_PCplus8 :
                        (D_RD1_from_M) ? M_ALUOut :
                        (D_RD1_from_W) ? W_RegWriteData :
                        D_RD1;
    assign D_fixedRD2 = (D_RD2_from_E_PCplus8) ? E_PCplus8 :
                        (D_RD2_from_M_PCplus8) ? M_PCplus8 :
                        (D_RD2_from_M) ? M_ALUOut : 
                        (D_RD2_from_W) ? W_RegWriteData :
                        D_RD2;
    assign E_fixedRD1 = (E_RD1_from_M_PCplus8) ? M_PCplus8 :
                        (E_RD1_from_M) ? M_ALUOut :
                        (E_RD1_from_W) ? W_RegWriteData :
                        E_RD1; 
    assign E_fixedRD2 = (E_RD2_from_M_PCplus8) ? M_PCplus8 :
                        (E_RD2_from_M) ? M_ALUOut :
                        (E_RD2_from_W) ? W_RegWriteData :
                        E_RD2; 
    assign M_fixedRD2 = (M_RD2_from_W) ? W_RegWriteData : M_RD2;


    assign D_t_rs_use = D_t_rs;
    assign D_t_rt_use = D_t_rt;
    assign D_t_new = D_t;

    assign E_t_rs_use = (E_t_rs == 4'hf) ? 4'hf :
                        (E_t_rs >= 4'h1) ? (E_t_rs - 4'h1) :
                        4'h0;
    assign E_t_rt_use = (E_t_rt == 4'hf) ? 4'hf :
                        (E_t_rt >= 4'h1) ? (E_t_rt - 4'h1) :
                        4'h0;
    assign E_t_new = (E_t == 4'hf) ? 4'hf :
                     (E_t >= 4'h1) ? (E_t - 4'h1) :
                     4'h0;

    assign M_t_rs_use = (M_t_rs == 4'hf) ? 4'hf :
                        (M_t_rs >= 4'h2) ? (M_t_rs - 4'h2) :
                        4'h0;
    assign M_t_rt_use = (M_t_rt == 4'hf) ? 4'hf :
                        (M_t_rt >= 4'h2) ? (M_t_rt - 4'h2) :
                        4'h0;
    assign M_t_new = (M_t == 4'hf) ? 4'hf :
                     (M_t >= 4'h2) ? (M_t - 4'h2) :
                     4'h0;

    assign W_t_rs_use = (W_t_rs == 4'hf) ? 4'hf :
                        (W_t_rs >= 4'h3) ? (W_t_rs - 4'h3) :
                        4'h0;
    assign W_t_rt_use = (W_t_rt == 4'hf) ? 4'hf :
                        (W_t_rt >= 4'h3) ? (W_t_rt - 4'h3) :
                        4'h0;
    assign W_t_new = (W_t == 4'hf) ? 4'hf :
                     (W_t >= 4'h3) ? (W_t - 4'h3) :
                     4'h0;


    assign E_isPCplus8 = (E_type == 6'b001011) || (E_type == 6'b001101);
    assign M_isPCplus8 = (M_type == 6'b001011) || (M_type == 6'b001101);

    assign D_RD1_from_E_PCplus8 = (E_isPCplus8 && E_A3 != 5'b00000 && D_Rs == E_A3 && D_t_rs_use != 4'hf && E_t_new != 4'hf && D_t_rs_use >= E_t_new) ? 1'b1 : 1'b0;
    assign D_RD2_from_E_PCplus8 = (E_isPCplus8 && E_A3 != 5'b00000 && D_Rt == E_A3 && D_t_rt_use != 4'hf && E_t_new != 4'hf && D_t_rt_use >= E_t_new) ? 1'b1 : 1'b0;
    
    assign D_RD1_from_M_PCplus8 = (M_isPCplus8 && M_A3 != 5'b00000 && D_Rs == M_A3 && D_t_rs_use != 4'hf && M_t_new != 4'hf && D_t_rs_use >= M_t_new) ? 1'b1 : 1'b0;
    assign D_RD2_from_M_PCplus8 = (M_isPCplus8 && M_A3 != 5'b00000 && D_Rt == M_A3 && D_t_rt_use != 4'hf && M_t_new != 4'hf && D_t_rt_use >= M_t_new) ? 1'b1 : 1'b0;
    assign E_RD1_from_M_PCplus8 = (M_isPCplus8 && M_A3 != 5'b00000 && E_Rs == M_A3 && E_t_rs_use != 4'hf && M_t_new != 4'hf && E_t_rs_use >= M_t_new) ? 1'b1 : 1'b0;
    assign E_RD2_from_M_PCplus8 = (M_isPCplus8 && M_A3 != 5'b00000 && E_Rt == M_A3 && E_t_rt_use != 4'hf && M_t_new != 4'hf && E_t_rt_use >= M_t_new) ? 1'b1 : 1'b0;
    
    assign D_RD1_from_M = (~M_isPCplus8 && M_A3 != 5'b00000 && D_Rs == M_A3 && D_t_rs_use != 4'hf && M_t_new != 4'hf && D_t_rs_use >= M_t_new) ? 1'b1 : 1'b0;
    assign D_RD2_from_M = (~M_isPCplus8 && M_A3 != 5'b00000 && D_Rt == M_A3 && D_t_rt_use != 4'hf && M_t_new != 4'hf && D_t_rt_use >= M_t_new) ? 1'b1 : 1'b0;
    assign E_RD1_from_M = (~M_isPCplus8 && M_A3 != 5'b00000 && E_Rs == M_A3 && E_t_rs_use != 4'hf && M_t_new != 4'hf && E_t_rs_use >= M_t_new) ? 1'b1 : 1'b0;
    assign E_RD2_from_M = (~M_isPCplus8 && M_A3 != 5'b00000 && E_Rt == M_A3 && E_t_rt_use != 4'hf && M_t_new != 4'hf && E_t_rt_use >= M_t_new) ? 1'b1 : 1'b0;
    
    assign D_RD1_from_W = (W_A3 != 5'b00000 && D_Rs == W_A3 && D_t_rs_use != 4'hf && W_t_new != 4'hf && D_t_rs_use >= W_t_new) ? 1'b1 : 1'b0;
    assign D_RD2_from_W = (W_A3 != 5'b00000 && D_Rt == W_A3 && D_t_rt_use != 4'hf && W_t_new != 4'hf && D_t_rt_use >= W_t_new) ? 1'b1 : 1'b0;
    assign E_RD1_from_W = (W_A3 != 5'b00000 && E_Rs == W_A3 && E_t_rs_use != 4'hf && W_t_new != 4'hf && E_t_rs_use >= W_t_new) ? 1'b1 : 1'b0;
    assign E_RD2_from_W = (W_A3 != 5'b00000 && E_Rt == W_A3 && E_t_rt_use != 4'hf && W_t_new != 4'hf && E_t_rt_use >= W_t_new) ? 1'b1 : 1'b0;
    assign M_RD2_from_W = (W_A3 != 5'b00000 && M_Rt == W_A3 && M_t_rt_use != 4'hf && W_t_new != 4'hf && M_t_rt_use >= W_t_new) ? 1'b1 : 1'b0;

//stall
    assign PC_en = (D_stall) ? 1'b0 : 1'b1;
    assign FD_en = (D_stall) ? 1'b0 : 1'b1;
    assign DE_en = 1'b1;
    assign EM_en = 1'b1;
    assign MW_en = 1'b1;

    assign FD_reset = 1'b0;
    assign DE_reset = (D_stall) ? 1'b1 : 1'b0;
    assign EM_reset = 1'b0;
    assign MW_reset = 1'b0;

    assign isMULTDIV = (D_type == 6'b010101 || D_type == 6'b010110 || D_type == 6'b010111 || D_type == 6'b011000 || D_type == 6'b011001 || D_type == 6'b011010 || D_type == 6'b011011 || D_type == 6'b011100) ? 1'b1 : 1'b0;

    assign D_stall = (E_A3 != 5'b00000 && D_Rs == E_A3 && D_t_rs_use != 4'hf && E_t_new != 4'hf && D_t_rs_use < E_t_new) ? 1'b1 :
                     (E_A3 != 5'b00000 && D_Rt == E_A3 && D_t_rt_use != 4'hf && E_t_new != 4'hf && D_t_rt_use < E_t_new) ? 1'b1 :
                     (M_A3 != 5'b00000 && D_Rs == M_A3 && D_t_rs_use != 4'hf && M_t_new != 4'hf && D_t_rs_use < M_t_new) ? 1'b1 :
                     (M_A3 != 5'b00000 && D_Rt == M_A3 && D_t_rt_use != 4'hf && M_t_new != 4'hf && D_t_rt_use < M_t_new) ? 1'b1 :
                     (W_A3 != 5'b00000 && D_Rs == W_A3 && D_t_rs_use != 4'hf && W_t_new != 4'hf && D_t_rs_use < W_t_new) ? 1'b1 :
                     (W_A3 != 5'b00000 && D_Rt == W_A3 && D_t_rt_use != 4'hf && W_t_new != 4'hf && D_t_rt_use < W_t_new) ? 1'b1 : 
                     (isMULTDIV && (E_start || E_busy)) ? 1'b1 : 1'b0;


endmodule