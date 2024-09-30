module HA (
    input a, b,
    output cout, sum
);
    assign sum = a ^ b;
    assign cout = a & b;
endmodule

module FA (
    input a, b, cin,
    output sum, carry
);
    assign sum = a ^ b ^ cin;            
    assign carry = (a & b) | (a & cin) | (b & cin);  
endmodule

module CSA (
    input [7:0] A, B, C, D,
    output [7:0] sum,
    output [7:0] carry_out
);
    wire [7:0] carry_stage;  // Intermediate carry
    wire [7:0] sum_stage;    // Intermediate sum

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            FA fa1(
                .a(A[i]), 
                .b(B[i]), 
                .cin(C[i]), 
                .sum(sum_stage[i]), 
                .carry(carry_stage[i])
            );
            HA ha1(
                .a(sum_stage[i]), 
                .b(D[i]), 
                .sum(sum[i]), 
                .cout(carry_out[i])  // This may need to be adjusted based on carry propagation
            );
        end
    endgenerate
endmodule


module parallel_adder #(parameter N = 8) (
    input [N-1:0] A,
    input [N-1:0] B,
    output [N-1:0] sum,
    output cout
);
    wire [N-1:0] carry; // Internal carry wires

    // First bit addition using a half adder (LSB)
    HA HA0 (
        .a(A[0]), 
        .b(B[0]), 
        .sum(sum[0]), 
        .cout(carry[0])
    );

    genvar i;
    generate
        // Full adders for the remaining bits
        for (i = 1; i < N; i = i + 1) begin : adders
            FA FA (
                .a(A[i]), 
                .b(B[i]), 
                .cin(carry[i-1]), 
                .sum(sum[i]), 
                .carry(carry[i])
            );
        end
    endgenerate

    // Final carry out from the last full adder
    assign cout = carry[N-1];
endmodule

module multiplier (
    input [3:0] A, B,
    output [7:0] PRODUCT,
    output cout
);
    wire [7:0] partialProduct[3:0]; // 8-bit wide partial products
    wire [7:0] carry, sum;           // 8-bit wide carry and sum
    wire [7:0] result_sum;           // 8-bit result sum

    genvar i;
    generate
        // Generate partial products by ANDing A with each bit of B and shifting
        for (i = 0; i < 4; i = i + 1) begin
            assign partialProduct[i] = (A & {4{B[i]}}) << i; // Shifting A by i positions
        end
    endgenerate

    // Use the CSA for all bits of the partial products
    CSA csa(
        .A(partialProduct[0]), // 8 bits from the first partial product
        .B(partialProduct[1]),
        .C(partialProduct[2]),
        .D(partialProduct[3]), 
        .carry(carry), // Now passing 8 bits directly
        .sum(sum)      // Now passing 8 bits directly
    );


    // Use a parallel adder to sum the results from the CSA
    parallel_adder #(.N(8)) result (
        .A(sum), 
        .B(carry), 
        .sum(result_sum), 
        .cout(cout)
    ); 

    // Assign the final product
    assign PRODUCT = result_sum; // Final 8-bit product output
endmodule
