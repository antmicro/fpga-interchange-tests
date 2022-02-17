// Copyright (C) 2022  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module bufr_mmcme (
    // X1Y0 domain (W5 pin)
    input wire clk,
    input wire rst,
    output wire out
);
    parameter DIVISOR = 1.0;

    wire mmcm_clk0;
    wire locked;
    wire clk_fb;

    MMCME2_ADV #(
        .BANDWIDTH          ("HIGH"),
        .CLKIN1_PERIOD      (10.0),  // 100MHz
        .DIVCLK_DIVIDE      (1),
        .CLKFBOUT_MULT_F    (8.0),
        .CLKOUT0_DIVIDE_F   (DIVISOR)
    ) mmcm (
        .CLKIN1     (clk),
        .RST        (rst),
        .PWRDWN     (0),
        .LOCKED     (locked),
        .CLKFBIN    (clk_fb),
        .CLKFBOUT   (clk_fb),
        .CLKOUT0    (mmcm_clk0)
    );

    BUFR #(
        .BUFR_DIVIDE("BYPASS"),
        .SIM_DEVICE("7SERIES")
    ) BUFR_instance (
        .I     (mmcm_clk0),
        .O     (out),
        .CE    (1),
        .CLR   (0)
    );
endmodule

module bufr_divided (
    // X1Y0 domain (W5 pin)
    input wire clk,
    input wire rst,
    output wire out
);
    parameter DOUBLE_DIVISOR = 1;
    
    wire bufr_clk;
    reg cnt = 16'h0;

    BUFR #(
        .BUFR_DIVIDE   ("BYPASS"),
        .SIM_DEVICE    ("7SERIES")
    ) BUFR_instance (
        .I     (clk),
        .O     (bufr_clk),
        .CE    (1),
        .CLR   (0)
    );
    
    always @(posedge bufr_clk) begin
        // Yes, this is ugly reset that's not synchronized with clk.
        if (rst)
            cnt <= 16'h0;
        else begin
            if (cnt == DOUBLE_DIVISOR)
                cnt <= cnt + 16'h1;
            else
                cnt <= 16'h0;
        end
    end
    
    assign out = cnt < (DOUBLE_DIVISOR / 2);    
endmodule

module top (
    input clk,
    input rst,
    output [7:4] io_led
);
    //bufr_mmcme #(.DIVISOR(16.0)) bufr1 (clk, rst, io_led[7]);
    bufr_divided #(.DOUBLE_DIVISOR(8)) bufr1 (clk, rst, io_led[7]);
    assign io_led[6:4] = 3'b000;
endmodule