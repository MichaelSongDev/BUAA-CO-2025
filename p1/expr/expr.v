`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:31:50 10/19/2025 
// Design Name: 
// Module Name:    expr 
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
module expr(
    input clk,
    input clr,
    input [7:0] in,
    output reg out
    );

    reg [1:0] state = 0;
    reg [1:0] next_state;

    always @(posedge clk or posedge clr) begin
        if (clr) state <= 2'b0;
        else state <= next_state;
    end

    always @(state, in) begin
        case (state)
            2'b00:begin
              if (in >= "0" && in <= "9") next_state <= 2'b01;
              else next_state <= 2'b11;
            end 
            2'b01:begin
              if (in == "+" || in == "*") next_state <= 2'b10;
              else next_state <= 2'b11;
            end
            2'b10:begin
              if (in >= "0" && in <= "9") next_state <= 2'b01;
              else next_state <= 2'b11;
            end
            default: next_state <= 2'b11;
        endcase
        
    end

    always @(state) begin
        out = (state == 2'b01) ? 1 : 0;
    end

endmodule
