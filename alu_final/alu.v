module alu(
    input clk,
    input grp,
    input [2:0] opcode,
    input [7:0] operand1,
    input [7:0] operand2,
    input [7:0] operand3,
    input [3:0] flags,

    output [7:0] finaloperand,
    output [3:0] outflags1
);  
    parameter arithmetic = 1'b0;
    parameter logicalShift = 1b1;

    reg [8:0] result;
    reg [8:0] subresult;
    reg [8:0] temp;
    reg [3:0] outflags;
    reg [15:0] shifter;

    assign finaloperand = result[7:0];
    assign outflags1 = outflags;

    always @(posedge clk) begin
        // Initialize result and outflags
        result = 9'b0;
        outflags = flags;

        case (grp) 
            arithmetic : begin // Arithmetic Operations
                case (opcode)
                    3'b000: begin // ADD
                        result = operand2 + operand3;
                        outflags[0] = result[8]; // Carry flag
                        outflags[1] = 1'b0; // Overflow flag
                    end

                    3'b001: begin // ADC
                        result = operand2 + operand3 + flags[0];
                        outflags[0] = result[8];
                        outflags[1] = 1'b0;
                    end

                    3'b010: begin // SUB
                        result = operand2 - operand3;
                        outflags[1] = (operand3 > operand2) ? 1'b1 : 1'b0; // Borrow flag
                        outflags[0] = 1'b0; // Carry flag
                    end

                    3'b011: begin // SBB
                        result = operand2 - operand3 - flags[1];
                        outflags[1] = (operand3 > operand2) || 
                                       ((operand3 == operand2) && (flags[1] == 1'b1)) ? 1'b1 : 1'b0; // Borrow flag
                        outflags[0] = 1'b0; // Carry flag
                    end

                    default: result = 9'bx; // Undefined opcode
                endcase

                outflags[2] = ~|result[7:0]; // Zero flag
                outflags[3] = ^result[7:0];  // Parity flag

            end

            logicalShift: begin // Logic and Shift Operations
                case (opcode)
                    3'b000: begin // AND
                        result = operand2 & operand3;
                    end

                    3'b001: begin // OR
                        result = operand2 | operand3;
                    end

                    3'b010: begin // ROR (Rotate Right)
                        subresult = {operand1[0], operand1[7:1]}; // Rotate right
                        result = subresult;
                    end

                    3'b011: begin // ROL (Rotate Left)
                        subresult = {operand1[6:0], operand1[7]}; // Rotate left
                        result = subresult;
                    end

                    3'b100: begin // SHR (Shift Right)
                        shifter = {8'b0, operand1}; // Sign extend
                        result = shifter >> 1;
                    end

                    3'b101: begin // SHL (Shift Left)
                        result = operand1 << 1;
                    end

                    default: result = 9'bx; // Undefined opcode
                endcase
            end

            default: begin
                result = 9'bx; // Undefined group
            end
        endcase
    end
endmodule
