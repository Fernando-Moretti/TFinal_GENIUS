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


input wire CLOCK_50, R1, R2, E1, E2, E3, E4, SEL;
input wire [3:0] KEY; 
input wire [9:0] SWITCH;

output wire [3:0] leds;
output wire [6:0] hex0, hex1, hex2, hex3, hex4, hex5;
output wire end_FPGA, end_User, end_time, win, match;

wire [7:0]SETUP;
wire w_win;
wire w_mux2x1_hex5;
wire w_mux2x1_hex4;
wire w_mux2x1_hex3;
wire w_mux2x1_hex2;
wire w_mux2x1_hex1;
wire w_mux2x1_hex0;

//hex5
mux2x1 hex5_1(
	.a_i(7'b100_0111), //F
	.b_i(7'b011_1110), //U 
	.sel_i(w_win),
	.d_o(w_mux2x1_hex5)
);

mux2x1 hex5_2(
	.a_i(7'b000_1110), //L
	.b_i(w_mux2x1_hex5), //mux
	.sel_i(SEL),
	.d_o(hex5)
);

//hex4
mux2x1 hex4_1(
	.a_i(7'b011_1000), //P
	.b_i(7'b011_1000),  //S
	.sel_i(w_win),
	.d_o(w_mux2x1_hex4)
);

mux2x1 hex4_2(
	.a_i(w_hex4_dec), 
	.b_i(w_mux2x1_hex4),
	.sel_i(SEL),
	.d_o(hex4)
);

segDisplay hex4_3(
    .b(7'b0000_000,SETUP[7:6]),    //'00' & setup[7:6]
    .d(w_hex4_dec)
);

//hex3
mux2x1 hex3_1(
	.a_i(7'b011_1000), //g
	.b_i(7'b011_1000), //E
	.sel_i(w_win),
	.d_o(w_mux2x1_hex3)
);

mux2x1 hex3_2(
	.a_i(7'b011_1000), //t
	.b_i(w_mux2x1_hex3),
	.sel_i(SEL),
	.d_o(hex3)
);

//hex2
mux2x1 hex2_1(
	.a_i(7'b011_1000), //A
	.b_i(7'b011_1000), //r
	.sel_i(w_win),
	.d_o(w_mux2x1_hex2)
);

mux2x1 hex2_2(
	.a_i(w_hex2_dec), 
	.b_i(w_mux2x1_hex2),
	.sel_i(SEL),
	.d_o(hex2)
);

segDisplay hex2_3(
    .b(4'b0000),  //TIME
    .d(w_hex2_dec)
);

//hex1
mux2x1 hex1_1(
	.a_i(7'b011_1000), //r
	.b_i(w_hex1_dec), 
	.sel_i(SEL),
	.d_o(hex1)
);

segDisplay hex1_2(
    .b(),  //points[7:4]
    .d(w_hex1_dec)
);

//hex0
mux2x1 hex0_1(
	.a_i(w_hex0_dec_2), 
	.b_i(w_hex0_dec), 
	.sel_i(SEL),     
	.d_o(hex0)
);

segDisplay hex0_2(
    .b(), //round
    .d(w_hex0_dec_2)
);

segDisplay hex0_3(
    .b(), //points[3:0]
    .d(w_hex0_dec)
);
/////////////////////////////////////

wire [2:0] w_TEMPO;
wire w_end_time;
wire [3:0]ROUND;


counterGENERAL Timer(
	 .CLKT(CLOCK_50), 
	 .R(R2), 
	 .E(E2), 
	 .CONTADOR(),
	 .REGISTRADOR(),
	 .data()
);
counterGENERAL Round(
.data(SETUP[3:0]),
.R(R1),
.E(E4),
.CLKT(CLOCK_50),
.CONTADOR(ROUND)

);
wire w_end_user;
assign w_end_user = end_User;
wire w_E;

wire and1;
wire or1;

and (and1,or1,E2);
or (or1,NBTN,or1);

counterGENERAL User(
.data(ROUND[3:0]),
.R(R2),
.E(and1), //fazer uma wire com um processo de AND E OR
.CLKT(CLOCK_50),
.REGISTRADOR(w_end_user)
);
wire w_end_FPGA;
assign w_end_FPGA = end_FPGA;

wire [3:0]SEQFPGA;
counterGENERAL FPGA(
.CLKT(CLKHZ),
.R(R2),
.E(E3),
.data(ROUND[3:0]),
.CONTADOR(SEQFPGA[3:0]),
.REGISTRADOR(w_end_FPGA)
);

wire [5:0] SETUPMUX;
mux4x1_4 muxFPGA(
 .SEL(SETUPMUX[5:4]),
 .ENT0(SEQMUX00),
 .ENT1(SEQMUX01),
 .ENT2(SEQMUX10),
 .ENT3(SEQMUX11),
 .out(SEQFPGA)
);

wire SEQMUX00;
decSeq00 SEQ1(
 .address(SEQFPGA),
 .saida(SEQMUX00)
);

wire SEQMUX01;
decSeq01 SEQ2(
 .address(SEQFPGA),
 .saida(SEQMUX01)
);

wire SEQMUX10;
decSeq10 SEQ3(
 .address(SEQFPGA),
 .saida(SEQMUX10)
);

wire SEQMUX11;
decSeq11 SEQ4(
 .address(SEQFPGA),
 .saida(SEQMUX11)
 
);
//LOGICA
LOGICA Logica(
    .REG_SetupLEVEL(SETUP[7:6]), 
    .ROUND(ROUND[3:0]),          
    .POINTS(POINTS[7:0]),
	 .REG_SetupMAPA(SETUP[5:4])
);
//REG_USER
REG_Setup regSetup(
    .clk(CLOCK_50),
    .R(R1),           
    .E(R1),           
    .SW(SWITCH[9:2]),     
    .setup(SETUP[7:0])
);
//REG_FPGA
wire [63:0]OUT_FPGA;
wire [63:0]SUM_DATA;
assign SUM_DATA[63:0] = {SEQFPGA[3:0], OUT_FPGA[63:4]}; //COMBINAÇÃO DESSES SINAIS EM UM UNICO VETOR
REG_FPGA regFPGA(
    .clk(CLKHZ),
    .R(R2),           
    .E(E3),          
    .data(SUM_DATA[63:0]),  
    .q(OUT_FPGA[63:0]),  
    .q3()  

);

//buttosnync
wire [3:0]BTN;
wire [3:0]NBTN;
assign NBTN[3:0] = ~BTN[3:0];

ButtonSynch BtSynch(
    .a_i(KEY),
    .d_o(BTN)
);
	
	
//REG_USER
wire [63:0]OUT_USER;
wire and2;
wire or2;

or(or2,NBTN,or2);
and(and2,E2,or2);

wire [63:0]SUM_USER;
assign SUM_USER[63:0] = {NBTN[3:0], OUT_USER[63:4]};

REG_User regUSER(
	 .clk(CLOCK_50),
    .R(R2),           
    .E(and2),          
    .data(SUM_USER[63:0]),  
    .q(OUT_USER[63:0])  
);	

	
//COMP
 wire to_endUSER;
 and (match, (OUT_FPGA == OUT_USER), end_User);

	
 //FSM CLOCK 
 wire clk_25,clk_05,clk_1,clk_2;
 FSM_clock clock_FSM(
    .reset(R1),
    .CLOCK_50(CLOCK_50),
    .C025Hz(clk_25),
    .C05Hz(clk_05),
    .C1Hz(clk_1),
    .C2Hz(clk_2)
 );


	
endmodule
