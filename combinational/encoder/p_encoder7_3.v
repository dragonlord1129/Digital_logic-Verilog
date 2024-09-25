module p_encoder7_3 (
    input logic [7:0] a_in,
    output logic [2:0] a_out    
);
  always @(a_in) begin
    casez (a_in)
        8'b1??????? : a_out = 3'b111;
        8'b01?????? : a_out = 3'b110;
        8'b001????? : a_out = 3'b101;
        8'b0001???? : a_out = 3'b100;
        8'b00001??? : a_out = 3'b011;
        8'b000001?? : a_out = 3'b010;
        8'b0000001? : a_out = 3'b001;
        default: a_out = 3'b000;
    endcase
  end      
endmodule