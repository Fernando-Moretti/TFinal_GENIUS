module decSeq00 (
    address,  
    saida
);
	input [3:0]address;
	output reg [3:0]saida;
    always @(address) begin
        saida = 4'b0001; 
    end

endmodule