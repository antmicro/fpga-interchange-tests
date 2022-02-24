`include "ram_36bit.v"

module top_diff (
    input wire clk_p,
    input wire clk_n,
    output wire [15:0] led,
    input wire [15:0] sw,
    output wire tx,
    input wire rx,
    input wire butu,
    input wire butd,
    input wire butl,
    input wire butr,
    input wire butc
);
    wire clk;
    IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));
    top top_ (
        .led(led),
        .sw(sw),
        .tx(tx),
        .rx(rx),
        .butu(butu),
        .butd(butd),
        .butl(butl),
        .butr(butr),
        .butc(butc),
        .clk(clk)
    );
endmodule

