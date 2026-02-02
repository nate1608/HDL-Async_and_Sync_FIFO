`timescale 1ns / 1ps

module tb_sync_fifo(

    );
    reg clk, rst, wr_en, rd_en;
    reg [7:0] wr_data;
    wire [7:0] rd_data;
    wire full, empty;
    wire [3:0] wr_ptr, rd_ptr;
    
    sync_fifo fo(.clk(clk), .rst_n(rst), .wr_data(wr_data), .rd_data(rd_data), .full(full),
                    .empty(empty), .wr_ptr(wr_ptr), .rd_ptr(rd_ptr), .wr_en(wr_en), .rd_en(rd_en) );
                    
    initial
        begin
            clk = 1'b0; 
            rst = 1'b0; #3 rst = 1'b1;
        end
        
    always #5 clk = ~clk;
    
    initial 
        begin
            wr_en = 1'b1; rd_en = 1'b0;
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
            //#10 rd_en = 1'b0;
        end
endmodule
