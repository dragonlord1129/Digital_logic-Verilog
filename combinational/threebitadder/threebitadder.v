module threebitadder (
    input logic [2:0] a,
    b,
    c,
    output logic [2:0] result,
    output logic carry
);
    assign result[0] = a[0] ^ b[0] ^ c[0];
    assign result[1] = ((a[0] & b[0]) | (b[0] & c[0]) | (a[0] & c[0])) ^ a[1] ^ b[1] ^ c[1];
    assign result[2] = ((a[1] & b[1]) | (b[1] & c[1]) | (a[1] & c[1])) ^ a[2] ^ b[2] ^ c[2];
    assign carry = (a[2] & b[2]) | (b[2] & c[2]) | (a[2] & c[2]);
endmodule
