module booth_multiplier_tb;

    // Parameter for bit width
    parameter N = 4;            // Set N-bit width for multiplicand and multiplier
    parameter WIDTH = 2 * N;    // WIDTH for the product

    // Testbench signals
    reg signed [N-1:0] multiplicand, multiplier; // Ensure inputs are signed
    wire signed [WIDTH-1:0] product;
    wire signed [WIDTH-1:0] expected_product;    // Intermediate wire for expected product

    // Instantiate the booth_multiplier module
    booth_multiplier #(N) uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );

    // Continuous assignment for expected product
    assign expected_product = multiplicand * multiplier;

    // Testbench logic
    initial begin
        // Monitor signals to display the results
        $monitor("Time = %0t, Multiplicand = %0d, Multiplier = %0d, Product = %0d (Expected = %0d)", 
                 $time, multiplicand, multiplier, product, expected_product);

        // Test case 1: 2 * 3
        multiplicand = 4'b0010;  // 2
        multiplier = 4'b0011;    // 3
        #10;  // Wait for some time

        // Test case 2: -2 * 3
        multiplicand = 4'b1110; // -2 (two's complement for 4 bits)
        multiplier = 4'b0011;    // 3
        #10;

        // Test case 3: -5 * -6
        multiplicand = 4'b1011; // -5 (two's complement for 4 bits)
        multiplier = 4'b1010;   // -6 (two's complement for 4 bits)
        #10;

        // Test case 4: 4 * 0
        multiplicand = 4'b0100;  // 4
        multiplier = 4'b0000;    // 0
        #10;

        // Test case 5: 7 * -1
        multiplicand = 4'b0111;  // 7
        multiplier = 4'b1111;   // -1 (two's complement for 4 bits)
        #10;

        // Test case 6: Max * Min
        multiplicand = 4'b0111;  // Maximum positive value for N=4 (7)
        multiplier = 4'b1000;   // Minimum negative value for N=4 (-8, represented as two's complement)
        #10;

        // Test case 7: -8 * -8
        multiplicand = 4'b1000; // -8 (two's complement for 4 bits)
        multiplier = 4'b1000;   // -8 (two's complement for 4 bits)
        #10;

        // End simulation
        $finish;
    end

    // Dump variables for waveform analysis
    initial begin
        $dumpfile("multiplication.vcd");
        $dumpvars(0, booth_multiplier_tb);
    end
endmodule
