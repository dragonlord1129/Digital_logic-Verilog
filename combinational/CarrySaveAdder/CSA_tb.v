`timescale 1ns / 1ps

module CSA_tb;

    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg [7:0] C;
    reg [7:0] D;

    // Outputs
    wire [7:0] carry;
    wire [7:0] sum;

    // Instantiate the Unit Under Test (UUT)
    CSA uut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .carry_out(carry),
        .sum(sum)
    );

    initial begin
        // Test case: All ones
        A = 8'b00001111; 
        B = 8'b00011110; 
        C = 8'b00111100; 
        D = 8'b01111000; 
        #10; // Wait for output to stabilize
        
        // Display the results
        $display("Test case: A=255, B=255, C=255, D=255 => Sum=%b, Carry=%b", sum, carry);
        
        // Stop simulation
        $finish;
    end

    initial begin
        $dumpfile("csa.vcd");  // Specify the VCD file name
        $dumpvars(0, CSA_tb);            // Dump all signals in this module and its sub-modules
    end
endmodule
