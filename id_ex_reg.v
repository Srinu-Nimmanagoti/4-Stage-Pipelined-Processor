`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 20:48:32
// Design Name: 
// Module Name: id_ex_reg
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


module id_ex_reg(
    input wire clk,
    input wire reset,
    input wire [15:0] inst_in,
    input wire [15:0] data1_in,
    input wire [15:0] data2_in,
    input wire [15:0] imm_in,
    output reg [15:0] inst_out,
    output reg [15:0] data1_out,
    output reg [15:0] data2_out,
    output reg [15:0] imm_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            inst_out <= 16'h0000;
            data1_out <= 16'h0000;
            data2_out <= 16'h0000;
            imm_out <= 16'h0000;
        end else begin
            inst_out <= inst_in;
            data1_out <= data1_in;
            data2_out <= data2_in;
            imm_out <= imm_in;
        end
    end
endmodule