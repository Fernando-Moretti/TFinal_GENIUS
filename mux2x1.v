module mux2x1
(
	a_i,
	b_i,
	sel_i,
	d_o
);

input [6:0]a_i;
input wire  [6:0]b_i;
input wire sel_i;
output reg [6:0]d_o;

always @(a_i or b_i or sel_i)
begin
	if(sel_i == 1)
		d_o <= a_i;
	else
		d_o <= b_i;
end

endmodule

