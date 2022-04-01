`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/23 18:46:16
// Design Name: 
// Module Name: divider
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
module divider(clk,rst,clk_out);
input clk,rst;
output reg clk_out=0;
parameter width=5;//
integer count=0;
always@(posedge clk)
begin
if(rst==1)
begin
clk_out<=0;
count=0;
end
if(count<width/2-1)
count=count+1;
else
begin
count=0;
clk_out=~clk_out;
end
end
endmodule
