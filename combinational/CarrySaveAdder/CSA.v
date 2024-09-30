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
