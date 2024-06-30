module MUX4X1_4bits (
    input [1:0] SEL,         // Sinal de seleção de 2 bits 
    input [3:0] ENT0,          // Entrada 0 (4 bits)
    input [3:0] ENT1,          // Entrada 1 (4 bits)
    input [3:0] ENT2,          // Entrada 2 (4 bits)
    input [3:0] ENT3,          // Entrada 3 (4 bits)
    output reg [3:0] out     // Saída (4 bits)
);

    always @(*) begin
        case (SEL)
            2'b00: out = ENT0;
            2'b01: out = ENT1;
            2'b10: out = ENT2;
            2'b11: out = ENT3;
            default: out = 4'b0; 
        endcase
    end

endmodule