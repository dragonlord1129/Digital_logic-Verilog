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