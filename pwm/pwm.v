module pwm(
    input clk,
    output reg [3:0] out  // Use reg since we are updating this in always block
);

    reg [7:0] count = 0;

    always @(posedge clk) begin
        if (count < 99)
            count <= count + 1;
        else
            count <= 0;
    end

    // Generate PWM outputs with different duty cycles
    always @(posedge clk) begin
        out = 4'b0000;
        out[0] <= (count < 20) ? 1 : 0;  // 20% duty cycle
        out[1] <= (count < 40) ? 1 : 0;  // 40% duty cycle
        out[2] <= (count < 60) ? 1 : 0;  // 60% duty cycle
        out[3] <= (count < 80) ? 1 : 0;  // 80% duty cycle
    end

endmodule
