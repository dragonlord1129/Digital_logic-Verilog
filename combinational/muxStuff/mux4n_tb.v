module mux4n_tb;
    reg [4:0] d0, d1, d2, d3;
    reg [1:0] s;
    wire [4:0] out;

    // Instantiate the mux4n module
    mux4n uut (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .s(s),
        .out(out)
    );

    initial begin
        // Initialize inputs
        d0 = 5'b00001; d1 = 5'b00010; d2 = 5'b00100; d3 = 5'b01000; s = 2'b00;
        #10; s = 2'b01;
        #10; s = 2'b10;
        #10; s = 2'b11;
        #10; $finish;
    end

    initial begin
        $dumpfile("mux4n.vcd");
        $dumpvars(0, mux4n_tb);
        $monitor("At time %t, s = %b, out = %b", $time, s, out);
    end
endmodule


