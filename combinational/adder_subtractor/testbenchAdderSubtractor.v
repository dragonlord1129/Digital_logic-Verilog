module testbenchAdderSubtractor;
    reg a, b, c;
    wire sum, carry, borrow;

    adder_subtractor uut (
        .a(a),
        .b(b),
        .c(c),
        .sum(sum),
        .carry(carry),
        .borrow(borrow)
    );

    initial begin
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;

        $monitor("Time = %0t a=%b b=%b c=%b sum=%b carry=%b borrow=%b", $time, a, b, c, sum, carry,
                 borrow);

        #10 a = 1'b0;
        b = 1'b0;
        c = 1'b1;  // (a=0, b=0, c=1)
        #10 a = 1'b0;
        b = 1'b1;
        c = 1'b0;  // (a=0, b=1, c=0)
        #10 a = 1'b0;
        b = 1'b1;
        c = 1'b1;  // (a=0, b=1, c=1)
        #10 a = 1'b1;
        b = 1'b0;
        c = 1'b0;  // (a=1, b=0, c=0)
        #10 a = 1'b1;
        b = 1'b0;
        c = 1'b1;  // (a=1, b=0, c=1)
        #10 a = 1'b1;
        b = 1'b1;
        c = 1'b0;  // (a=1, b=1, c=0)
        #10 a = 1'b1;
        b = 1'b1;
        c = 1'b1;  // (a=1, b=1, c=1)

        #20 $finish;
    end

    initial begin
        $dumpfile("adder_subtractor.vcd");
        $dumpvars(0, testbenchAdderSubtractor);
    end
endmodule
