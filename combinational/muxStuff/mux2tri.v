module tristate(
    input logic [3:0] a,
    input logic en,

    output tri [3:0] y
);
assign y = en ? a : 4'bz;

endmodule

module mux2tri (
    input logic [3:0] d0, d1,
    input logic s,

    output tri [3:0] y   
);

tristate t0(.a(d0), .en(~s), .y(y));
tristate t1(.a(d1), .en(s), .y(y));

endmodule