// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top(input [4:0] i, output [2:0] o);

wire i0_wire, i1_wire, i2_wire, i3_wire, i4_wire;
wire o0_wire, o1_wire, o2_wire;
wire ff_wire;

IB ib_0(.I(i0_wire), .P(i[0]));
IB ib_1(.I(i1_wire), .P(i[1]));
IB ib_2(.I(i2_wire), .P(i[2]));
IB ib_3(.I(i3_wire), .P(i[3]));
IB ib_4(.I(i4_wire), .P(i[4]));

OB ob_0(.O(o0_wire), .P(o[0]));
OB ob_1(.O(o1_wire), .P(o[1]));
OB ob_2(.O(o2_wire), .P(o[2]));


assign o0_wire = i0_wire | i1_wire;
assign o1_wire = i2_wire | i3_wire;
assign ff_wire = i4_wire | i0_wire;

DFFR ff_0(.D(ff_wire), .C(i0_wire), .R(i0_wire), .Q(o2_wire));

endmodule
