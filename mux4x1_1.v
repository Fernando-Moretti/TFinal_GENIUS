module mux4X1_1(
    level,     
    CL1,            
    CL2,             
    CL3,             
    CL4,             
    CLKHZ        
);
input wire [1:0] level;
input wire CL1, CL2, CL3, CL4;
output reg CLKHZ;

    always @(CL1 or CL2 or CL3 or CL4 or level) begin
        case (level)
            2'b00: CLKHZ = CL1;
            2'b01: CLKHZ = CL2;
            2'b10: CLKHZ = CL3;
            2'b11: CLKHZ = CL4;
            default: CLKHZ = 1'b0;
        endcase
    end

endmodule
