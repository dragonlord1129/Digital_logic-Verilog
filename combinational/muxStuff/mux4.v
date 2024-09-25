`timescale 1ns/1ps
module mux4(
    input logic [4:0] d0, d1, d2, d3,
    input logic [1:0] s,

    output wire [4:0] y
);

assign y = s[1] ? (s[0] ? d3:d2) : (s[0] ? d1:d0);

endmodule
