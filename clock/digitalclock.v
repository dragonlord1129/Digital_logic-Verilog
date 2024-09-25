`timescale 1ns / 1ps 

module digitalclock(
    input Clk_1sec,   // Clock with 1 Hz frequency
    input reset,      // Active high reset
    output reg [5:0] seconds,
    output reg [5:0] minutes,
    output reg [4:0] hours  // 5 bits can represent hours 0 to 31
);
    // Constants for maximum values
    parameter SECONDS_MAX = 6'd59;
    parameter MINUTES_MAX = 6'd59;
    parameter HOURS_MAX = 5'd23; // Max for 24-hour format

    // Execute the always block on the positive edge of Clk_1sec or reset
    always @(posedge Clk_1sec or posedge reset) begin
        if (reset) begin  // Check for active high reset
            seconds <= 6'b0;  
            minutes <= 6'b0;  
            hours   <= 5'b0;   
        end else begin
            seconds <= seconds + 1;  
            if (seconds == SECONDS_MAX) begin
                seconds <= 6'b0;  
                minutes <= minutes + 6'd1;  
                if (minutes == MINUTES_MAX) begin  
                    minutes <= 6'b0;  
                    hours <= hours + 6'd1; 
                    if (hours == HOURS_MAX) begin
                        hours <= 5'b0; // Reset hours after reaching 24
                    end                   
                end
            end
        end
    end
endmodule