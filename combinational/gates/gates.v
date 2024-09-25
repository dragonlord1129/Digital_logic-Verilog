module gates (
    input  logic [3:0] a,
    b,
    output logic [3:0] c1,
    c2,
    c3,
    c4
);
    assign c1 = a & b;
    assign c2 = ~(c1);
    assign c3 = a | b;
    assign c4 = ~(c3);
endmodule
