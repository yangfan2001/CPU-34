`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/19 23:48:23
// Design Name: 
// Module Name: mux3
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


module mux3(
    input  [31:0] InputData1,
    input  [31:0] InputData2,
    input  [31:0] InputData3,
    input  [2:0] Sel,
    output reg [31:0] OutputData
    );
always @(*) begin
    case (Sel)
        3'b001: OutputData = InputData1;
        3'b010: OutputData = InputData2;
        3'b100: OutputData = InputData3;
        default: OutputData=32'bz;
    endcase
end
endmodule