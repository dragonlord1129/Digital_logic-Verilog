module clk_divider(
    input clk_in,
    input [7:0] divisor,
    output reg clk_out
);

reg [7:0] counter = 8'd0;

always @(posedge clk_in) begin
    counter <= counter + 1;
    if (counter >= (divisor)) begin
        counter <= 0;
    end
    clk_out <= (counter < (divisor/2))?1'b1:1'b0;
end

endmodule