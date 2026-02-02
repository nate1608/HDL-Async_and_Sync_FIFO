`timescale 1ns / 1ps

module wr_ptr_logic#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3,
    parameter DEPTH = 1 << ADDR_WIDTH)
    ( 
    input [ADDR_WIDTH:0] g_rd_ptr,
    input [ADDR_WIDTH:0] wr_ptr,
    input clk_A, rst,
    output full
    );
    
    wire en = 1'b1;
    wire [ADDR_WIDTH:0]sync_rd_ptr,  sync_b_rd_ptr;
    
    assign full = {~wr_ptr[ADDR_WIDTH], wr_ptr[ADDR_WIDTH-1: 0]} == sync_b_rd_ptr;
    
    ff_sync rd_sync( .en(en), .rst(rst), .clk_B(clk_A), .sig_A(g_rd_ptr), .sig_B(sync_rd_ptr));
    
    g2b bin_sync_rd( sync_rd_ptr, sync_b_rd_ptr);
    
endmodule
