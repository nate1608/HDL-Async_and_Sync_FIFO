`timescale 1ns / 1ps

module flop(
    input en,
    input clk,
    input d,
    output reg q
    );
    
    always @(posedge clk)
        begin
            if(en)  q <= d;
        end
        
endmodule
