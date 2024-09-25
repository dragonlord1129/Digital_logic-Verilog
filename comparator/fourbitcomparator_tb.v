module fourbitcomparator_tb;

    // Inputs
    reg [3:0] Data_in_A;
    reg [3:0] Data_in_B;

    // Outputs
    wire [1:0] flag;  // Output flag as wire
    wire less;
    wire equal;
    wire greater;

    // Instantiate the Unit Under Test (UUT)
    fourbitcomparator uut (
        .A(Data_in_A),    // Correct port name
        .B(Data_in_B),    // Correct port name
        .flag(flag)
    );

    initial begin
        // Apply test vectors
        $monitor("Time: %0d, A: %b, B: %b, Flag: %b", $time, Data_in_A, Data_in_B, flag); // Monitor output

        // Test Case 1
        Data_in_A = 4'b1010;  // 10 in decimal
        Data_in_B = 4'b1100;  // 12 in decimal
        #100;
        
        // Test Case 2
        Data_in_A = 4'b1111;  // 15 in decimal
        Data_in_B = 4'b1011;  // 11 in decimal
        #100;

        // Test Case 3
        Data_in_A = 4'b1010;  // 10 in decimal
        Data_in_B = 4'b1010;  // 10 in decimal
        #100;

        // Add more test cases as necessary
        $finish;  // End simulation
    end
    initial begin
        $display("comparator.vcd");
        $dumpvars(0, fourbitcomparator_tb);
    end

endmodule
