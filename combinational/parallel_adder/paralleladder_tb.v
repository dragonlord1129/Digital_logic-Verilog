module paralleladder_tb;
    reg [5:0] A, B;       // 8-bit inputs
    wire [5:0] sum;       // 8-bit sum
    wire cout;            // Carry out

    // Instantiate the parameterized parallel adder for N = 8
    parallel_adder #(6) adder (
        .A(A), 
        .B(B), 
        .sum(sum), 
        .cout(cout)
    );

    initial begin
        // Test case
        A = 6'b010101;
        B = 6'b001110;

        #10;  // Wait for 10 time units

        $display("A = %b, B = %b, Sum = %d, Cout = %b", A, B, sum, cout);
    end
endmodule
