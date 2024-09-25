module testbench_gates;

    reg [3:0] a;
    reg [3:0] b;

    wire [3:0] c1, c2, c3, c4;

    gates uut (
        .a (a),
        .b (b),
        .c1(c1),
        .c2(c2),
        .c3(c3),
        .c4(c4)
    );

    initial begin
        a = 4'b0000;
        b = 4'b0000;

        $monitor("Time = %0t", "a = %h", "b= %h", "c1=%h", "c2=%h", "c3=%h", "c4=%h", $time, a, b,
                 c1, c2, c3, c4);

        #10 a = 4'b1010;
        b = 4'b0101;  // Test case 1
        #10 a = 4'b1111;
        b = 4'b0100;  // Test case 2
        #10 a = 4'b0011;
        b = 4'b0011;  // Test case 3
        #10 a = 4'b1101;
        b = 4'b1010;  // Test case 4
        #10 a = 4'b0110;
        b = 4'b1000;  // Test case 5

        #20 $finish;
    end
    initial begin
        $dumpfile("gates.vcd");
        $dumpvars(0, testbench_gates);
    end

endmodule
