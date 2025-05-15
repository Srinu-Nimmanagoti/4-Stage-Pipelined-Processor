`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 20:52:05
// Design Name: 
// Module Name: write_back_stage
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

module write_back_stage(
    input wire clk,
    input wire reg_write_in,
    input wire [2:0] rd_in,
    input wire [15:0] result_in,
    output reg [2:0] write_reg,
    output reg [15:0] write_data,
    output reg reg_write_out
);
    always @(posedge clk) begin
        write_reg <= rd_in;
        write_data <= result_in;
        reg_write_out <= reg_write_in;
    end
endmodule
