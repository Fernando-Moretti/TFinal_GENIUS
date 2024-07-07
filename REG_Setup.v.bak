module REG_Setup (
    input clk,
    input R,           // Sinal de Reset
    input E,           // Sinal de Enable
    input [7:0] SW,     // Entrada dos Switches (8 bits)
    output reg [7:0] setup // Saída de configuração (8 bits)
);

    always @(posedge clk or posedge R) begin
        if (R) begin
            setup <= 8'b0;   // Reset em 0
        end else if (E) begin
            setup <= SW;    // Carrega o valor dos switches
        end
    end

endmodule