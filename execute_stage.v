`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 20:45:13
// Design Name: 
// Module Name: execute_stage
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

module execute_stage(
    input wire [15:0] inst_in,
    input wire [15:0] data1_in,
    input wire [15:0] data2_in,
    input wire [15:0] imm_in,
    output reg [15:0] result_out,
    output reg [2:0] rd_out,
    output reg reg_write_out
);
    // Opcodes
    localparam ADD  = 4'b0000;
    localparam SUB  = 4'b0001;
    localparam LOAD = 4'b0010;
    
    always @(*) begin
        // Default outputs
        result_out = 16'h0000;
        rd_out = 3'b000;
        reg_write_out = 1'b0;
        
        // Instruction decode
        rd_out = inst_in[11:9]; // rd
        
        case (inst_in[15:12])
            ADD: begin
                result_out = data1_in + data2_in;
                reg_write_out = 1'b1;
            end
            SUB: begin
                result_out = data1_in - data2_in;
                reg_write_out = 1'b1;
            end
            LOAD: begin
                result_out = data1_in + imm_in;
                reg_write_out = 1'b1;
            end
            default: begin
                result_out = 16'h0000;
                reg_write_out = 1'b0;
            end
        endcase
    end
endmodule