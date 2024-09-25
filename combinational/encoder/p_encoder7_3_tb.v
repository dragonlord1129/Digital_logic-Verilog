module p_encoder7_3_tb;
    reg [7:0] a_in;
    wire [2:0] a_out;

    p_encoder7_3 uut(
        .a_in(a_in),
        .a_out(a_out)
    );
    initial begin
        a_in = 8'h00;
        $monitor("Time = %0t a_in = %0h a_out = %0b", $time, a_in, a_out);
        #10 a_in = 8'h80;
        #10 a_in = 8'h43;
        #10 a_in = 8'h2F;
        #10 a_in = 8'h18;
        #10 a_in = 8'h08;
        #10 a_in = 8'h04;
        #10 a_in = 8'h02;
        #10 a_in = 8'h01;
    end

    initial begin
        $dumpfile("Priority_Encoder.vcd");
        $dumpvars(0, p_encoder7_3_tb);
    end
    
endmodule