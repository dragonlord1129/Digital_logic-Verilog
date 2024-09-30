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
    input [5:0] A, B, C, 
    output [5:0] sum,
    output [5:0] carry_out
);
    genvar i;
    generate
        for (i = 0; i < 6; i = i + 1) begin
            FA fa1(
                .a(A[i]), 
                .b(B[i]), 
                .cin(C[i]), 
                .sum(sum[i]), 
                .carry(carry_out[i])
            );
        end
    endgenerate
endmodule


module parallel_adder #(parameter N = 6) (
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
        for (i = 1; i < N; i = i + 1) begin 
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
    input [2:0] A, B,
    output [5:0] PRODUCT,
    output cout
);
    wire [5:0] partialProduct[2:0]; // 6-bit wide partial products
    wire [5:0] sum;                  // 6-bit wide sum
    wire [5:0] carry_temp;           // Temporary wire for carry from CSA
    reg [5:0] shifted_carry;         // Register for shifted carry

    genvar i;
    generate
        // Generate partial products by ANDing A with each bit of B and shifting
        for (i = 0; i < 3; i = i + 1) begin
            assign partialProduct[i] = (A & {3{B[i]}}) << i; // Generate partial products
        end
    endgenerate

    // Use the CSA for all bits of the partial products
    CSA csa(
        .A(partialProduct[0]),
        .B(partialProduct[1]),
        .C(partialProduct[2]),
        .carry_out(carry_temp), // Wire to capture the carry output
        .sum(sum)
    );

    // Shift the carry_temp left and assign LSB to 0
    always @(*) begin
        shifted_carry = carry_temp << 1; // Shift carry left
        shifted_carry[0] = 0;             // Set LSB of shifted_carry to 0
    end

    // Use a parallel adder to sum the results from the CSA
    parallel_adder #(.N(6)) result (
        .A(sum), 
        .B(shifted_carry), // Use the shifted carry instead of carry_temp
        .sum(PRODUCT),      // Directly assign PRODUCT to the result
        .cout(cout)
    ); 

endmodule
