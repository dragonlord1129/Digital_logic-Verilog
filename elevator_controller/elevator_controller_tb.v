module elevator_controller_tb;
    reg clk;
    reg rst;
    reg [4:0] floor_req;
    wire [4:0] floor_pos;

    elevator_controller uut (
        .clk(clk),
        .rst(rst),
        .floor_req(floor_req),
        .floor_pos(floor_pos)
    );
    always #5 clk = ~clk;
initial begin
        $dumpfile("elevator.vcd");
        $dumpvars(0, elevator_controller_tb);

        clk = 1'b0;
        rst = 1'b1;
        floor_req = 5'b00000;
        #10 rst = 1'b0; 
        #10 floor_req = 5'b00100; // request floor 3
        #100 floor_req = 5'b00010; // request floor 2
        #100 floor_req = 5'b01000; // request floor 4
        #100 floor_req = 5'b00001; // request floor 1
        #100 floor_req = 5'b11010; // request floor 5
        #1000;
        $finish; 
end
endmodule