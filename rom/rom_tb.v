module rom_tb;
    reg [2:0] address;
    wire [7:0] data;

    rom uut ( .addr(address), .data(data) );


    initial begin
        $monitor("Time = %0t, address = %0b, data = %0b", $time, address, data);
        address = 3'b000;
        #10;

        address = 3'b001;
        #10;

        address = 3'b010;
        #10;

        address = 3'b011;
        #10;

        address = 3'b100;
        #10;

        address = 3'b101;
        #10;

        address = 3'b110;
        #10;

        address = 3'b111;
        #10;
        $finish;

    end

    initial begin
       
        $dumpfile("rom.vcd");
        $dumpvars(0, rom_tb);
    end

endmodule //rom_tb