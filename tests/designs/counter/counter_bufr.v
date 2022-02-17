// Copyright (C) 2022  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`timescale 1 ns / 1 ps
`default_nettype none

module counter (
    input wire clk,
    input wire rst,
    output reg [(WIDTH-1):0] cnt
);
    parameter WIDTH = 32;

    always @(posedge clk) begin
        if (rst)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
endmodule

module bufr_test (
    input wire clk,
    input wire rst,
    output [7:4] led
);
    `include "utils.v"

    wire bufr_clk;
    wire [31:0] cnt_sim;
    wire [31:0] cnt_hw;

    wire out;

    bufr_mmcme #(.DIVISOR(16.0)) bufr1 (
        .clk(clk),
        .rst(rst),
        .out(bufr_clk)
    );

    counter #(.WIDTH(32)) counter_sim (clk, rst, cnt_sim);
    counter #(.WIDTH(32)) counter_hw (bufr_clk, rst, cnt_hw);

    always @(posedge clk) begin
        // Wait to compensate for BUFR delay
        #4
        // clk is 16x faster than bufr_clk
        assert((cnt_sim >> 4) == cnt_hw, out);
    end
endmodule
