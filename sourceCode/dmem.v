`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 16:48:29
// Design Name: 
// Module Name: dmem
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

module dmem(
    input clk,
    input ena,
    input dmem_write,
    input dmem_read,
    input [10:0] dmem_addr,
    input [31:0] dmem_wdata,
    output [31:0] dmem_rdata
    );

    reg [31:0] d_mem[0:1023];
    always @(posedge clk) begin
        if (dmem_write && ena) begin
                d_mem[dmem_addr] <= dmem_wdata;
        end
    end

    assign dmem_rdata = (dmem_read && ena) ? d_mem[dmem_addr] : 32'bz;
endmodule
