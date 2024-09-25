module fourbitcomparator (
    input [3:0] A,
    input [3:0] B,

    output reg [1:0] flag
);
    reg less, equal, greater;
    always @(*) begin
        if(A>B) begin
            less = 0;
            equal = 0;
            greater = 1;
        end else if (A<B) begin 
            less = 1;
            equal = 0;
            greater = 0;
            
        end else begin            
            less = 0;
            equal = 1;
            greater = 0;
        end 
    end
    always @(less , equal , greater) begin
        case ({less, equal, greater})
            3'b001 : flag = 2'b01; // '01' represents greater
            3'b010 : flag = 2'b10; // '10' represents equal
            3'b100 : flag = 2'b11; // '11' represents smaller
            default : flag = 2'b00; // '00' for no change in input to indicate no operation has happened                
        endcase
    end
    
endmodule