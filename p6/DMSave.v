`timescale 1ns / 1ps
module DMSave(
    input [31:0] addr,
    input [31:0] data,
    input [5:0] type,
    output [3:0] WE,
    output [31:0] fixed_data
    );

    parameter SW = 6'b000111,
              SH = 6'b010011,
              SB = 6'b010100;

    assign WE = (type == SH && addr[1] == 1'b0) ? 4'b0011 :
                (type == SH && addr[1] == 1'b1) ? 4'b1100 :
                (type == SB && addr[1:0] == 2'b00) ? 4'b0001 :
                (type == SB && addr[1:0] == 2'b01) ? 4'b0010 :
                (type == SB && addr[1:0] == 2'b10) ? 4'b0100 :
                (type == SB && addr[1:0] == 2'b11) ? 4'b1000 :
                (type == SW) ? 4'b1111 : 4'b0000;

    assign fixed_data = (type == SH && addr[1] == 1'b0) ? {16'b0, data[15:0]} :
                        (type == SH && addr[1] == 1'b1) ? {data[15:0], 16'b0} :
                        (type == SB && addr[1:0] == 2'b00) ? {24'b0, data[7:0]} :
                        (type == SB && addr[1:0] == 2'b01) ? {16'b0, data[7:0], 8'b0} :
                        (type == SB && addr[1:0] == 2'b10) ? {8'b0, data[7:0], 16'b0} :
                        (type == SB && addr[1:0] == 2'b11) ? {data[7:0], 24'b0} :
                        (type == SW) ? data : data;
endmodule