module REG_Setup (
    clk,
    R,           // Sinal de Reset
    E,           // Sinal de Enable
    SW,     // Entrada dos Switches (8 bits)
    setup // Saída de configuração (8 bits)
);
input clk, R, E;
input wire [7:0]SW;
output reg [7:0]setup;
    always @(posedge clk or posedge R) begin
        if (R) begin
            setup <= 8'b0;   // Reset em 0
        end else if (E) begin
            setup <= SW;    // Carrega o valor dos switches
        end
    end

endmodule