module mux4x1_4 (
    SEL,      
    ENT0,          
    ENT1,          
    ENT2,          
    ENT3,          
    out     
);

    input [1:0] SEL;         
    input [3:0] ENT0;         
    input [3:0] ENT1;          
    input [3:0] ENT2;          
    input [3:0] ENT3;         
    output reg [3:0] out;     

    always @(ENT0 or ENT1 or ENT2 or ENT3 or SEL) begin
        case (SEL)
            2'b00: out = ENT0;
            2'b01: out = ENT1;
            2'b10: out = ENT2;
            2'b11: out = ENT3;
            default: out = 4'b0; 
        endcase
    end

endmodule