module datapath(
	CLOCK_50,
	KEY,
	SWITCH,
	R1, 
	R2, 
	E1, 
	E2, 
	E3, 
	E4,
	SEL,
	hex0, 
	hex1, 
	hex2, 
	hex3, 
	hex4, 
	hex5,
	leds,
	end_FPGA, 
	end_User, 
	end_time, 
	win, 
	match
);

parameter p_key = 4;
parameter p_counter_tempo = 4;
parameter p_switch = 8;
parameter p_hex = 7;
parameter p_led = 4;

input wire CLOCK_50, R1, R2, E1, E2, E3, E4, SEL;
input wire [p_key - 1:0] KEY; 
input wire [p_switch - 1:0] SWITCH;

output wire [p_led - 1:0] leds;
output wire [p_hex - 1:0] hex0, hex1, hex2, hex3, hex4, hex5;
output wire end_FPGA, end_User, end_time, win, match;

wire w_win;
wire w_mux2x1_hex5;

//hex5
mux2x1 U01(
	.a_i(7'b011_1000), ///mudar numeros
	.b_i(7'b011_1000), //mudar numeros
	.sel_i(w_win),
	.d_o(w_mux2x1_hex5)
);

mux2x1 U00(
	.a_i(7'b011_1000),
	.b_i(w_mux2x1_hex5),
	.sel_i(SEL),
	.d_o(hex5)
);

//hex4
//hex3
mux2x1 Uhex03(
	.a_i(7'b011_1000), ///mudar numeros
	.b_i(7'b011_1000), //mudar numeros
	.sel_i(w_win),
	.d_o(w_mux2x1_hex3)
);

mux2x1 Uhex03_1(
	.a_i(7'b011_1000), ///mudar numeros
	.b_i(w_mux2x1_hex3),
	.sel_i(SEL),
	.d_o(hex3)
);

//hex2
//hex1
mux2x1 Uhex01(
	.a_i(7'b000_0000), ///mudar numero
	.b_i(w_hex1_dec), 
	.sel_i(SEL),
	.d_o(hex1)
);

segDisplay hex1_D1(
    .b(),  //points[7:4}
    .d(w_hex1_dec)
);

//hex0///////////////////////////////
mux2x1 Uhex00(
	.a_i(w_hex0_dec_2), 
	.b_i(w_hex0_dec), 
	.sel_i(SEL),     
	.d_o(hex0)
);

segDisplay hex0_D2(
    .b(), //round
    .d(w_hex0_dec_2)
);

segDisplay hex0_D1(
    .b(), //points[3:0]
    .d(w_hex0_dec)
);
/////////////////////////////////////
wire [p_counter_tempo-1:0] w_TEMPO;
wire w_end_time;

counterTime U02 (
	 .CLKT(CLOCK_50), 
	 .R(R2), 
	 .E(E2), 
	 .TEMPO(),
	 .end_time()
);

endmodule