`timescale 1ns / 1ps
module MDU(
    input clk,
    input reset,
    input [31:0] in1,
    input [31:0] in2,
    input [5:0] type,
    input start,
    output [31:0] out,
    output busy
);

    reg [31:0] HI;
    reg [31:0] LO;
    reg [3:0] cnt;

    parameter MULT  = 6'b010101,
              MULTU = 6'b010110,
              DIV   = 6'b010111,
              DIVU  = 6'b011000,
              MFHI  = 6'b011001,
              MFLO  = 6'b011010,
              MTHI  = 6'b011011,
              MTLO  = 6'b011100;

    always @(posedge clk) begin
        if (reset) begin
            HI <= 32'h00000000;
            LO <= 32'h00000000;
            cnt <= 4'h0;
        end
        else begin
            if (type == MULT) begin
                {HI, LO} <= $signed(in1) * $signed(in2);
            end
            else if (type == MULTU) begin
                {HI, LO} <= in1 * in2;
            end
            else if (type == DIV) begin
                if (in2 != 32'h00000000) begin
                    HI <= $signed(in1) % $signed(in2);
                    LO <= $signed(in1) / $signed(in2);
                end
            end
            else if (type == DIVU) begin
                if (in2 != 32'h00000000) begin
                    HI <= in1 % in2;
                    LO <= in1 / in2;
                end
            end
            else if (type == MTHI) begin
                HI <= in1;
            end
            else if (type == MTLO) begin
                LO <= in1;
            end

            if (start == 1'b1) begin
                if (type == MULT | type == MULTU) begin
                    cnt <= 4'd5;
                end
                else if (type == DIV | type == DIVU) begin
                    cnt <= 4'd10;
                end
            end

            if (cnt != 4'b0) begin
                cnt <= cnt - 4'b0001;
            end
        end
    end

    assign out = (type == MFHI) ? HI : (type == MFLO) ? LO : 32'b0;
    assign busy = (cnt != 4'b0) ? 1'b1 : 1'b0;
endmodule