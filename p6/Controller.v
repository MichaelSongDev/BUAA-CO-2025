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
    output MemToReg,
    output PCToReg,
    output RegRa,
    output isMFHILO,
    output start,
    output [3:0] t_rs,
    output [3:0] t_rt,
    output [3:0] t
    );

    parameter ADD   = 6'b000001,
              SUB   = 6'b000010,
              ADDI  = 6'b000011,
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
              SLLV  = 6'b010000,
              LH    = 6'b010001,
              LB    = 6'b010010,
              SH    = 6'b010011,
              SB    = 6'b010100,
              MULT  = 6'b010101,
              MULTU = 6'b010110,
              DIV   = 6'b010111,
              DIVU  = 6'b011000,
              MFHI  = 6'b011001,
              MFLO  = 6'b011010,
              MTHI  = 6'b011011,
              MTLO  = 6'b011100,
              AND   = 6'b011101,
              OR    = 6'b011110,
              SLT   = 6'b011111,
              SLTU  = 6'b100000,
              ANDI  = 6'b100001;

    wire add;
    wire sub;
    wire addi;
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
    wire lh;
    wire lb;
    wire sh;
    wire sb;
    wire mult;
    wire multu;
    wire div;
    wire divu;
    wire mfhi;
    wire mflo;
    wire mthi;
    wire mtlo;
    wire andw;
    wire orw;
    wire slt;
    wire sltu;
    wire andi;

    assign add   = (OpCode == 6'h00 && Funct == 6'h20) ? 1'b1 : 1'b0;
    assign sub   = (OpCode == 6'h00 && Funct == 6'h22) ? 1'b1 : 1'b0;
    assign jr    = (OpCode == 6'h00 && Funct == 6'h08) ? 1'b1 : 1'b0;
    assign jalr  = (OpCode == 6'h00 && Funct == 6'h09) ? 1'b1 : 1'b0;
    assign sll   = (OpCode == 6'h00 && Funct == 6'h00) ? 1'b1 : 1'b0;
    assign sllv  = (OpCode == 6'h00 && Funct == 6'h04) ? 1'b1 : 1'b0;
    assign mult  = (OpCode == 6'h00 && Funct == 6'h18) ? 1'b1 : 1'b0;
    assign multu = (OpCode == 6'h00 && Funct == 6'h19) ? 1'b1 : 1'b0;
    assign div   = (OpCode == 6'h00 && Funct == 6'h1a) ? 1'b1 : 1'b0;
    assign divu  = (OpCode == 6'h00 && Funct == 6'h1b) ? 1'b1 : 1'b0;
    assign mfhi  = (OpCode == 6'h00 && Funct == 6'h10) ? 1'b1 : 1'b0;
    assign mflo  = (OpCode == 6'h00 && Funct == 6'h12) ? 1'b1 : 1'b0;
    assign mthi  = (OpCode == 6'h00 && Funct == 6'h11) ? 1'b1 : 1'b0;
    assign mtlo  = (OpCode == 6'h00 && Funct == 6'h13) ? 1'b1 : 1'b0;
    assign andw  = (OpCode == 6'h00 && Funct == 6'h24) ? 1'b1 : 1'b0;
    assign orw   = (OpCode == 6'h00 && Funct == 6'h25) ? 1'b1 : 1'b0;
    assign slt   = (OpCode == 6'h00 && Funct == 6'h2a) ? 1'b1 : 1'b0;
    assign sltu  = (OpCode == 6'h00 && Funct == 6'h2b) ? 1'b1 : 1'b0;
    assign addi = (OpCode == 6'h08) ? 1'b1 : 1'b0;
    assign xori  = (OpCode == 6'h0e) ? 1'b1 : 1'b0;
    assign lui   = (OpCode == 6'h0f) ? 1'b1 : 1'b0;
    assign lw    = (OpCode == 6'h23) ? 1'b1 : 1'b0;
    assign sw    = (OpCode == 6'h2b) ? 1'b1 : 1'b0;
    assign beq   = (OpCode == 6'h04) ? 1'b1 : 1'b0;
    assign bne   = (OpCode == 6'h05) ? 1'b1 : 1'b0;
    assign j     = (OpCode == 6'h02) ? 1'b1 : 1'b0;
    assign jal   = (OpCode == 6'h03) ? 1'b1 : 1'b0;
    assign ori   = (OpCode == 6'h0d) ? 1'b1 : 1'b0;
    assign lh    = (OpCode == 6'h21) ? 1'b1 : 1'b0;
    assign lb    = (OpCode == 6'h20) ? 1'b1 : 1'b0;
    assign sh    = (OpCode == 6'h29) ? 1'b1 : 1'b0;
    assign sb    = (OpCode == 6'h28) ? 1'b1 : 1'b0;
    assign andi  = (OpCode == 6'h0c) ? 1'b1 : 1'b0;


    assign nextPC_Sel = (jr | jalr) ? 2'b01 : 
                        (j | jal) ? 2'b10 :
                        (beq | bne) ? 2'b11 : 2'b00;

    assign RegWE = (add | sub | addi | xori | lui | lw | lh | lb | jal | jalr | ori | sll | sllv | mfhi | mflo | andw | orw | slt | sltu | andi) ? 1'b1 : 1'b0;

    assign ALUInput1 = (sll) ? 1'b1 : 1'b0;

    assign ALUInput2 = (addi | xori | lui | lw | sw | ori | lh | lb | sh | sb | andi) ? 1'b1 : 1'b0;

    assign ExtOp = (addi | lw | sw | lh | lb | sh | sb) ? 1'b1 : 1'b0;

    assign RegDst = (addi | xori | lui | lw | sw | beq | bne | j | jal | jr | ori | lh | lb | sh | sb | andi) ? 1'b1 : 1'b0;

    assign MemToReg = (lw | lh | lb) ? 1'b1 : 1'b0;

    assign PCToReg = (jal | jalr) ? 1'b1 : 1'b0;

    assign RegRa = (jal) ? 1'b1 : 1'b0;

    assign isMFHILO = (mfhi | mflo) ? 1'b1 : 1'b0;

    assign start = (mult | multu | div | divu) ? 1'b1 : 1'b0;

    assign type = (add) ? ADD :
                  (sub) ? SUB :
                  (addi) ? ADDI : 
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
                  (lh) ? LH :
                  (lb) ? LB :
                  (sh) ? SH :
                  (sb) ? SB :
                  (mult) ? MULT : 
                  (multu) ? MULTU :
                  (div) ? DIV :
                  (divu) ? DIVU :
                  (mfhi) ? MFHI :
                  (mflo) ? MFLO :
                  (mthi) ? MTHI :
                  (mtlo) ? MTLO :
                  (andw) ? AND :
                  (orw) ? OR :
                  (slt) ? SLT :
                  (sltu) ? SLTU :
                  (andi) ? ANDI :
                  6'b111111;

//使用rs寄存器的级次：D-0 E-1 M-2 W-3
    assign t_rs = (add) ? 4'h1 :
                  (sub) ? 4'h1 :
                  (addi) ? 4'h1 :
                  (xori) ? 4'h1 :
                  (lui) ? 4'hf :
                  (lw) ? 4'h1 :
                  (sw) ? 4'h1 :
                  (beq) ? 4'h0 :
                  (bne) ? 4'h0 :
                  (j) ? 4'hf :
                  (jal) ? 4'hf :
                  (jr) ? 4'h0 :
                  (jalr) ? 4'h0 :
                  (ori) ? 4'h1 :
                  (sll) ? 4'hf :
                  (sllv) ? 4'h1 :
                  (lh) ? 4'h1 :
                  (lb) ? 4'h1 :
                  (sh) ? 4'h1 :
                  (sb) ? 4'h1 :
                  (mult) ? 4'h1 :
                  (multu) ? 4'h1 :
                  (div) ? 4'h1 :
                  (divu) ? 4'h1 :
                  (mfhi) ? 4'hf :
                  (mflo) ? 4'hf :
                  (mthi) ? 4'h1 :
                  (mtlo) ? 4'h1 :
                  (andw) ? 4'h1 :
                  (orw) ? 4'h1 :
                  (slt) ? 4'h1 :
                  (sltu) ? 4'h1 :
                  (andi) ? 4'h1 :
                  4'hf;

//使用rt寄存器的级次：D-0 E-1 M-2 W-3
    assign t_rt = (add) ? 4'h1 :
                  (sub) ? 4'h1 :
                  (addi) ? 4'hf :
                  (xori) ? 4'hf :
                  (lui) ? 4'hf :
                  (lw) ? 4'hf :
                  (sw) ? 4'h2 :
                  (beq) ? 4'h0 :
                  (bne) ? 4'h0 :
                  (j) ? 4'hf :
                  (jal) ? 4'hf :
                  (jr) ? 4'hf :
                  (jalr) ? 4'hf :
                  (ori) ? 4'hf :
                  (sll) ? 4'h1 :
                  (sllv) ? 4'h1 :
                  (lh) ? 4'hf :
                  (lb) ? 4'hf :
                  (sh) ? 4'h2 :
                  (sb) ? 4'h2 :
                  (mult) ? 4'h1 :
                  (multu) ? 4'h1 :
                  (div) ? 4'h1 :
                  (divu) ? 4'h1 :
                  (mfhi) ? 4'hf :
                  (mflo) ? 4'hf :
                  (mthi) ? 4'hf :
                  (mtlo) ? 4'hf :
                  (andw) ? 4'h1 :
                  (orw) ? 4'h1 :
                  (slt) ? 4'h1 :
                  (sltu) ? 4'h1 :
                  (andi) ? 4'hf :
                  4'hf;

//产生存入寄存器的值(可以进行转发)的级次：D-0 E-1 M-2 W-3
    assign t = (add) ? 4'h2 :
               (sub) ? 4'h2 :
               (addi) ? 4'h2 :
               (xori) ? 4'h2 :
               (lui) ? 4'h2 :
               (lw) ? 4'h3 :
               (sw) ? 4'hf :
               (beq) ? 4'hf :
               (bne) ? 4'hf :
               (j) ? 4'hf :
               (jal) ? 4'h0 :
               (jr) ? 4'hf :
               (jalr) ? 4'h0 :
               (ori) ? 4'h2 :
               (sll) ? 4'h2 :
               (sllv) ? 4'h2 :
               (lh) ? 4'h3 :
               (lb) ? 4'h3 :
               (sh) ? 4'hf :
               (sb) ? 4'hf :
               (mult) ? 4'hf :
               (multu) ? 4'hf :
               (div) ? 4'hf :
               (divu) ? 4'hf :
               (mfhi) ? 4'h2 :
               (mflo) ? 4'h2 :
               (mthi) ? 4'hf :
               (mtlo) ? 4'hf :
               (andw) ? 4'h2 :
               (orw) ? 4'h2 :
               (slt) ? 4'h2 :
               (sltu) ? 4'h2 :
               (andi) ? 4'h2 :
               4'hf;


endmodule
