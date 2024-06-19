module decSeq00 (
    input [3:0] address,  // Entrada de endereço (não utilizada neste módulo)
    output reg [3:0] saida
);

    always @(*) begin
        saida = 4'b0001; // Saída fixa para qualquer endereço
    end

endmodule