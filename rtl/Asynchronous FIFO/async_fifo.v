`timescale 1ns / 1ps

module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3,
    parameter DEPTH = 1 << ADDR_WIDTH)(
    input clk_A, clk_B,
    input full, empty,
    input rst_A, rst_B, //actice high
    input wr_en,
    input [DATA_WIDTH-1:0] wr_data,
    input rd_en,
    output reg [DATA_WIDTH - 1:0] rd_data,
    output reg [ADDR_WIDTH:0] wr_ptr, rd_ptr // +1 ADDR BIT FOR FULL AND EMPTY DIFFERENCE
    );
    
    
    reg [DATA_WIDTH-1:0] fifo [DEPTH -1 :0];
    
    wire act_wr_en, act_rd_en;
    assign act_wr_en = wr_en && ~full;
    assign act_rd_en = rd_en && ~empty;
    
    
    always @(posedge clk_A or posedge rst_A)
        if(rst_A)
                begin
                    wr_ptr <= 4'b0; 
                end
        else if(act_wr_en)
            begin
                fifo[wr_ptr[ADDR_WIDTH-1:0]] <= wr_data;
                wr_ptr <= 1'b1 + wr_ptr;
            end
           
    always @(posedge clk_B or posedge rst_B)
        if(rst_B)
                begin
                    rd_ptr <= 4'b0;
                    rd_data <= 8'b0;
                end
        else if(act_rd_en)
            begin
                rd_data <=  fifo[rd_ptr[ADDR_WIDTH-1:0]];
                rd_ptr <= 1'b1 + rd_ptr;
            end
            
    
endmodule
