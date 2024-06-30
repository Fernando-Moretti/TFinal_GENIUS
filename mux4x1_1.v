module MUX4X1_1bit (
    input [1:0] level,        // Sinal de seleção de 2 bits (00, 01, 10, 11)
    input CL1,             // Entrada 0 (1 bit)
    input CL2,             // Entrada 1 (1 bit)
    input CL3,             // Entrada 2 (1 bit)
    input CL4,             // Entrada 3 (1 bit)
    output reg CLKHZ        // Saída (1 bit)
);

    always @(*) begin
        case (level)
            2'b00: CLKHZ = CL1;
            2'b01: CLKHZ = CL2;
            2'b10: CLKHZ = CL3;
            2'b11: CLKHZ = CL4;
            default: CLKHZ = 1'b0;  // Valor 'x' para caso default (opcional)
        endcase
    end

endmodule