module LOGICA (
    input [1:0] REG_SetupLEVEL, // Nível do jogo (2 bits)
    input [3:0] ROUND,          // Número de rodadas (4 bits)
    output reg [7:0] POINTS,      // Pontuação final (8 bits)
	 input [1:0] REG_SetupMAPA
);

    always @(*) begin
        // Calcula Pontos = Nível * Rodadas
        case (REG_SetupLEVEL)
            2'b01: POINTS = 8'd1 * ROUND;   // Nível 1
            2'b10: POINTS = 8'd2 * ROUND;   // Nível 2
            2'b11: POINTS = 8'd3 * ROUND;   // Nível 3
            default: POINTS = 8'd0;         // Nível 0 (default) - pontuação zero 
        endcase
    end

endmodule