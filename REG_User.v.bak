module REG_User (
    input clk,
    input R,           // Sinal de Reset
    input E,           // Sinal de Enable
    input [63:0] data,  // Entrada de dados de 64 bits
    output reg [63:0] q  // Saída de dados de 64 bits
);

    always @(posedge clk or posedge R) begin
        if (R) begin
            q <= 64'b0;    // Reset em 0
        end else if (E) begin
            q <= data;
        end
    end

endmodule