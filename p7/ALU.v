`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:21:19 11/13/2025 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] in1,
    input [31:0] in2,
    input [5:0] type,
    output [31:0] out,
    output [4:0] ExcCode
    );

    parameter ADD   = 6'b000001,
              SUB   = 6'b000010,
              ADDI = 6'b000011,
              XORI  = 6'b000100,
              LUI   = 6'b000101,
              LW    = 6'b000110,
              SW    = 6'b000111,
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
              AND   = 6'b011101,
              OR    = 6'b011110,
              SLT   = 6'b011111,
              SLTU  = 6'b100000,
              ANDI  = 6'b100001;

    wire [31:0] add;
    wire [31:0] sub;
    wire [31:0] xori;
    wire [31:0] lui;
    wire [31:0] ori;
    wire [31:0] sll;
    wire [31:0] andw;
    wire [31:0] slt;
    wire [31:0] sltu;

    wire [32:0] add_with_overflow;
    wire [32:0] sub_with_overflow;
    wire addOverflow;
    wire subOverflow;

    assign add = (in1 + in2);
    assign sub = (in1 - in2);
    assign xori = (in1 ^ in2);
    assign lui = (in2 << 5'h10);
    assign ori = (in1 | in2);
    assign sll = (in2 << in1[4:0]);
    assign andw = (in1 & in2);
    assign slt = ($signed(in1) < $signed(in2));
    assign sltu = (in1 < in2);

    assign add_with_overflow = {in1[31], in1} + {in2[31], in2};
    assign sub_with_overflow = {in1[31], in1} - {in2[31], in2};
    assign addOverflow = (add_with_overflow[32] != add_with_overflow[31]) ? 1'b1 : 1'b0;
    assign subOverflow = (sub_with_overflow[32] != sub_with_overflow[31]) ? 1'b1 : 1'b0;

    assign out = (type == ADD) ? add :
                 (type == SUB) ? sub :
                 (type == ADDI) ? add :
                 (type == XORI) ? xori :
                 (type == LUI) ? lui :
                 (type == LW) ? add :
                 (type == SW) ? add :
                 (type == ORI) ? ori :
                 (type == SLL) ? sll :
                 (type == SLLV) ? sll :
                 (type == LH) ? add :
                 (type == LB) ? add :
                 (type == SH) ? add :
                 (type == SB) ? add :
                 (type == AND) ? andw :
                 (type == OR) ? ori :
                 (type == SLT) ? slt :
                 (type == SLTU) ? sltu :
                 (type == ANDI) ? andw :
                 32'b0;

    assign ExcCode = (type == LW && add[1:0] != 2'b00) ? 5'd4 :
                     (type == SW && add[1:0] != 2'b00) ? 5'd5 :
                     (type == LH && add[0] != 1'b0) ? 5'd4 :
                     (type == SH && add[0] != 1'b0) ? 5'd5 :
                     (type == LW && !((add >= 32'h00000000 && add < 32'h00003000) || (add >= 32'h00007f00 && add < 32'h00007f0c) || (add >= 32'h00007f10 && add < 32'h00007f1c) || (add >= 32'h00007f20 && add < 32'h00007f24))) ? 5'd4 :
                     (type == SW && !((add >= 32'h00000000 && add < 32'h00003000) || (add >= 32'h00007f00 && add < 32'h00007f08) || (add >= 32'h00007f10 && add < 32'h00007f18) || (add >= 32'h00007f20 && add < 32'h00007f24))) ? 5'd5 :
                     ((type == LH || type == LB) && !((add >= 32'h00000000 && add < 32'h00003000) || (add >= 32'h00007f20 && add < 32'h00007f24))) ? 5'd4 :
                     ((type == SH || type == SB) && !((add >= 32'h00000000 && add < 32'h00003000) || (add >= 32'h00007f20 && add < 32'h00007f24))) ? 5'd5 :
                     ((type == LW || type == LH || type == LB) && addOverflow) ? 5'd4 :
                     ((type == SW || type == SH || type == SB) && addOverflow) ? 5'd5 :
                     ((type == ADD || type == ADDI) && addOverflow) ? 5'd12 :
                     (type == SUB && subOverflow) ? 5'd12 :
                     5'd0;

endmodule
