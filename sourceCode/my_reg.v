`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/09 20:41:58
// Design Name: 
// Module Name: high
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
module my_reg(clk,rst,write,ena,data_in,data_out);

input clk,rst,ena,write;
input [31:0] data_in;
output [31:0]data_out;
reg [31:0]temp;

assign data_out = ena?temp:32'bz;
always@(posedge clk or posedge rst)//上升沿读写数据
begin
    if(rst==1)
        temp<=32'h0;
    else if(write)
        temp<=data_in;
end
endmodule