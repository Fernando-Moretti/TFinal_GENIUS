module mux2x1
(
	a_i,
	b_i,
	sel_i,
	d_o
);

input a_i;
input wire  b_i;
input wire sel_i;
output reg d_o;

always @(a_i or b_i or sel_i)
begin
	if(sel_i == 1)
		d_o <= a_i;
	else
		d_o <= b_i;
end

endmodule
