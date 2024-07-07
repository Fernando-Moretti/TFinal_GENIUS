module REG_FPGA (
    input clk,
    input R,           // Sinal de Reset
    input E,           // Sinal de Enable
    input [63:0] data,  // Entrada de dados de 64 bits
    output reg [63:0] q,  // Saída de dados de 64 bits
    output reg [3:0] q3   // Saída dos 4 bits mais significativos (q[63:60])
);

    always @(posedge clk or posedge R) begin
        if (R) begin
            q <= 64'b0;    // Reset em 0
            q3 <= 4'b0;   // Reset em 0
        end else if (E) begin
            q <= data;
            q3 <= data[63:60]; // Atribui os 4 bits mais significativos
        end 
    end

endmodule 