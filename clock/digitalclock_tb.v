module digitalclock_tb; 
    // Inputs
    reg Clk_1sec; 
    reg reset; 

    // Outputs
    wire [5:0] seconds; 
    wire [5:0] minutes; 
    wire [4:0] hours; 

    // Instantiate the Unit Under Test (UUT) 
    digitalclock uut (
        .Clk_1sec(Clk_1sec), 
        .reset(reset), 
        .seconds(seconds), 
        .minutes(minutes), 
        .hours(hours) 
    ); 

    // Generating the Clock with 1 Hz frequency
    initial Clk_1sec = 0; 
    always #0.5 Clk_1sec = ~Clk_1sec;  // 1 Hz clock (1 second period)

    // Testbench stimulus
    initial begin 
        reset = 1; 
        // Wait for global reset to finish 
        #1; 
        reset = 0; 

        // Run the simulation for a sufficient time to observe behavior
        #86400;  // Run for 86400 seconds (24 hours)
        $finish; 
    end 

    // Monitor outputs
    initial begin
        // Print every change in hours
        $monitor("At time %0t: reset = %b, seconds = %d, minutes = %d, hours = %d", 
                 $time, reset, seconds, minutes, hours);
    end 

    // Dump waveform
    initial begin
        $dumpfile("digital_clock.vcd");  // Specify the VCD file name
        $dumpvars(0, digitalclock_tb);          // Dump all variables in the tb_clock module
    end 
endmodule