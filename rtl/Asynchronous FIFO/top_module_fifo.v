`timescale 1ns / 1ps
module top_module_fifo#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3,
    parameter DEPTH = 1 << ADDR_WIDTH)(
    
    input clk_A, clk_B,
    input rst_A, rst_B,
    input wr_en, rd_en,
    input [DATA_WIDTH-1:0] wr_data,
    output [DATA_WIDTH-1:0] rd_data,
    output full, empty
    );
    
    wire [ADDR_WIDTH:0] wr_ptr, rd_ptr, g_rd_ptr, g_wr_ptr;
    wire sync_rst_A, sync_rst_B;
    
    reset_sync s_rst_A( clk_A, rst_A, sync_rst_A);
    reset_sync s_rst_B( clk_B, rst_B, sync_rst_B);
    
    async_fifo fifo( clk_A, clk_B,
                    full, empty,
                    sync_rst_A, sync_rst_B, //actice high
                    wr_en,
                    wr_data,
                    rd_en,
                    rd_data,
                    wr_ptr, rd_ptr );
                    
                    
    b2g gray_wr(wr_ptr, g_wr_ptr);
    b2g gray_rd(rd_ptr, g_rd_ptr);
    
    rd_ptr_logic rd_logic( rd_ptr,
                   g_wr_ptr,
                   clk_B, sync_rst_B,
                   empty );
                    
    wr_ptr_logic wr_logic( g_rd_ptr,
                   wr_ptr,
                   clk_A, sync_rst_B,
                   full );
    
    
endmodule
