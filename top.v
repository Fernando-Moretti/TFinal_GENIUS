module top
(
	CLOCK_50,
	KEY,
	SW, 
	LEDR,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5
);

localparam P_KEY = 4;
localparam P_SW = 10;
localparam P_led = 10;
localparam P_hex = 7;

input wire 	CLOCK_50;
input wire [P_SW-1:0] SW;
input wire [P_KEY-1:0] KEY;

output wire [P_led-1:0] LEDR;
output wire [P_hex-1:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

wire w_r1, w_r2, w_e1, w_e2, w_e3, w_e4;
wire w_end_FPGA, w_end_User, w_end_time;
wire w_win, w_match;

datapath u00(
	.CLOCK_50(CLOCK_50),
	.KEY(KEY),
	.SWITCH(SW[9:2]),
	.R1(w_r1), 
	.R2(w_r2), 
	.E1(w_e1), 
	.E2(w_e2), 
	.E3(w_e3), 
	.E4(w_e4),
	.SEL(w_sel),
	.hex0(HEX0), 
	.hex1(HEX1), 
	.hex2(HEX2), 
	.hex3(HEX3), 
	.hex4(HEX4), 
	.hex5(HEX5),
	.leds(LEDR[9:6]),
	.end_FPGA(w_end_FPGA), 
	.end_User(w_end_User), 
	.end_time(w_end_time), 
	.win(w_win), 
	.match(w_match)
);

controle U01(
	.CLOCK(CLOCK_50), 
	.enter(SW[0]),
	.reset(SW[1]),
	.end_FPGA(w_end_FPGA), .end_User(w_end_User), .end_time(w_end_time),
	.win(w_win),
	.match(w_match),
	.R1(w_r1), .R2(w_r2),
	.E1(w_e1), .E2(w_e2), .E3(w_e3), .E4(w_e4),
	.SEL(w_sel)
);

assign w_r2 = SW[0];
assign w_e2 = SW[1];

endmodule