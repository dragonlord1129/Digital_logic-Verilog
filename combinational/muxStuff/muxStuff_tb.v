`timescale 1ns/1ps

module tb_mux2;

    // Testbench signals
    reg [3:0] d0, d1;  // 'reg' type for testbench signals that will be driven
    reg s;             // 'reg' type for the select signal
    wire [3:0] y;      // 'wire' type for the output to observe

    // Instantiate the DUT (Device Under Test)
    mux2 dut (
        .d0(d0),
        .d1(d1),
        .s(s),
        .y(y)
    );

    // Test sequence
    initial begin
        // VCD file generation
        $dumpfile("muxStuff.vcd");
        $dumpvars(0, tb_mux2);

        // Initialize inputs
        d0 = 4'b0001;
        d1 = 4'b1010;
        s = 0;
        #10;  // Wait 10 ns

        // Test case 1
        s = 0;
        #10;  // Wait 10 ns

        // Test case 2
        s = 1;
        #10;  // Wait 10 ns

        // Modify input values and test again
        d0 = 4'b0110;
        d1 = 4'b1001;
        
        // Test case 3
        s = 0;
        #10;  // Wait 10 ns

        // Test case 4
        s = 1;
        #10;  // Wait 10 ns

        // End the simulation
        $finish;
    end

    // Monitor changes to inputs and output
    initial begin
        $monitor("At time %t: s=%b, d0=%b, d1=%b, y=%b", $time, s, d0, d1, y);
    end

endmodule
