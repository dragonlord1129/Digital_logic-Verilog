module ram (
    clk,
    address,
    oe,
    w_r1,
    cs,
    data
);
//...Parameter width...
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;
    parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//...input ports...
    input clk, w_r1, oe, cs;
    input [ADDR_WIDTH-1:0] address;

//...inout ports...
    inout [DATA_WIDTH-1:0] data;

//...internal variables...
    reg [DATA_WIDTH-1:0] data_out;
    reg [DATA_WIDTH-1:0] mem[0: RAM_DEPTH-1];

// Drive the data output based on control signals
assign data = (cs && !w_r1 && oe) ? data_out : {DATA_WIDTH{1'bz}}; // output when cs = 1, w_r1 = 0, oe = 1

always @(posedge clk) begin 
    if (cs) begin
        if (w_r1) begin // Memory write
            mem[address] <= data; // data is driven from the testbench
        end else begin // Memory read
            data_out <= mem[address]; // Read the data into data_out
        end
    end
end

endmodule
