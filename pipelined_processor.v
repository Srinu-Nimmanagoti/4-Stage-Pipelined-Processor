`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 20:40:05
// Design Name: 
// Module Name: pipelined_processor
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

`timescale 1ns/1ps

module pipelined_processor(
    input wire clk,
    input wire reset
);
    // Program counter
    wire [15:0] pc;
    
    // Instruction memory interface
    wire [15:0] instruction;
    
    // Register file interfaces
    wire [2:0]  read_reg1, read_reg2, write_reg;
    wire [15:0] read_data1, read_data2, write_data;
    wire        reg_write;
    
    // Pipeline stage interfaces
    wire [15:0] if_id_inst, if_id_pc;
    wire [15:0] id_ex_inst, id_ex_data1, id_ex_data2, id_ex_imm;
    wire [15:0] ex_wb_result;
    wire [2:0]  ex_wb_rd;
    wire        ex_wb_reg_write;
    
    // Instantiate pipeline stages
    fetch_stage FETCH (
        .clk(clk),
        .reset(reset),
        .pc_out(pc),
        .instruction_out(instruction)
    );
    
    if_id_reg IF_ID (
        .clk(clk),
        .reset(reset),
        .inst_in(instruction),
        .pc_in(pc),
        .inst_out(if_id_inst),
        .pc_out(if_id_pc)
    );
    
    decode_stage DECODE (
        .clk(clk),
        .reset(reset),
        .inst_in(if_id_inst),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .imm_out(id_ex_imm)
    );
    
    id_ex_reg ID_EX (
        .clk(clk),
        .reset(reset),
        .inst_in(if_id_inst),
        .data1_in(read_data1),
        .data2_in(read_data2),
        .imm_in(id_ex_imm),
        .inst_out(id_ex_inst),
        .data1_out(id_ex_data1),
        .data2_out(id_ex_data2),
        .imm_out(id_ex_imm)
    );
    
    execute_stage EXECUTE (
        .inst_in(id_ex_inst),
        .data1_in(id_ex_data1),
        .data2_in(id_ex_data2),
        .imm_in(id_ex_imm),
        .result_out(ex_wb_result),
        .rd_out(ex_wb_rd),
        .reg_write_out(ex_wb_reg_write)
    );
    
    write_back_stage WRITEBACK (
        .clk(clk),
        .reg_write_in(ex_wb_reg_write),
        .rd_in(ex_wb_rd),
        .result_in(ex_wb_result),
        .write_reg(write_reg),
        .write_data(write_data),
        .reg_write_out(reg_write)
    );
    
    register_file REG_FILE (
        .clk(clk),
        .reset(reset),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
endmodule
