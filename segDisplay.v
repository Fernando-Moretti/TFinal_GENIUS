
	
	module segDisplay (b, d);
	
	input wire [3:0] b;
	output reg[6:0] d;
	
	
	
	always@(b) begin
		case(b)
		  4'h0 : d = ~7'b011_1111;   
				4'h1 : d = ~7'b000_0110;   
				4'h2 : d = ~7'b101_1011;
				4'h3 : d = ~7'b100_1111;
				4'h4 : d = ~7'b110_0110;
				4'h5 : d = ~7'b110_1101;
				4'h6 : d = ~7'b111_1101;
				4'h7 : d = ~7'b000_0111;
				4'h8 : d = ~7'b111_1111;
				4'h9 : d = ~7'b110_1111;
				4'hA : d = ~7'b111_0111;
				4'hB : d = ~7'b111_1100;
				4'hC : d = ~7'b011_1001;
				4'hD : d = ~7'b101_1110;
				4'hE : d = ~7'b111_1001;
				4'hF : d = ~7'b111_0001;
           default: d = ~7'b100_0000;

		endcase
	end
endmodule

