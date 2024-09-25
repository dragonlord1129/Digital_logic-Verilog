module jk (
    input j, k, clk, reset,  
    output reg q             
);
    always @(posedge clk or posedge reset) begin
        if (reset) 
            q <= 1'b0;  
        else begin
            case ({j, k})
                2'b00 : q <= q;   // No change
                2'b01 : q <= 1'b0; // Reset output to 0
                2'b10 : q <= 1'b1; // Set output to 1
                2'b11 : q <= ~q;   // Toggle output
            endcase
        end
    end
endmodule
