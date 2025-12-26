`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:38:59 11/13/2025 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input [5:0] OpCode,
    input [5:0] Funct,
    output [5:0] type,
    output [1:0] nextPC_Sel,
    output RegWE,
    output ALUInput1,
    output ALUInput2,
    output ExtOp,
    output RegDst,
    output DMWE,
    output MemToReg,
    output PCToReg,
    output RegRa
    );

    parameter ADD   = 6'b000001,
              SUB   = 6'b000010,
              ADDIU = 6'b000011,
              XORI  = 6'b000100,
              LUI   = 6'b000101,
              LW    = 6'b000110,
              SW    = 6'b000111,
              BEQ   = 6'b001000,
              BNE   = 6'b001001,
              J     = 6'b001010,
              JAL   = 6'b001011,
              JR    = 6'b001100,
              JALR  = 6'b001101,
              ORI   = 6'b001110,
              SLL   = 6'b001111,
              SLLV  = 6'b010000;

    wire add;
    wire sub;
    wire addiu;
    wire xori;
    wire lui;
    wire lw;
    wire sw;
    wire beq;
    wire bne;
    wire j;
    wire jal;
    wire jr;
    wire jalr;
    wire ori;
    wire sll;
    wire sllv;

    assign add   = (OpCode == 6'h00 && Funct == 6'h20) ? 1'b1 : 1'b0;
    assign sub   = (OpCode == 6'h00 && Funct == 6'h22) ? 1'b1 : 1'b0;
    assign jr    = (OpCode == 6'h00 && Funct == 6'h08) ? 1'b1 : 1'b0;
    assign jalr  = (OpCode == 6'h00 && Funct == 6'h09) ? 1'b1 : 1'b0;
    assign sll   = (OpCode == 6'h00 && Funct == 6'h00) ? 1'b1 : 1'b0;
    assign sllv  = (OpCode == 6'h00 && Funct == 6'h04) ? 1'b1 : 1'b0;
    assign addiu = (OpCode == 6'h09) ? 1'b1 : 1'b0;
    assign xori  = (OpCode == 6'h0e) ? 1'b1 : 1'b0;
    assign lui   = (OpCode == 6'h0f) ? 1'b1 : 1'b0;
    assign lw    = (OpCode == 6'h23) ? 1'b1 : 1'b0;
    assign sw    = (OpCode == 6'h2b) ? 1'b1 : 1'b0;
    assign beq   = (OpCode == 6'h04) ? 1'b1 : 1'b0;
    assign bne   = (OpCode == 6'h05) ? 1'b1 : 1'b0;
    assign j     = (OpCode == 6'h02) ? 1'b1 : 1'b0;
    assign jal   = (OpCode == 6'h03) ? 1'b1 : 1'b0;
    assign ori   = (OpCode == 6'h0d) ? 1'b1 : 1'b0;

    assign nextPC_Sel = (jr | jalr) ? 2'b01 : 
                        (j | jal) ? 2'b10 :
                        (beq | bne) ? 2'b11 : 2'b00;

    assign RegWE = (add | sub | addiu | xori | lui | lw | jal | jalr | ori | sll | sllv) ? 1'b1 : 1'b0;

    assign ALUInput1 = (sll) ? 1'b1 : 1'b0;

    assign ALUInput2 = (addiu | xori | lui | lw | sw | ori) ? 1'b1 : 1'b0;

    assign ExtOp = (addiu | lw | sw) ? 1'b1 : 1'b0;

    assign RegDst = (addiu | xori | lui | lw | sw | beq | bne | j | jal |jr | ori) ? 1'b1 : 1'b0;

    assign DMWE = (sw) ? 1'b1 : 1'b0;

    assign MemToReg = (lw) ? 1'b1 : 1'b0;

    assign PCToReg = (jal | jalr) ? 1'b1 : 1'b0;

    assign RegRa = (jal) ? 1'b1 : 1'b0;

    assign type = (add) ? ADD :
                  (sub) ? SUB :
                  (addiu) ? ADDIU : 
                  (xori) ? XORI :
                  (lui) ? LUI :
                  (lw) ? LW :
                  (sw) ? SW :
                  (beq) ? BEQ :
                  (bne) ? BNE :
                  (j) ? J :
                  (jal) ? JAL :
                  (jr) ? JR :
                  (jalr) ? JALR :
                  (ori) ? ORI :
                  (sll) ? SLL:
                  (sllv) ? SLLV :
                  6'b111111;
endmodule
