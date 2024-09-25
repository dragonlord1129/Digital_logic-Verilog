`timescale 1ns/1ps
module mux4_tb;

    // Testbench signals
    reg [4:0] d0, d1, d2, d3;
    reg [1:0] s;
    wire [4:0] y;

    // Instantiate the mux4 module
    mux4 uut (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .s(s),
        .y(y)
    );

    initial begin
        // Create dump file for GTKWave
        $dumpfile("mux4.vcd");
        $dumpvars(0, mux4_tb);

        // Apply test vectors
        // Test case 1: s = 00
        d0 = 5'b00001; d1 = 5'b00010; d2 = 5'b00100; d3 = 5'b01000; s = 2'b00;
        #10;

        // Test case 2: s = 01
        s = 2'b01;
        #10;

        // Test case 3: s = 10
        s = 2'b10;
        #10;

        // Test case 4: s = 11
        s = 2'b11;
        #10;

        // Additional test cases if needed
        // ...

        // Finish simulation
        $finish;
    end
endmodule
