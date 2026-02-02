`timescale 1ns / 1ps

module ff_sync#(
    SIG_WIDTH = 4)(
    input en, rst,
    input clk_B,
    input [SIG_WIDTH-1: 0] sig_A,
    output reg [SIG_WIDTH-1: 0] sig_B
    );
    
    reg [SIG_WIDTH-1: 0]q1;
    
//    flop f1( .en(en), .clk(clk_B), .d(sig_A), .q(q1));
//    flop f2( .en(en), .clk(clk_B), .d(q1), .q(sig_B));
    always @(posedge clk_B or posedge rst)
        begin
            if(rst)
                begin
                    q1 <= 4'b0;
                    sig_B <= 4'b0;
                end
            else if(en)
                begin
                    q1 <= sig_A;
                    sig_B <= q1;
                end
        end
endmodule
