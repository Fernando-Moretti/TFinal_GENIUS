module LOGICA (
    REG_SetupLEVEL, 
    ROUND,          
    POINTS,
	 REG_SetupMAPA
);
input [1:0]REG_SetupLEVEL, REG_SetupMAPA;
input [3:0]ROUND;
output reg [7:0]POINTS;

    always @(posedge REG_SetupLEVEL or posedge ROUND) begin
        // Calculo dos Pontos = N�vel * Rodadas
        case (REG_SetupLEVEL)
            2'b01: POINTS = 8'd1 * ROUND;   // N�vel 1
            2'b10: POINTS = 8'd2 * ROUND;   // N�vel 2
            2'b11: POINTS = 8'd3 * ROUND;   // N�vel 3
            default: POINTS = 8'd0;
        endcase
    end

endmodule
