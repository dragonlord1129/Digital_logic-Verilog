`timescale 1ns / 1ps

module ram_tb;

// Parameter definitions
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

// Testbench signals
reg clk;
reg [ADDR_WIDTH-1:0] address;
reg oe;
reg w_r1;
reg cs;
reg [DATA_WIDTH-1:0] data_out; // Use a reg to manage data output
wire [DATA_WIDTH-1:0] data;    // This will be used for the inout

// Instantiate the RAM module
ram #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut (
    .clk(clk),
    .address(address),
    .oe(oe),
    .w_r1(w_r1),
    .cs(cs),
    .data(data) // Connect to the wire
);

// Drive the data signal based on the control signals
assign data = (cs && w_r1) ? data_out : {DATA_WIDTH{1'bz}}; // Use data_out to write to the RAM

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock period of 10ns
end

// Test procedure
initial begin
    // Initialize signals
    cs = 0;
    w_r1 = 0;
    oe = 0;
    address = 0;
    data_out = 0;

    // Setup GTKWave dump file
    $dumpfile("ram_tb.vcd");  // Name of the VCD file
    $dumpvars(0, ram_tb);      // Dump all variables in the ram_tb module

    // Wait for a couple of clock cycles
    #10;

    // Write operation example
    cs = 1;        // Chip select
    w_r1 = 1;     // Write mode
    oe = 0;       // Output enable off
    address = 8'd0; // Address 0
    data_out = 8'hA5;  // Data to write
    #10;           // Wait for a clock cycle

    // Read operation example
    w_r1 = 0;     // Read mode
    oe = 1;       // Output enable on
    #10;           // Wait for a clock cycle

    // Check data
    if (data !== 8'hA5) begin
        $display("Read Error: Expected 8'hA5, got %h at time %t", data, $time);
    end else begin
        $display("Read Success: Expected 8'hA5, got %h at time %t", data, $time);
    end

    // Additional write and read cycles
    // Write more data
    address = 8'd1; // Address 1
    data_out = 8'h3C;  // New data to write
    w_r1 = 1;      // Write mode
    #10;           // Wait for a clock cycle

    // Read from the new address
    w_r1 = 0;     // Read mode
    address = 8'd1; // Read from address 1
    oe = 1;       // Output enable on
    #10;           // Wait for a clock cycle
    if (data !== 8'h3C) begin
        $display("Read Error: Expected 8'h3C, got %h at time %t", data, $time);
    end else begin
        $display("Read Success: Expected 8'h3C, got %h at time %t", data, $time);
    end

    // End simulation
    $finish;
end

endmodule
