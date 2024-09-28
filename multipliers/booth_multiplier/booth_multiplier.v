module booth_multiplier #(
    parameter N = 4,
    parameter WIDTH = 2*N
) (
    input signed [N-1: 0] multiplicand, multiplier,
    output reg signed [WIDTH-1: 0] product
);
    reg [1:0] check;
    integer i;
    reg q1;
    
    
  function [N-1:0] twos_compliment;
    input signed [N-1:0] data;
    begin
        twos_compliment = ~data + 1'b1; // Compute two's complement and assign it to the function output
    end
endfunction


    always @(multiplicand, multiplier) begin
        product = {WIDTH{1'b0}};
        q1 = 1'b0;
        
        for (i = 0; i < N; i=i+1) begin
            check = {multiplicand[i], q1};
            case (check)
                2'b01 : begin
                    product[WIDTH-1:N] = product[WIDTH-1:N] + multiplier;
                end
                2'b10 : begin
                    product[WIDTH-1:N] = product[WIDTH-1:N] + twos_compliment(multiplier);
                end
                default: ;
            endcase
            product = product >> 1;
            product[WIDTH-1] = product[WIDTH-2];
            q1 = multiplicand[i];
        end
    end
    
endmodule