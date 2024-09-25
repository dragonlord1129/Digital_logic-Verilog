module decoder3_8_tb;
  reg [2:0] a_in;
  wire [7:0] a_out;

  decoder3_8 uut(
    .a_in(a_in),
    .a_out(a_out)
  );
  initial begin
    a_in = 3'b000;
    $monitor("Time = %0t a_in = %b a_out =%b", $time, a_in, a_out);
    #10 a_in = 3'b001;
    #10 a_in = 3'b010;
    #10 a_in = 3'b011;
    #10 a_in = 3'b100;
    #10 a_in = 3'b101;
    #10 a_in = 3'b110;
    #10 a_in = 3'b111;

  end
  initial begin
    $dumpfile("decoder3_8.vcd");
    $dumpvars(0, decoder3_8_tb);
  end

endmodule
