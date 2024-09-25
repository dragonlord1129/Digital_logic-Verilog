module d_flipflop_tb;
    reg d, clk;
    wire q;

    // Instantiate the D flip-flop
    d_flipflop uut(
        .d(d),
        .clk(clk),
        .q(q)  // Connect the output q
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Stimulus process
    initial begin
        // Initialize inputs
        d = 0;

        // Apply test vectors
        #10 d = 1'b0;  // This will be captured on the next clock edge
        #10 d = 1'b1;  // This will be captured on the next clock edge
        #10 d = 1'b0;  // Another change for testing
        #10 d = 1'b1;  // Another change for testing

        // Wait some time and finish the simulation
        #50;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("At time %0t: clk = %b, d = %b, q = %b", $time, clk, d, q);
    end

    // Dump waveform
    initial begin
        $dumpfile("dflipflop.vcd");
        $dumpvars(0, d_flipflop_tb);
    end
endmodule
