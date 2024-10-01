module moore ( // 1101 sequence detector
    input x, clk, rst,
    output reg y,
    output [2:0] state // Use wire to monitor state
);
    reg [2:0] ps, ns;
    localparam sin = 3'd0, s1 = 3'd1, s11 = 3'd2, s110 = 3'd3, s1101 = 3'd4;

    // State transition on the rising edge of the clock or reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ps <= sin; // Reset to initial state
        end else begin
            ps <= ns; // Transition to next state
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default assignments to avoid latches
        ns = ps;
        y = 1'b0;

        case (ps)
            sin: begin
                ns = x ? s1 : sin;
            end 
            s1: begin
                ns = x ? s11 : sin;
            end
            s11: begin
                ns = x ? s1 : s110;
            end
            s110: begin
                ns = x ? s1101 : sin;
            end
            s1101: begin
                ns = x ? s11 : sin;
                y = 1'b1; // Detect sequence
            end
            default: begin
                ns = sin; // Safe fallback in case of unexpected state
            end
        endcase
    end

    // Output the current state as wire (ps)
    assign state = ps;

endmodule
