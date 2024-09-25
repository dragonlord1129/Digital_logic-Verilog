module mux2 (
    input logic [4:0] d0,
    d1,
    input logic s,
    output wire [4:0] y
);
    // Assign the output based on the select signal
    assign y = s ? d1 : d0;
endmodule

module mux4n (
    input  logic [4:0] d0,
    d1,
    d2,
    d3,
    input  logic [1:0] s,
    output wire  [4:0] out
);
    wire [4:0] low, high;

    mux2 a (
        .d0(d0),
        .d1(d1),
        .s (s[0]),
        .y (low)
    );
    mux2 b (
        .d0(d2),
        .d1(d3),
        .s (s[0]),
        .y (high)
    );
    mux2 c (
        .d0(low),
        .d1(high),
        .s (s[1]),
        .y (out)
    );
endmodule
