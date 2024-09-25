module mux2tri_tb;
    reg [3:0] d0, d1;
    reg s;
    wire [3:0] y;

    // Instantiate the mux2tri module
    mux2tri uut (
        .d0(d0),
        .d1(d1),
        .s(s),
        .y(y)
    );

    initial begin
        // Initialize inputs
        d0 = 4'b1010; d1 = 4'b0101; s = 0;
        #10; s = 1;
        #10; s = 0; d0 = 4'b1100;
        #10; s = 1; d1 = 4'b0011;
        #10; $finish;
    end

    initial begin
        $dumpfile("mux2tri.vcd");
        $dumpvars(0, mux2tri_tb);
        $monitor("At time %t, s = %b, d0 = %b, d1 = %b, y = %b", $time, s, d0, d1, y);
    end
endmodule
