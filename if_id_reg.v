`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 20:47:39
// Design Name: 
// Module Name: if_id_reg
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

module if_id_reg(
    input wire clk,
    input wire reset,
    input wire [15:0] inst_in,
    input wire [15:0] pc_in,
    output reg [15:0] inst_out,
    output reg [15:0] pc_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            inst_out <= 16'h0000;
            pc_out <= 16'h0000;
        end else begin
            inst_out <= inst_in;
            pc_out <= pc_in;
        end
    end
endmodule
