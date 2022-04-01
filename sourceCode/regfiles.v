`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 16:49:03
// Design Name: 
// Module Name: regfiles
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
module regfiles(
input regfile_ena,
input regfile_rst,
input regfile_clk,
input [4:0]rdc,
input [4:0]rsc,
input [4:0]rtc,
input [31:0]rd,
input regfile_write,
output [31:0]rs,
output [31:0]rt,
output [31:0]rf_out
    );
reg [31:0]array_reg[31:0];
assign rf_out = array_reg[28];
assign rs = regfile_ena?array_reg[rsc]:32'bz;
assign rt = regfile_ena?array_reg[rtc]:32'bz;

always@(posedge regfile_clk or posedge regfile_rst)begin
    if(regfile_rst & regfile_ena)begin
        array_reg[0]<=32'b0;
        array_reg[1]<=32'b0;
        array_reg[2]<=32'b0;
        array_reg[3]<=32'b0;
        array_reg[4]<=32'b0;
        array_reg[5]<=32'b0;
        array_reg[6]<=32'b0;
        array_reg[7]<=32'b0;
        array_reg[8]<=32'b0;
        array_reg[9]<=32'b0;
        array_reg[10]<=32'b0;
        array_reg[11]<=32'b0;
        array_reg[12]<=32'b0;
        array_reg[13]<=32'b0;
        array_reg[14]<=32'b0;
        array_reg[15]<=32'b0;
        array_reg[16]<=32'b0;
        array_reg[17]<=32'b0;
        array_reg[18]<=32'b0;
        array_reg[19]<=32'b0;
        array_reg[20]<=32'b0;
        array_reg[21]<=32'b0;
        array_reg[22]<=32'b0;
        array_reg[23]<=32'b0;
        array_reg[24]<=32'b0;
        array_reg[25]<=32'b0;
        array_reg[26]<=32'b0;
        array_reg[27]<=32'b0;
        array_reg[28]<=32'b0;
        array_reg[29]<=32'b0;
        array_reg[30]<=32'b0;
        array_reg[31]<=32'b0;
    end
    else begin
        if (regfile_write&&regfile_ena&&rdc!=5'b0)begin
        array_reg[rdc]<=rd;
        end
    end
end
endmodule

