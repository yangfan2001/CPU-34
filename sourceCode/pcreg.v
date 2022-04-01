`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/18 16:39:34
// Design Name: 
// Module Name: pcreg
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


module pcreg(clk,rst,ena,data_in,data_out);

input clk,rst,ena;
input [31:0] data_in;
output reg [31:0]data_out;

always@(posedge clk or posedge rst)//上升沿读写数据
begin
    if(rst==1)
        data_out<=32'h0040_0000;
    else if(ena==1)
        data_out<=data_in;
    else
        data_out<=data_out;
end
endmodule

