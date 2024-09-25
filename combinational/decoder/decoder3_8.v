module decoder3_8(
    input logic [2:0] a_in,
    output logic [7:0] a_out
);
always @(a_in) begin
    a_out = 8'b00000001<<a_in;
end

endmodule
