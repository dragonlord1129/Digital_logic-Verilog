module mux2_8_tb;

    // Declare inputs as reg and outputs as wire
    reg [7:0] d0, d1;
    reg s;
    wire [7:0] y;

    // Instantiate the 8-bit 2:1 multiplexer
    mux2_8 uut (
        .d0(d0),
        .d1(d1),
        .s(s),
        .y(y)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        d0 = 8'b00000000;
        d1 = 8'b11111111;
        s = 0;

        // Wait for a while and then apply new inputs
        #10;
        s = 1;
        #10;
        s = 0;
        d0 = 8'b10101010;
        d1 = 8'b01010101;
        #10;
        s = 1;
        #10;
        s = 0;
        #10;

        // Finish the simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("At time %t, d0 = %b, d1 = %b, s = %b, y = %b", $time, d0, d1, s, y);
    end

    // Generate VCD file for GTKWave
    initial begin
        $dumpfile("mux2_8.vcd"); // Specify the name of the dumpfile
        $dumpvars(0, mux2_8_tb); // Dump all variables in the testbench module
    end

endmodule
