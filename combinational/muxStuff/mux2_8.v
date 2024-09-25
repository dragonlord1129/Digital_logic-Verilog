module mux2 ( // 4-bit 2:1 multiplexer
    input logic [3:0] d0, d1,
    input logic s,

    output wire [3:0] y
    
);
    assign y = s ? d1 : d0;
endmodule 

module mux2_8 ( // 8-bit 2:1 multiplexer
    input logic [7:0] d0, d1,
    input logic s,

    output wire [7:0] y    
);
    mux2 lsbmux(.d0(d0[3:0]), .d1(d1[3:0]), .s(s), .y(y[3:0]));
    mux2 msbmux(.d0(d0[7:4]), .d1(d1[7:4]), .s(s), .y(y[7:4]));

endmodule //mux2_8