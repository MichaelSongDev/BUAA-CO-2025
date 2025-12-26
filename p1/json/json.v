`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:56:10 10/26/2025 
// Design Name: 
// Module Name:    json 
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
module json(
    input clk,
    input reset,
    input [7:0] char,
    output reg [7:0] cur_num,
    output reg [7:0] max_num
);

    localparam [3:0] 
        START       = 4'd0,
        OBJECT      = 4'd1,
        KEY         = 4'd2,
        BETWEEN     = 4'd3,
        VALUE       = 4'd4,
        PAUSE       = 4'd5,
        UPDATE      = 4'd6,
        INVALID     = 4'd7;

    reg [3:0] current_state, next_state;
    
    reg [7:0] pair_count;      
    reg key_empty;             
    reg value_empty;           
    reg object_valid;          
    reg [7:0] next_cur_num;    
    reg [7:0] next_max_num;    
    
    localparam [7:0] 
        CHAR_LBRACE  = 8'h7B,  // {
        CHAR_RBRACE  = 8'h7D,  // }
        CHAR_QUOTE   = 8'h22,  // "
        CHAR_COLON   = 8'h3A,  // :
        CHAR_COMMA   = 8'h2C;  // ,

    always @(*) begin
        case (current_state)
            START: begin
                if (char == CHAR_LBRACE)
                    next_state = OBJECT;
                else
                    next_state = START;
            end
            
            OBJECT: begin
                if (char == CHAR_QUOTE)
                    next_state = KEY;
                else if (char == CHAR_RBRACE)
                    next_state = UPDATE;
                else
                    next_state = INVALID;
            end
            
            KEY: begin
                if (char == CHAR_QUOTE)
                    next_state = BETWEEN;
                else if ((char >= 8'h30 && char <= 8'h39) ||  
                         (char >= 8'h41 && char <= 8'h5A) ||  
                         (char >= 8'h61 && char <= 8'h7A))    
                    next_state = KEY;
                else
                    next_state = INVALID;
            end
            
            BETWEEN: begin
                if (char == CHAR_COLON)
                    next_state = VALUE;
                else
                    next_state = INVALID;
            end
            
            VALUE: begin
                if (char == CHAR_QUOTE)
                    next_state = PAUSE;
                else if ((char >= 8'h30 && char <= 8'h39) ||  
                         (char >= 8'h41 && char <= 8'h5A) ||  
                         (char >= 8'h61 && char <= 8'h7A))    
                    next_state = VALUE;
                else
                    next_state = INVALID;
            end
            
            PAUSE: begin
                if (char == CHAR_COMMA)
                    next_state = OBJECT;
                else if (char == CHAR_RBRACE)
                    next_state = UPDATE;
                else
                    next_state = INVALID;
            end
            
            UPDATE: begin
                next_state = START;
            end
            
            INVALID: begin
                if (char == CHAR_RBRACE)
                    next_state = UPDATE;
                else
                    next_state = INVALID;
            end
            
            default: next_state = START;
        endcase
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= START;
            pair_count <= 8'd0;
            key_empty <= 1'b1;
            value_empty <= 1'b1;
            object_valid <= 1'b1;
            cur_num <= 8'd0;
            max_num <= 8'd0;
        end else begin
            current_state <= next_state;
            
            case (next_state)
                START: begin
                    pair_count <= 8'd0;
                    key_empty <= 1'b1;
                    value_empty <= 1'b1;
                    object_valid <= 1'b1;
                end
                
                OBJECT: begin
                    if (current_state == START) begin
                        pair_count <= 8'd0;
                        object_valid <= 1'b1;
                    end
                    key_empty <= 1'b1;
                end
                
                KEY: begin
                    if ((char >= 8'h30 && char <= 8'h39) ||  
                        (char >= 8'h41 && char <= 8'h5A) ||  
                        (char >= 8'h61 && char <= 8'h7A))    
                        key_empty <= 1'b0;
                end
                
                BETWEEN: begin
                    if (key_empty)
                        object_valid <= 1'b0;
                    value_empty <= 1'b1;
                end
                
                VALUE: begin
                    if ((char >= 8'h30 && char <= 8'h39) ||  
                        (char >= 8'h41 && char <= 8'h5A) ||  
                        (char >= 8'h61 && char <= 8'h7A))    
                        value_empty <= 1'b0;
                end
                
                PAUSE: begin
                    if (value_empty)
                        object_valid <= 1'b0;
                    if (object_valid && !key_empty && !value_empty) begin
                        if (pair_count < 8'd255)
                            pair_count <= pair_count + 8'd1;
                        else
                            object_valid <= 1'b0; 
                    end
                end
                
                UPDATE: begin
                    if (object_valid) begin
                        cur_num <= pair_count;
                        if (pair_count > max_num)
                            max_num <= pair_count;
                    end else begin
                        cur_num <= 8'd0;
                    end
                end
                
                INVALID: begin
                    object_valid <= 1'b0;
                end
            endcase
        end
    end

endmodule