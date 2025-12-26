`timescale 1ns / 1ps
module mips(
    input clk,                    // 时钟信号
    input reset,                  // 同步复位信号
    input interrupt,              // 外部中断信号
    output [31:0] macroscopic_pc, // 宏观 PC

    output [31:0] i_inst_addr,    // IM 读取地址（取指 PC）
    input  [31:0] i_inst_rdata,   // IM 读取数据

    output [31:0] m_data_addr,    // DM 读写地址
    input  [31:0] m_data_rdata,   // DM 读取数据
    output [31:0] m_data_wdata,   // DM 待写入数据
    output [3 :0] m_data_byteen,  // DM 字节使能信号

    output [31:0] m_int_addr,     // 中断发生器待写入地址
    output [3 :0] m_int_byteen,   // 中断发生器字节使能信号

    output [31:0] m_inst_addr,    // M 级 PC

    output w_grf_we,              // GRF 写使能信号
    output [4 :0] w_grf_addr,     // GRF 待写入寄存器编号
    output [31:0] w_grf_wdata,    // GRF 待写入数据

    output [31:0] w_inst_addr     // W 级 PC
);

    wire [5:0] cpu_HWInt;

    wire [31:0] cpu_i_inst_rdata;
    wire [31:0] cpu_i_inst_addr;

    wire [31:0] cpu_m_data_rdata;
    wire [31:0] cpu_m_data_addr;
    wire [31:0] cpu_m_data_wdata;
    wire [3:0] cpu_m_data_byteen;

    wire [31:0] cpu_macroscopic_pc;

    wire [31:2] timer0_Addr;
    wire timer0_WE;
    wire [31:0] timer0_Din;
    wire [31:0] timer0_Dout;
    wire timer0_IRQ;

    wire [31:2] timer1_Addr;
    wire timer1_WE;
    wire [31:0] timer1_Din;
    wire [31:0] timer1_Dout;
    wire timer1_IRQ;

    cpu CPU(
        .clk(clk),
        .reset(reset),

        .HWInt(cpu_HWInt),

        .macroscopic_pc(macroscopic_pc),

        .i_inst_rdata(cpu_i_inst_rdata),
        .i_inst_addr(cpu_i_inst_addr),

        .w_grf_we(w_grf_we),
        .w_grf_addr(w_grf_addr),
        .w_grf_wdata(w_grf_wdata),
        .w_inst_addr(w_inst_addr),
        
        .m_data_addr(cpu_m_data_addr),
        .m_data_rdata(cpu_m_data_rdata),
        .m_data_wdata(cpu_m_data_wdata),
        .m_data_byteen(cpu_m_data_byteen),

        .m_inst_addr(m_inst_addr)
    );

    Bridge Bridge(
        .cpu_i_inst_addr(cpu_i_inst_addr),
        .cpu_i_inst_rdata(cpu_i_inst_rdata),

        .cpu_m_data_addr(cpu_m_data_addr),
        .cpu_m_data_wdata(cpu_m_data_wdata),
        .cpu_m_data_byteen(cpu_m_data_byteen),
        .cpu_m_data_rdata(cpu_m_data_rdata),

        .cpu_macroscopic_pc(cpu_macroscopic_pc),
        .cpu_HWInt(cpu_HWInt),

        .timer0_Dout(timer0_Dout),
        .timer0_IRQ(timer0_IRQ),
        .timer0_WE(timer0_WE),
        .timer0_Din(timer0_Din),
        .timer0_Addr(timer0_Addr),

        .timer1_Dout(timer1_Dout),
        .timer1_IRQ(timer1_IRQ),
        .timer1_WE(timer1_WE),
        .timer1_Din(timer1_Din),
        .timer1_Addr(timer1_Addr),

        .mips_i_inst_rdata(i_inst_rdata),
        .mips_i_inst_addr(i_inst_addr),

        .mips_interrupt(interrupt),
        .mips_macroscopic_pc(macroscopic_pc),

        .mips_m_int_addr(m_int_addr),
        .mips_m_int_byteen(m_int_byteen),

        .mips_m_data_rdata(m_data_rdata),
        .mips_m_data_addr(m_data_addr),
        .mips_m_data_wdata(m_data_wdata),
        .mips_m_data_byteen(m_data_byteen)
    );

    TC Timer0 (
        .clk(clk),
        .reset(reset),
        .Addr(timer0_Addr),
        .WE(timer0_WE),
        .Din(timer0_Din),
        .Dout(timer0_Dout),
        .IRQ(timer0_IRQ)
    );
    
    TC Timer1 (
        .clk(clk),
        .reset(reset),
        .Addr(timer1_Addr),
        .WE(timer1_WE),
        .Din(timer1_Din),
        .Dout(timer1_Dout),
        .IRQ(timer1_IRQ)
    );
endmodule