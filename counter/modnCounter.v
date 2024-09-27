module modnCounter #(
    parameter N = 15,      // Modulo value
    parameter WIDTH = 4    // Bit-width of the counter
) (
    input clk, resetn,
    output reg [WIDTH-1:0] counter
);
    always @(posedge clk) begin
        if (!resetn) begin
            counter <= {WIDTH{1'b0}};
        end else begin
            if (counter == N) begin
                counter <= {WIDTH{1'b0}};
            end else begin
                counter <= counter + 4'h1;
            end
        end
    end
endmodule
