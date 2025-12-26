`timescale 1ns / 1ps
// Reg: SR (12), Cause (13), EPC (14), PRId (15)
// SR: 判断某种异常是否被允许发生 EXL(SR[1]) 总开关 1'b0表示允许 IE(SR[0]) 外部中断开关 1'b1表示允许 IM(SR[15:10]) 各种中断允许位 1'b1表示允许
// Cause: 存储陷入内核原因 BD(Cause[31]) 1'b1表示在延迟槽中发生 IP(Cause[15:10]) 各种中断请求位 1'b1表示请求 ExcCode(Cause[6:2]) 异常代码
// EPC: 异常发生时的返回地址
// PRId: 处理器标识
module CP0(
    input clk,
    input reset,
    
    input [4:0] ExcCode,
    input [31:0] VPC,
    input [5:0] HWInt,
    input BD,
    input EXLclr,
    output Req,
    output [31:0] EPCOut,

    input WE,
    input [4:0] addr,
    input [31:0] WD,
    output [31:0] data
);

    reg [31:0] SR;
    reg [31:0] Cause;
    reg [31:0] EPC;
    reg [31:0] PRId;

    `define SR_IE SR[0]
    `define SR_EXL SR[1]
    `define SR_IM SR[15:10]
    `define CAUSE_BD Cause[31]
    `define CAUSE_IP Cause[15:10]
    `define CAUSE_EXCCODE Cause[6:2]

    assign Req = ((`SR_IE && (`SR_IM & HWInt)) || ExcCode) && (~`SR_EXL);

    always @(posedge clk) begin
        if (reset) begin
            SR <= 32'h0;
            Cause <= 32'h0;
            EPC <= 32'h0;
            PRId <= 32'h0;
        end
        else begin
            if (WE & ~Req) begin
                if (addr == 5'b01100) begin
                    SR <= WD;
                end
                else if (addr == 5'b01110) begin
                    EPC <= WD;
                end
            end
            if (Req) begin
                `SR_EXL <= 1'b1;
                `CAUSE_BD <= BD;
                `CAUSE_EXCCODE <= (~`SR_EXL && `SR_IE && (`SR_IM & HWInt)) ? 5'b00000 : ExcCode;
                EPC <= BD ? (VPC - 32'h4) : VPC;
            end
            if (EXLclr) begin
                `SR_EXL <= 1'b0;
            end
            `CAUSE_IP <= HWInt;
        end
    end

    assign data = (addr == 5'b01100) ? SR :
                  (addr == 5'b01101) ? Cause :
                  (addr == 5'b01110) ? EPC :
                  (addr == 5'b01111) ? PRId : 32'h0;

    assign EPCOut = EPC;

endmodule
