`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:17:06 10/18/2025 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );

    reg [2:0] cnt;
    reg of;

    initial begin
        cnt = 0;
    end

    always @(posedge Clk ) begin
        if (Reset == 1'b1) begin
          cnt = 1'b0;
          of = 1'b0;
        end
        else begin
          if (En == 1'b1) begin
            case (cnt)
                3'b000: cnt <= 3'b001;
                3'b001: cnt <= 3'b011;
                3'b011: cnt <= 3'b010;
                3'b010: cnt <= 3'b110;
                3'b110: cnt <= 3'b111;
                3'b111: cnt <= 3'b101;
                3'b101: cnt <= 3'b100;
                default: begin
                    cnt <= 3'b000;
                    of <= 1'b1;
                end
                    
            endcase
          end
        end
    end

    assign Output = cnt;
    assign Overflow = of;


endmodule
