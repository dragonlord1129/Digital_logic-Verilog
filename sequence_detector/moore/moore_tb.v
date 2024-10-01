module moore_tb;
    reg x, clk, rst;
    wire y;
    wire [2:0] state; // To monitor the state

    // Instantiate the Moore sequence detector
    moore uut(
        .x(x),
        .clk(clk),
        .rst(rst),
        .y(y),
        .state(state) // Connect state to monitor
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units per cycle
    end

    // Test sequence
    initial begin
        $dumpfile("moore.vcd");
        $dumpvars(0, moore_tb);

        // Apply reset
        rst = 1;
        #10;
        rst = 0;

        // Input sequence for 1101
        x = 1; #10; // First 1
        x = 1; #10; // Second 1
        x = 0; #10; // First 0
        x = 1; #10; // Final 1 (should detect 1101)

        // Continue the simulation to observe more output
        x = 1; #10;
        x = 0; #10;
        x = 1; #10; // Should display 1 again.

        #100;
        $finish;
    end
endmodule
