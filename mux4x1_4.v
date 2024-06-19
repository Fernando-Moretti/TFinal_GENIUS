module MUX4X1_4bits (
    input [1:0] sel,         // Sinal de seleção de 2 bits 
    input [3:0] in0,          // Entrada 0 (4 bits)
    input [3:0] in1,          // Entrada 1 (4 bits)
    input [3:0] in2,          // Entrada 2 (4 bits)
    input [3:0] in3,          // Entrada 3 (4 bits)
    output reg [3:0] out     // Saída (4 bits)
);

    always @(*) begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = 4'b0; 
        endcase
    end

endmodule