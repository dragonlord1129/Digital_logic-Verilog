module round_robin_arbiter_tb;
    reg clk, reset;
    reg [3:0] request;
    wire [3:0] grant;

    round_robin_arbiter uut(
        .clk(clk),
        .reset(reset),
        .request(request),
        .grant(grant)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Display signals for debugging
    initial begin
        $monitor("Time: %0t | request: %b | grant: %b", $time, request, grant);
    end

    // Test stimulus
    initial begin
        $dumpfile("round_robin.vcd");
        $dumpvars(0, round_robin_arbiter_tb);

        clk = 0;
        reset = 1;
        request = 4'h0;

        #10 reset = 0;

        // Different request patterns
        request = 4'b1011;  // Time: 10
        #20;
        request = 4'b1111;  // Time: 30
        #20;
        request = 4'b1000;  // Time: 50
        #20;
        request = 4'b1001;  // Time: 70
        #20;
        request = 4'b1100;  // Time: 90
        #20;
        $finish;   
    end
endmodule
