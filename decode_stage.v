`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 20:44:21
// Design Name: 
// Module Name: decode_stage
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


module decode_stage(
    input wire clk,
    input wire reset,
    input wire [15:0] inst_in,
    output wire [2:0] read_reg1,
    output wire [2:0] read_reg2,
    output wire [15:0] read_data1,
    output wire [15:0] read_data2,
    output wire [15:0] imm_out
);
    assign read_reg1 = inst_in[8:6]; // rs1
    assign read_reg2 = inst_in[5:3]; // rs2
    
    // Sign-extend immediate
    assign imm_out = { {10{inst_in[5]}}, inst_in[5:0] };
endmodule
