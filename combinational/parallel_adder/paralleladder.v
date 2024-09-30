module full_adder (
    input a, 
    input b, 
    input cin, 
    output sum, 
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module half_adder (
    input a, 
    input b, 
    output sum, 
    output cout
);
    assign sum = a ^ b;
    assign cout = a & b;
endmodule

module parallel_adder #(parameter N = 6) (  // N defines the bit-width (default is 4)
    input [N-1:0] A,   // N-bit input A
    input [N-1:0] B,   // N-bit input B
    output [N-1:0] sum, // N-bit sum output
    output cout        // Final carry out
);
    wire [N-1:0] carry; // Internal carry wires

    // First bit addition using a half adder (LSB)
    half_adder HA0 (
        .a(A[0]), 
        .b(B[0]), 
        .sum(sum[0]), 
        .cout(carry[0])
    );

    genvar i;
    generate
        // Full adders for the remaining bits
        for (i = 1; i < N; i = i + 1) begin : adders
            full_adder FA (
                .a(A[i]), 
                .b(B[i]), 
                .cin(carry[i-1]), 
                .sum(sum[i]), 
                .cout(carry[i])
            );
        end
    endgenerate

    // Final carry out from the last full adder
    assign cout = carry[N-1];

endmodule
