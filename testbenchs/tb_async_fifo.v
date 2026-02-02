`timescale 1ns / 1ps

module tb_async_fifo(

    );
    reg clk_A, clk_B, rst_A, rst_B, wr_en, rd_en;
    reg [7:0] wr_data;
    wire [7:0] rd_data;
    wire full, empty;
    wire [3:0] wr_ptr = afifo.wr_ptr, rd_ptr = afifo.rd_ptr;
    
     top_module_fifo afifo (clk_A, clk_B,
                         rst_A, rst_B,
                         wr_en, rd_en,
                         wr_data,
                         rd_data,
                         full, empty );
    initial
        begin
            clk_A = 1'b0; clk_B = 1'b0;
           
        end
        
    always #5 clk_A = ~clk_A;
    always #10 clk_B = ~clk_B;
    
    initial 
        begin
            rst_A = 1'b1; rst_B = 1'b1; #3 rst_A = 1'b0; rst_B= 1'b0;
            #60 wr_en = 1'b1; rd_en = 1'b0;
            #2 wr_data = 8'd1;
            #10 wr_data = 8'd2; //rd_en = 1'b1;
            #10 wr_data = 8'd3; 
            #10 wr_data = 8'd4;//rd_en = 1'b0;
            #10 wr_data = 8'd5;
            #10 wr_data = 8'd6;rd_en = 1'b1;
            #10 wr_data = 8'd7;
            #10 wr_data = 8'd8;//rd_en = 1'b0;
            #10 wr_data = 8'd9;//rd_en = 1'b1;
            #10 wr_data = 8'd10;
            
            #40 wr_en = 1'b0;
            //#10 rd_en = 1'b0;
        end
endmodule
