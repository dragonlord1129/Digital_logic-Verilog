module threebitadder_tb;
    reg [2:0] a, b, c;
    wire [2:0] result;
    wire carry;

    threebitadder uut (
        .a(a),
        .b(b),
        .c(c),
        .result(result),
        .carry(carry)
    );
    initial begin
        a = 3'b000;
        b = 3'b000;
        c = 3'b000;

        $monitor("Time = %0t a =%b b=%b c=%b result=%b carry=%b", $time, a, b, c, result, carry);
        #10 a = 3'b001;
        b = 3'b010;
        c = 3'b011;
        #10 a = 3'b101;
        b = 3'b010;
        c = 3'b001;
        #10 a = 3'b111;
        b = 3'b111;
        c = 3'b000;
        #10 a = 3'b011;
        b = 3'b100;
        c = 3'b001;
        #10 a = 3'b110;
        b = 3'b011;
        c = 3'b001;
        #10 a = 3'b111;
        b = 3'b111;
        c = 3'b111;

        #20 $finish;
    end
    initial begin
        $dumpfile("threebitadder.vcd");
        $dumpvars(0, threebitadder_tb);
    end
endmodule
