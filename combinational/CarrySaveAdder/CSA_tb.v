`timescale 1ns / 1ps

module CSA_tb;

    // Inputs
    reg [5:0] A;
    reg [5:0] B;
    reg [5:0] C;
   

    // Outputs
    wire [5:0] carry;
    wire [5:0] sum;

    // Instantiate the Unit Under Test (UUT)
    CSA uut (
        .A(A),
        .B(B),
        .C(C),
        .carry_out(carry),
        .sum(sum)
    );

    initial begin
        // Test case: All ones
        A = 6'b000111; 
        B = 6'b001110; 
        C = 6'b011100; 
  
        #10; // Wait for output to stabilize
        
        // Display the results
        $display("Sum=%b, Carry=%b", sum, carry);
        
        // Stop simulation
        $finish;
    end

    initial begin
        $dumpfile("csa.vcd");  // Specify the VCD file name
        $dumpvars(0, CSA_tb);            // Dump all signals in this module and its sub-modules
    end
endmodule
