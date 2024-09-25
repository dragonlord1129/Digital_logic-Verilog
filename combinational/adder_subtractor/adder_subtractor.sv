module adder_subtractor (
    input  logic a,
    b,
    c,
    output logic sum,
    carry,
    borrow
);
    assign sum = a ^ b ^ c;
    assign carry = (a & b) | (b & c) | (a & c);
    assign borrow = (~a & b) | (b & c) | (~a & c);
endmodule
