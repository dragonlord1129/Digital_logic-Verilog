`timescale 1ns/1ps

module mux2 (
    input logic [3:0] d0, d1,
    input logic s,
    output wire [3:0] y
);
    // Assign the output based on the select signal
    assign y = s ? d1 : d0;

endmodule



