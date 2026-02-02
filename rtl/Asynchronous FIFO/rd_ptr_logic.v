`timescale 1ns / 1ps

module rd_ptr_logic#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3,
    parameter DEPTH = 1 << ADDR_WIDTH)
    ( 
    input [ADDR_WIDTH:0] rd_ptr,
    input [ADDR_WIDTH:0] g_wr_ptr,
    input clk_B, rst,
    output empty
    );
    
    wire en = 1'b1;
    wire [ADDR_WIDTH:0]sync_wr_ptr, sync_b_wr_ptr;
    
    assign empty = rd_ptr == sync_b_wr_ptr;
    
    ff_sync wr_sync( .en(en), .rst(rst), .clk_B(clk_B), .sig_A(g_wr_ptr), .sig_B(sync_wr_ptr));
    
    g2b bin_sync_wr( sync_wr_ptr, sync_b_wr_ptr);

endmodule
