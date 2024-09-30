module paralleladder_tb;
    reg [7:0] A, B;       // 8-bit inputs
    wire [7:0] sum;       // 8-bit sum
    wire cout;            // Carry out

    // Instantiate the parameterized parallel adder for N = 8
    parallel_adder #(8) adder (
        .A(A), 
        .B(B), 
        .sum(sum), 
        .cout(cout)
    );

    initial begin
        // Test case
        A = 8'b01010101;
        B = 8'b00101000;

        #10;  // Wait for 10 time units

        $display("A = %b, B = %b, Sum = %d, Cout = %b", A, B, sum, cout);
    end
endmodule
