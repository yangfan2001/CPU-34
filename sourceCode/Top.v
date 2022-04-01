`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/19 21:28:30
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
    input clk_in,
    input reset,
    input interupt,
    output [7:0]o_seg,
    output [7:0]o_sel
    /*
    output [31:0]inst,
    output [31:0]pc,
    output [31:0]o1,
    output [31:0]o2,
    output [31:0]o3,
    output [31:0]o4,
    output [31:0]o5,
    output [31:0]o6,
    output [31:0]o7
    */
    );

wire [31:0]dmem_rdata,res,dmem_wdata,rfOut,inst,pc;
wire [10:0]dmem_addr;
wire [31:0]imem_addr;
wire cpu_clk,clk;
wire dmem_read,dmem_write,dmem_ena;
assign dmem_addr = (res - 32'h10010000) / 4;
assign imem_addr = pc - 32'h0040_0000;

divider cpu_divider(
    .clk(clk_in),.rst(reset),.clk_out(cpu_clk)
);
imem imemory
(
    .addr(imem_addr[12:2]),
    .instr(inst)
);
cpu sccpu
(
    .clk(clk_in),
    .rst(reset),
    .interupt(interupt),
    .dmem_out(dmem_rdata),
    .imem_instr(inst),
    .dmem_read(dmem_read),
    .dmem_write(dmem_write),
    .pc(pc),
    .dmem_wdata(dmem_wdata),
    .dmem_waddr(res),
    .rfOut(rfOut),
    .o1(o1),
    .o2(o2),
    .o3(o3),
    .o4(o4),
    .o5(o5),
    .o6(o6),
    .o7(o7)
);
dmem dmemory
(
    .clk(clk_in),
    .ena(dmem_read|dmem_write),
    .dmem_write(dmem_write),
    .dmem_read(dmem_read),
    .dmem_addr(dmem_addr),
    .dmem_wdata(dmem_wdata),
    .dmem_rdata(dmem_rdata)
);

seg7x16 seg(
.clk(clk_in),
.reset(reset),
.cs(1'b1),
.i_data(pc),
.o_seg(o_seg),
.o_sel(o_sel)
);
endmodule
