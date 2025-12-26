`timescale 1ns / 1ps
module DMLoad(
    input [31:0] addr,
    input [31:0] data,
    input [5:0] type,
    output [31:0] fixed_data
    );

    parameter LW = 6'b000110,
              LH = 6'b010001,
              LB = 6'b010010;

    wire [15:0] half_word;
    wire [7:0] byte;

    assign half_word = (type == LH && addr[1] == 1'b0) ? data[15:0] :
                       (type == LH && addr[1] == 1'b1) ? data[31:16] :
                       16'b0;

    assign byte = (type == LB && addr[1:0] == 2'b00) ? data[7:0] :
                  (type == LB && addr[1:0] == 2'b01) ? data[15:8] :
                  (type == LB && addr[1:0] == 2'b10) ? data[23:16] :
                  (type == LB && addr[1:0] == 2'b11) ? data[31:24] :
                  8'b0;

    assign fixed_data = (type == LW) ? data :
                        (type == LH) ? {{16{half_word[15]}}, half_word} :
                        (type == LB) ? {{24{byte[7]}}, byte} :
                        data;
endmodule