`include "dram_1_32m.v"

module top_diff (
    input  wire clk_p,
    input  wire clk_n,

    input  wire rx,
    output wire tx,

    input  wire [15:0] sw,
    output wire [15:0] led
);
    wire clk;

    IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));
    top top_ (
        .clk   (clk),
        .rx    (rx),
        .tx    (tx),
        .sw    (sw),
        .led   (led)
    );
endmodule
