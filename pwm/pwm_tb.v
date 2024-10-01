module pwm_tb;
    reg clk;
    wire [3:0] out;

    // Instantiate the PWM module
    pwm uut (
        .clk(clk),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units per clock cycle
    end

    // Simulation control
    initial begin
        $dumpfile("pwm.vcd");
        $dumpvars(0, pwm_tb);

        // Run the simulation for some time
        #1000;
        $finish;
    end
endmodule
