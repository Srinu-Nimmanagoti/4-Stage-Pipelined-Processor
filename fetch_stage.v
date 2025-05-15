`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 20:43:35
// Design Name: 
// Module Name: fetch_stage
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
module fetch_stage(
    input wire clk,
    input wire reset,
    output wire [15:0] pc_out,
    output wire [15:0] instruction_out
);
    reg [15:0] imem [0:255];
    reg [15:0] pc;
    
    initial begin
        // Initialize all memory locations to NOP (0x0000)
        for (integer i = 0; i < 256; i = i + 1)
            imem[i] = 16'h0000;
        
        // Load test program
        imem[0] = 16'h0210; // LOAD r1, 10
        imem[1] = 16'h0420; // LOAD r2, 20
        imem[2] = 16'h0C9A; // ADD r3, r1, r2
        imem[3] = 16'h1A91; // SUB r4, r2, r1
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 16'h0000;
        end else begin
            pc <= pc + 1;
        end
    end
    
    assign pc_out = pc;
    assign instruction_out = imem[pc];
endmodule
