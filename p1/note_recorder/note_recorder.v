`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:18 10/21/2025 
// Design Name: 
// Module Name:    note_recorder 
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
module note_recorder(
    input clk,
    input reset,
    input [2:0] note_in,
    input [1:0] op,
    input [6:0] query,
    output reg [2:0] note_out,
    output reg [7:0] count
    );

    reg [383:0] rec;
    reg [7:0] cnt;
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            rec <= 384'b0;
            note_out <= 3'b0;
            count <= 8'b0;
            // cnt <= 8'b0;
        end
        else if (op == 2'b00) begin
            rec = rec >> 3;
            rec[383] = note_in[2];
            rec[382] = note_in[1];
            rec[381] = note_in[0];
        end
        else if (op == 2'b01) begin
            note_out[0] <= rec[query*3];
            note_out[1] <= rec[query*3+1];
            note_out[2] <= rec[query*3+2];
            count <= count;
        end
        else if(op == 2'b10) begin
            note_out <= note_out;
            count <= count;
        end
        else begin
            // cnt = 8'b0;
            count = 8'b0;
            for (i = 0; i < 384; i = i + 3) begin
                if (rec[i] == query[0] && rec[i+1] == query[1] && rec[i+2] == query[2]) begin
                    count = count + 1;
                end
            end
            // count <= cnt;
            note_out <= note_out;
        end
    end

    // always @(*) begin
    //     cnt = 8'b0;
    //     for (i = 0; i < 384; i = i + 3) begin
    //             if (rec[i] == query[0] && rec[i+1] == query[1] && rec[i+2] == query[2]) begin
    //                 cnt = cnt + 1;
    //             end
    //         end
    // end


endmodule
