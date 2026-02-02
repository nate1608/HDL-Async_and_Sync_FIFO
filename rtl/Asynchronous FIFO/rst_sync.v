`timescale 1ns/1ps

//to avoid reset violation / RDC due to de assertion in recovery time of clk

module reset_sync (
    input clk,
    input rst_in,       // The raw external reset (e.g. from button)
    output reg rst_out  // The safe, synchronized reset for your logic
);

    reg rst_meta;

    // Notice: We reset nicely if 'rst_in' goes high (Async Assert)
    always @(posedge clk or posedge rst_in) begin
        if (rst_in) begin
            rst_meta <= 1'b1;
            rst_out  <= 1'b1;
        end else begin
            // We release 'rst_out' purely based on the clock (Sync De-assert)
            rst_meta <= 1'b0;
            rst_out  <= rst_meta;
        end
    end
endmodule