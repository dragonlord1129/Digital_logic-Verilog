module pseudorandomNumber_tb;
    reg clk; 
    reg rst;
    wire [3:0] rand_out;

    pseudorandomNumber uut( .clk(clk), .rst(rst), .rand_out(rand_out) );

    always begin
        #5 clk = ~clk; 
    end

    initial begin

        $dumpfile("number.vcd");
        $dumpvars(0, pseudorandomNumber_tb);

        clk = 0;
        rst = 0;

        rst = 1;
        #10 rst = 0;

        $monitor("Time %t\t Output %b", $time, rand_out);

        #100; 
        $finish;
    end

endmodule