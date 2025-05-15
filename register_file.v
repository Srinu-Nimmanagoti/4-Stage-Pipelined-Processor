`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 20:46:18
// Design Name: 
// Module Name: register_file
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


module register_file(
    input wire clk,
    input wire reset,
    input wire [2:0] read_reg1,
    input wire [2:0] read_reg2,
    input wire [2:0] write_reg,
    input wire [15:0] write_data,
    input wire reg_write,
    output wire [15:0] read_data1,
    output wire [15:0] read_data2
);
    reg [15:0] regs [0:7];
    
    // Initialize all registers to 0 on reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (integer i = 0; i < 8; i = i + 1)
                regs[i] <= 16'h0000;
        end else if (reg_write) begin
            regs[write_reg] <= write_data;
        end
    end
    
    // Read ports (asynchronous)
    assign read_data1 = regs[read_reg1];
    assign read_data2 = regs[read_reg2];
endmodule
