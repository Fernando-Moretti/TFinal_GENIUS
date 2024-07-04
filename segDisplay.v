
	
	module segDisplay (b, d);
	
	input [3:0] b;
	output [6:0] d;
	
	reg [6:0] d;
	
	always begin
		case(b)
		4'b0000: d = 7'b1000000;
		4'b0001: d = 7'b1111001;
		4'b0010: d = 7'b0100100;
		4'b0011: d = 7'b0110000;
		4'b0100: d = 7'b0011001;
		4'b0101: d = 7'b0010010;
		4'b0110: d = 7'b0110010;
		4'b0111: d = 7'b1111000;
		4'b1000: d = 7'b0000000;
		4'b1001: d = 7'b0010000;
		default: d = 7'b1111111;

		endcase
	end
endmodule
