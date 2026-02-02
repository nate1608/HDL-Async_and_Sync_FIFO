`timescale 1ns/1ps

//Mathematically, the $i$-th bit of a Binary number is the XOR sum of all Gray bits
// from $MSB$ down to $i$. Verilog's bitwise operators can actually do this very elegantly:

module g2b #(parameter SIZE = 4) (
    input  [SIZE-1:0] in,
    output [SIZE-1:0] out
);
    genvar i;
    generate
        for (i = 0; i < SIZE; i = i + 1) begin : bit_logic
            // Binary bit i is the XOR reduction of Gray bits from SIZE-1 down to i
            assign out[i] = ^in[SIZE-1:i];
        end
    endgenerate
endmodule