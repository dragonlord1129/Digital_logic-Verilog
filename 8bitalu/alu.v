`timescale 1ns/1ps

`define addition 4'b0000
`define subtraction 4'b0001
`define multiplication 4'b0010
`define division 4'b0011
`define logicalleft 4'b0100
`define logicalright 4'b0101
`define rotateleft 4'b0110
`define rotateright 4'b0111
`define logicaland 4'b1000
`define logicalor 4'b1001
`define logicalxor 4'b1010
`define logicalnor 4'b1011
`define logicalnand 4'b1100
`define logicalxnor 4'b1101
`define greatercomparison 4'b1110
`define equalcomparison 4'b1111

module alu (
  input [N-1:0] val1, val2,
  input [3:0] select,
  output [N-1:0] result,
  output flag
);
  parameter N = 8;
  reg [N-1:0] result2;
  wire [N:0] tmp;  // Used for overflow detection in arithmetic operations
  assign result = result2;
  assign tmp = {1'b0, val1} + {1'b0, val2};  // Example: overflow in addition
  assign flag = tmp[N];  // MSB of tmp used as overflow flag

  always @( *) begin
    case (select)
      `addition : begin
        result2 = val1 + val2;
      end
      `subtraction : begin
        result2 = val1 - val2;
      end
      `multiplication : begin
        result2 = val1 * val2;
      end
      `division : begin
        if (val2 != 0) begin
          result2 = val1 / val2;
        end else begin
          result2 = 0;  // Handle division by zero
        end
      end
      `logicalleft: begin
        result2 = val1 << 1;
      end
      `logicalright: begin
        result2 = val1 >> 1;
      end
      `rotateleft: begin
        result2 = {val1[N-2:0], val1[N-1]};
      end
      `rotateright: begin
        result2 = {val1[0], val1[N-1:1]};
      end
      `logicaland: begin 
        result2 = val1 & val2;
      end
      `logicalor: begin
        result2 = val1 | val2;
      end
      `logicalxor: begin
        result2 = val1 ^ val2;
      end
      `logicalnor: begin
        result2 = ~(val1 | val2);
      end
      `logicalnand: begin
        result2 = ~(val1 & val2);
      end
      `logicalxnor: begin
        result2 = ~(val1 ^ val2);
      end
      `greatercomparison: begin
        result2 = (val1 > val2) ? 8'd1 : 8'd0;
      end
      `equalcomparison: begin 
        result2 = (val1 == val2) ? 8'd1 : 8'd0;
      end
      default: result2 = {N{1'b0}};  // Default value set to 0, N bits wide
    endcase
  end
endmodule
