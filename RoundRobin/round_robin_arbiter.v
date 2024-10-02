module round_robin_arbiter (
    input clk, reset,
    input [3:0] request,
    output reg [3:0] grant
);
    // Define the states with proper 3-bit parameters (fix the size issue)
    parameter [2:0] idle = 3'd0;
    parameter [2:0] state_0 = 3'd1;
    parameter [2:0] state_1 = 3'd2;
    parameter [2:0] state_2 = 3'd3;
    parameter [2:0] state_3 = 3'd4;

    reg [2:0] current, next;

    // Sequential state transition block, updating current state on clock edge or reset
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            current <= idle;
        end else begin
            current <= next;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (current)
            idle: begin
                if(request[0]) begin
                    next = state_0;
                end else if(request[1]) begin
                    next = state_1;
                end else if(request[2]) begin
                    next = state_2;
                end else if(request[3]) begin
                    next = state_3;
                end else begin
                    next = idle;
                end          
            end

            state_0: begin 
               if(request[1]) begin
                    next = state_1;
                end else if(request[2]) begin
                    next = state_2;
                end else if(request[3]) begin
                    next = state_3;
                end else if(request[0]) begin
                    next = state_0;
                end else begin
                    next = idle;
                end       
            end

            state_1: begin
                if(request[2]) begin
                    next = state_2;
                end else if(request[3]) begin
                    next = state_3;
                end else if(request[0]) begin
                    next = state_0;
                end else if(request[1]) begin
                    next = state_1;
                end else begin
                    next = idle;
                end       
            end

            state_2: begin
                if(request[3]) begin
                    next = state_3;
                end else if(request[0]) begin
                    next = state_0;
                end else if(request[1]) begin
                    next = state_1;
                end else if(request[2]) begin
                    next = state_2;
                end else begin
                    next = idle;
                end       
            end

            state_3: begin
                if(request[0]) begin
                    next = state_0;
                end else if(request[1]) begin
                    next = state_1;
                end else if(request[2]) begin
                    next = state_2;
                end else if(request[3]) begin
                    next = state_3;
                end else begin
                    next = idle;
                end       
            end

            default: begin
                next = idle;
            end
        endcase
    end

    // Combinational logic for grant signals based on current state
    always @(*) begin
        case (current)
            state_0: grant = 4'h1;
            state_1: grant = 4'h2;
            state_2: grant = 4'h4;
            state_3: grant = 4'h8; 
            default: grant = 4'h0;
        endcase
    end

endmodule
