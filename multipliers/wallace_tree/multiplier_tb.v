// `timescale 1ns / 1ps

module multiplier_tb;

    // Inputs
    reg [3:0] A;
    reg [3:0] B;

    // Outputs
    wire [7:0] PRODUCT;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    multiplier uut (
        .A(A),
        .B(B),
        .PRODUCT(PRODUCT),
        .cout(cout)
    );

    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;

        // Wait 100 ns for global reset to finish
        #10;
        
        // Apply test cases
        A = 4'b0011; // A = 3
        B = 4'b0101; // B = 5
        #10;         // Wait 10 ns
        $display("Test case 1: A=3, B=5, PRODUCT=%d, cout=%b", PRODUCT, cout);
        
        A = 4'b1111; // A = 15
        B = 4'b1111; // B = 15
        #10;
        $display("Test case 2: A=15, B=15, PRODUCT=%d, cout=%b", PRODUCT, cout);

        A = 4'b1001; // A = 9
        B = 4'b0110; // B = 6
        #10;
        $display("Test case 3: A=9, B=6, PRODUCT=%d, cout=%b", PRODUCT, cout);

        A = 4'b0010; // A = 2
        B = 4'b0011; // B = 3
        #10;
        $display("Test case 4: A=2, B=3, PRODUCT=%d, cout=%b", PRODUCT, cout);

        A = 4'b0000; // A = 0
        B = 4'b1010; // B = 10
        #10;
        $display("Test case 5: A=0, B=10, PRODUCT=%d, cout=%b", PRODUCT, cout);

        A = 4'b0111; // A = 7
        B = 4'b0010; // B = 2
        #10;
        $display("Test case 6: A=7, B=2, PRODUCT=%d, cout=%b", PRODUCT, cout);
        
        $finish; // Stop simulation
    end
    initial begin
        $dumpfile("multiplier.vcd");  // Specify the VCD file name
        $dumpvars(0, multiplier_tb);     // Dump all signals in this module and its sub-modules
    end
endmodule
