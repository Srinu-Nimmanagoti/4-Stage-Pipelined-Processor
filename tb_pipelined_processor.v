`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 20:50:07
// Design Name: 
// Module Name: tb_pipelined_processor
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

module tb_processor;
    reg clk;
    reg reset;
    
    // Instantiate the processor
    pipelined_processor uut (
        .clk(clk),
        .reset(reset)
    );
    
    // Debug probes
    wire [15:0] pc_value = uut.FETCH.pc;
    wire [15:0] if_instr = uut.instruction;
    wire [15:0] id_instr = uut.if_id_inst;
    wire [15:0] ex_result = uut.ex_wb_result;
    wire [15:0] wb_data = uut.write_data;
    wire [2:0] wb_reg = uut.write_reg;
    wire wb_en = uut.reg_write;
    
    // Clock generation (100MHz)
    always #5 clk = ~clk;
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        
        // Create waveform dump
        $dumpfile("processor.vcd");
        $dumpvars(0, tb_processor);  // Dump all signals
        
        $display("Starting simulation at %0t", $time);
        
        // Apply reset for 20ns (2 clock cycles)
        #20 reset = 0;
        $display("Reset released at %0t", $time);
        
        // Monitor pipeline progress
        forever begin
            @(posedge clk);
            $display("[%0t] PC=%h IF=%h ID=%h EX_RES=%h WB_REG=%h WB_DATA=%h WB_EN=%b",
                     $time, pc_value, if_instr, id_instr, ex_result,
                     wb_reg, wb_data, wb_en);
        end
    end
    
    // Stop simulation after reasonable time
    initial begin
        #500;  // 500ns should be plenty
        $display("\nFinal Register State:");
        $display("r1 = %d", uut.REG_FILE.regs[1]);
        $display("r2 = %d", uut.REG_FILE.regs[2]);
        $display("r3 = %d", uut.REG_FILE.regs[3]);
        $display("r4 = %d", uut.REG_FILE.regs[4]);
        
        if (uut.REG_FILE.regs[1] == 10 &&
            uut.REG_FILE.regs[2] == 20 &&
            uut.REG_FILE.regs[3] == 30 &&
            uut.REG_FILE.regs[4] == 10) begin
            $display("TEST PASSED!");
        end else begin
            $display("TEST FAILED!");
        end
        
        $finish;
    end
endmodule