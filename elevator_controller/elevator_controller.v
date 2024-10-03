module elevator_controller (
    input clk, rst,
    input [4:0] floor_req,
    output reg [4:0] floor_pos
);
    parameter idle = 3'b000;
    parameter movingUP = 3'b001;
    parameter movingDOWN = 3'b010;
    parameter STOP = 3'b011;

    reg [2:0] state;
    reg [4:0] floor_pos_reg, floor_req_reg;

    always @(posedge clk) begin
        if(rst) begin
            state <= idle;
            floor_pos_reg <= 5'b00000;
            floor_req_reg <= 5'b00000;
        end else begin
            case (state)
                idle: begin
                    if(floor_req > floor_pos_reg) begin
                        state <= movingUP;
                    end else if(floor_req < floor_pos_reg) begin
                        state <= movingDOWN;
                    end else begin
                        state <= STOP;
                    end
                end 
                movingUP: begin
                    if(floor_req == floor_pos_reg) begin
                        state <= STOP;
                    end else begin
                        floor_pos_reg <= floor_pos_reg + 1;
                    end
                end
                movingDOWN: begin
                     if(floor_req == floor_pos_reg) begin
                        state <= STOP;
                    end else begin
                        floor_pos_reg <= floor_pos_reg - 1;
                    end
                end
                STOP: begin
                    floor_req_reg[floor_pos_reg] <= 1'b0; //clear request for current floor
                    if(floor_req_reg != 5'b00000) begin
                        if(floor_req > floor_pos_reg) begin
                            state <= movingUP;
                        end else if(floor_req < floor_pos_reg) begin
                            state <= movingDOWN;
                        end else begin
                            state <= STOP;
                        end
                    end else begin
                        state <= idle;
                    end
                end
                default: ;
            endcase
            floor_pos <= floor_pos_reg;
            floor_req_reg[floor_req] <= 1'b1; //set request for <this> floor
        end
    end    
endmodule