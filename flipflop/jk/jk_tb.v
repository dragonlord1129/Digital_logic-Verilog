module jk_tb;
    reg j, k, clk, reset;
    wire q;

    // Instantiate the JK flip-flop
    jk uut (
        .j(j),
        .k(k),
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Stimulus process
    initial begin
        // Initialize inputs
        j = 0; k = 0; reset = 1;  // Start with reset high
        #10 j = 1; k = 0;  // Set condition
        #10 j = 0; k = 1;  // Reset condition
        #10 j = 1; k = 1;  // Toggle condition
        #10 j = 0; k = 0;  // No change
        #10 reset = 0;  // Deassert reset after 10 time units
        
        // Apply test vectors
        #10 j = 1; k = 0;  // Set condition
        #10 j = 0; k = 1;  // Reset condition
        #10 j = 1; k = 1;  // Toggle condition
        #30 j = 0; k = 0;  // No change
        
        // Finish simulation
        #50;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("At time %0t: clk = %b, j = %b, k = %b, reset = %b, q = %b", 
                 $time, clk, j, k, reset, q);
    end

    // Dump waveform
    initial begin
        $dumpfile("jk.vcd");
        $dumpvars(0, jk_tb);
    end
endmodule
