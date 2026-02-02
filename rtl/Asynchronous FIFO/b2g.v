`timescale 1ns / 1ps

module b2g#(
    parameter SIZE = 4)(
    
    input [SIZE-1: 0] in,
    output [SIZE-1: 0] out
    );
    
    assign out = in ^ (in>>1);
    
endmodule
