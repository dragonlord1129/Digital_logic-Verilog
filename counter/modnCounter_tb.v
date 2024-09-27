`timescale 1ns/1ps

module modnCounter_tb;
    parameter N = 15;
    parameter WIDTH = 4;

    reg clk, resetn;
    wire [WIDTH-1:0] counter;  // Declare as multi-bit wire to match the DUT output width

    // Instantiate the Unit Under Test (UUT)
    modnCounter uut (
        .clk(clk),
        .resetn(resetn),
        .counter(counter)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 10 ns
    end

    // Reset logic
    initial begin
        resetn = 0;  // Assert reset (active low)
        #10 resetn = 1;  // Release reset after 20 ns
    end

    // Simulation stop
    initial begin
        #200;  // Run simulation for 200 ns
        $finish;
    end

    // Monitor and dump signals
    initial begin
        $monitor("Time = %0t, resetn = %0b, counter = %0h", $time, resetn, counter);
        $dumpfile("counter.vcd");
        $dumpvars(0, modnCounter_tb);
    end
endmodule
