`timescale 1ns / 1ps
module Bridge(
    input [31:0] cpu_i_inst_addr,
    output [31:0] cpu_i_inst_rdata,

    input [31:0] cpu_m_data_addr,
    input [31:0] cpu_m_data_wdata,
    input [3:0] cpu_m_data_byteen,
    output [31:0] cpu_m_data_rdata,

    input [31:0] cpu_macroscopic_pc,
    output [5:0] cpu_HWInt,

    input [31:0] timer0_Dout,
    input timer0_IRQ,
    output timer0_WE,
    output [31:0] timer0_Din,
    output [31:2] timer0_Addr,

    input [31:0] timer1_Dout,
    input timer1_IRQ,
    output timer1_WE,
    output [31:0] timer1_Din,
    output [31:2] timer1_Addr,

    input [31:0] mips_i_inst_rdata,
    output [31:0] mips_i_inst_addr,

    input mips_interrupt,
    output [31:0] mips_macroscopic_pc,

    output [31:0] mips_m_int_addr,
    output [3:0] mips_m_int_byteen,

    input  [31:0] mips_m_data_rdata,
    output [31:0] mips_m_data_addr,
    output [31:0] mips_m_data_wdata,
    output [3:0] mips_m_data_byteen
);

    wire DM;
    wire Timer0;
    wire Timer1;
    wire Interrupt;

    assign DM = (cpu_m_data_addr >= 32'h00000000 && cpu_m_data_addr < 32'h00003000) ? 1'b1 : 1'b0;
    assign Timer0 = (cpu_m_data_addr >= 32'h00007f00 && cpu_m_data_addr < 32'h00007f0c) ? 1'b1 : 1'b0;
    assign Timer1 = (cpu_m_data_addr >= 32'h00007f10 && cpu_m_data_addr < 32'h00007f1c) ? 1'b1 : 1'b0;
    assign Interrupt = (cpu_m_data_addr >= 32'h00007f20 && cpu_m_data_addr < 32'h00007f24) ? 1'b1 : 1'b0;

    assign cpu_HWInt = {3'b00, mips_interrupt, timer1_IRQ, timer0_IRQ};

    assign cpu_i_inst_rdata = mips_i_inst_rdata;
    assign mips_i_inst_addr = cpu_i_inst_addr;

    assign mips_macroscopic_pc = cpu_macroscopic_pc;

    assign mips_m_int_addr = cpu_m_data_addr;
    assign mips_m_int_byteen = (Interrupt) ? cpu_m_data_byteen : 4'b0000;

    assign mips_m_data_addr = cpu_m_data_addr;
    assign mips_m_data_byteen = (DM) ? cpu_m_data_byteen : 4'b0000;
    assign mips_m_data_wdata = cpu_m_data_wdata;

    assign timer0_Addr = cpu_m_data_addr[31:2];
    assign timer0_WE = (Timer0) ? (&cpu_m_data_byteen) : 1'b0;
    assign timer0_Din = cpu_m_data_wdata;

    assign timer1_Addr = cpu_m_data_addr[31:2];
    assign timer1_WE = (Timer1) ? (&cpu_m_data_byteen) : 1'b0;
    assign timer1_Din = cpu_m_data_wdata;

    assign cpu_m_data_rdata = (DM) ? mips_m_data_rdata : 
                              (Timer0) ? timer0_Dout :
                              (Timer1) ? timer1_Dout :
                              (Interrupt) ? 32'h0 : 32'h0;

endmodule