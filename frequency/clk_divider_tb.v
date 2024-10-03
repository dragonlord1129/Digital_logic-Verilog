module clk_divider_tb;

reg clk_in;
reg [7:0] divisor;
wire clk_out;

clk_divider dut ( .clk_in(clk_in), .divisor(divisor), .clk_out(clk_out) );

always #5 clk_in = ~clk_in;

initial begin
    $dumpfile("clk.vcd");
    $dumpvars(0, clk_divider_tb);
    
    clk_in = 1'b0;
    divisor = 8'd4;
    #10;
    
    #100 $finish;
end

always @(posedge clk_out) begin
    $display("clk_out = %b", clk_out);
end

endmodule