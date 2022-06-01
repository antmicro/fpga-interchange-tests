// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top(input [4:0] i, output o);

wire [3:0] ib;
wire i4_wire;
wire o0_wire;
wire ff_wire;

IB ib_0(.I(ib[0]), .P(i[0]));
IB ib_1(.I(ib[1]), .P(i[1]));
IB ib_2(.I(ib[2]), .P(i[2]));
IB ib_3(.I(ib[3]), .P(i[3]));
IB ib_4(.I(i4_wire), .P(i[4]));

ROM16X1S #(
    .INIT  (16'habcd),
) macro_cell (
    .ADDR  (ib),
    .R     (i4_wire),
    .D     (o0_wire)
);

OB ob_0(.O(o0_wire), .P(o));

//DFFR ff_0(.D(ff_wire), .C(i0_wire), .R(i0_wire), .Q(o2_wire));

endmodule
