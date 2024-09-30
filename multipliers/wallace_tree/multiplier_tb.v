// `timescale 1ns / 1ps
module multiplier_tb;
    reg [2:0] A;  // 3-bit input A
    reg [2:0] B;  // 3-bit input B
    wire [5:0] PRODUCT; // 6-bit product output
    wire cout;    // Carry out

    // Instantiate the multiplier
    multiplier uut (
        .A(A),
        .B(B),
        .PRODUCT(PRODUCT),
        .cout(cout)
    );

    // Test cases
    initial begin
        // Monitor the output
        $monitor("Time: %0t | A: %d | B: %d | PRODUCT: %d | Cout: %b", $time, A, B, PRODUCT, cout);

        // Test different input combinations
        A = 3'b000; B = 3'b000; #10; // 0 * 0 = 0
        A = 3'b001; B = 3'b001; #10; // 1 * 1 = 1
        A = 3'b010; B = 3'b011; #10; // 2 * 3 = 6
        A = 3'b011; B = 3'b100; #10; // 3 * 4 = 12
        A = 3'b101; B = 3'b110; #10; // 5 * 6 = 30
        A = 3'b111; B = 3'b111; #10; // 7 * 7 = 49
        A = 3'b101; B = 3'b010; #10; // 5 * 2 = 10
        A = 3'b110; B = 3'b011; #10; // 6 * 3 = 18
        A = 3'b111; B = 3'b000; #10; // 7 * 0 = 0

        // End simulation
        $finish;
    end
    initial begin
        $dumpfile("multiplier.vcd");  // Specify the VCD file name
        $dumpvars(0, multiplier_tb);     // Dump all signals in this module and its sub-modules
    end
endmodule
