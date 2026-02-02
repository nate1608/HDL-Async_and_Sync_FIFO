`timescale 1ns / 1ps

module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3
    )(
    input clk,
    input rst_n, //active low
    input wr_en,
    input [DATA_WIDTH-1:0] wr_data,
    input rd_en,
    output reg [DATA_WIDTH - 1:0] rd_data,
    output reg [ADDR_WIDTH:0] wr_ptr, rd_ptr, // +1 ADDR BIT FOR FULL AND EMPTY DIFFERENCE
    output full, empty
    );
    
    wire act_rd_en, act_wr_en;
    reg [7:0] fifo [7:0];
    
    assign full = ({~wr_ptr[3], wr_ptr[2:0]} == rd_ptr);
    assign empty = (wr_ptr == rd_ptr);
    
//    assign rd_data = rd_en?fifo[rd_ptr]: rd_data;
//    assign fifo[wr_ptr] = wr_en? wr_data : fifo[wr_ptr];
    assign act_wr_en = wr_en && ~full;
    assign act_rd_en = rd_en && ~empty;
    always @(posedge clk or negedge rst_n)
        begin
            
            if(!rst_n)
                begin
                    wr_ptr <=4'b0; rd_ptr <= 4'b0;
                end
            else begin
                if (act_wr_en)
                    begin
                        fifo[wr_ptr[2:0]] <= wr_data;
                        wr_ptr <= 1'b1 + wr_ptr;
                    end
                
                if (act_rd_en)
                    begin
                        rd_data <= fifo[rd_ptr[2:0]];
                        rd_ptr <= 1'b1 + rd_ptr;
                    end
                  end
        end
endmodule
