`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/19 22:01:24
// Design Name: 
// Module Name: mux4
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


module mux4(
    input  [31:0] InputData1,
    input  [31:0] InputData2,
    input  [31:0] InputData3,
    input  [31:0] InputData4,
    input  [3:0] Sel,
    output reg [31:0] OutputData
    );
always @(*) begin
    case (Sel)
        4'b0001: OutputData = InputData1;
        4'b0010: OutputData = InputData2;
        4'b0100: OutputData = InputData3;
        4'b1000: OutputData = InputData4;
        default: OutputData=32'bz;
    endcase
end
endmodule
