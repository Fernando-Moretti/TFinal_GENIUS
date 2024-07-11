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
	match,
	SEQFPGA
);


input wire CLOCK_50, R1, R2, E1, E2, E3, E4, SEL;
input wire [3:0] KEY; 
input wire [7:0] SWITCH;

output wire [3:0] leds;
output wire [6:0] hex0, hex1, hex2, hex3, hex4, hex5;
output wire end_FPGA, end_User, end_time, win, match;
output wire[3:0] SEQFPGA;

wire [7:0]SETUP;
wire w_win;
assign win = w_win;
wire [6:0]w_mux2x1_hex5;
wire [6:0]w_mux2x1_hex4;
wire [6:0]w_mux2x1_hex3;
wire [6:0]w_mux2x1_hex2;
wire [6:0]w_mux2x1_hex1;
wire [6:0]w_mux2x1_hex0;

//buttosnync
wire [3:0] NBTN;
//NBTN INSTANCIADO NO COUNTER USER
wire b1, b2, b3, b4;



ButtonSync buttonSYNC(
.KEY0(KEY[0]), .KEY1(KEY[1]), .KEY2(KEY[2]), .KEY3(KEY[3]), .CLK(CLOCK_50),
	.BTN0(b1), .BTN1(b2), .BTN2(b3), .BTN3(b4)

);
assign NBTN[0] = ~b1;
assign NBTN[1] = ~b2;
assign NBTN[2] = ~b3;
assign NBTN[3] = ~b4;


//COMP
 wire [63:0]OUT_USER;
 wire [63:0]OUT_FPGA;
 wire END_User;
 assign match = ((OUT_FPGA == OUT_USER) & END_User) ? 1'b1 : 1'b0;

//hex5
mux2x1 HEX5_1(
	.a_i(7'b1000_111), //U
	.b_i(7'b1011_011), //F 
	.sel_i(w_win),
	.d_o(w_mux2x1_hex5)
);

mux2x1 HEX5_2(
	.a_i(w_mux2x1_hex5), //L
	.b_i(7'b0001_110),
	.sel_i(SEL),
	.d_o(hex5[6:0])
);
  
//hex4

wire [6:0]w_hex4_dec;
mux2x1 HEX4_2(
	.a_i(7'b1011_011), //S
	.b_i(7'b1100_111), //P
	.sel_i(w_win),
	.d_o(w_mux2x1_hex4[6:0])
);

segDisplay HEX4_DISPLAY(
    .b({2'b00,SETUP[7:6]}),    //'00' & setup[7:6]
    .d(w_hex4_dec[6:0])
);

mux2x1 HEX4_1(
	.a_i(w_mux2x1_hex4[6:0]), 
	.b_i(w_hex4_dec[6:0]),
	.sel_i(SEL),
	.d_o(hex4[6:0])
);

//hex3
mux2x1 HEX3_1(
	.a_i(7'b1001_111),  //E
	.b_i(7'b1111_011),  //g
	.sel_i(w_win),
	.d_o(w_mux2x1_hex3[6:0])
);

mux2x1 HEX3_2(
	.a_i(w_mux2x1_hex3[6:0]), 
	.b_i(7'b0001_111),//t
	.sel_i(SEL),
	.d_o(hex3[6:0])
);

//hex2
wire [3:0]TIME;
wire [6:0]w_hex2_dec;
mux2x1 HEX2_1(
	.a_i(7'b1011_011),  //r
	.b_i(7'b1100_111), //A
	.sel_i(w_win),
	.d_o(w_mux2x1_hex2[6:0])
);

segDisplay HEX2_DISPLAY(
    .b(TIME[3:0]),  //TIME
    .d(w_hex2_dec[6:0])
);

mux2x1 HEX2_2(
	.a_i(w_hex2_dec[6:0]), 
	.b_i(w_mux2x1_hex2[6:0]),
	.sel_i(SEL),
	.d_o(hex2[6:0])
);

//hex1
wire [6:0]w_hex1_dec;
wire [7:0]POINTS;
mux2x1 HEX1(
	.a_i(w_hex1_dec[6:0]), 
	.b_i(7'b0000_101), //r
	.sel_i(SEL),
	.d_o(hex1[6:0])
);

segDisplay HEX1_DISPLAY(
    .b(POINTS[7:4]),  //points[7:4]
    .d(w_hex1_dec[6:0])
);

//hex0
wire [6:0]w_hex0_dec;
wire [6:0]w_hex0_dec_2;
wire [3:0]ROUND;
mux2x1 HEX0(
	.a_i(w_hex0_dec[6:0]), 
	.b_i(w_hex0_dec_2[6:0]), 
	.sel_i(SEL),     
	.d_o(hex0[6:0])
);
segDisplay HEX0_DISPLAY1(
    .b(ROUND[3:0]), //round
    .d(w_hex0_dec_2[6:0])
);

segDisplay HEX0_DISPLAY2(
    .b(POINTS[3:0]), //points[3:0]
    .d(w_hex0_dec[6:0])
);

// COUNTERS
Counter_time  Time (    
	 .CLKT(CLOCK_50), //? CLOCK_1Hz
	 .R(R2), 
	 .E(E2), 
	 .TEMPO(TIME),
	 .end_time(end_time)
);


counterGENERAL Round(
.data(SETUP[3:0]),
.R(R1),
.E(E4),
.CLKT(CLOCK_50),
.CONTADOR(ROUND[3:0]),
.REGISTRADOR(win)

);


wire [3:0] SEQFPGA_seq;

Counter_FPGA FPGA(
	.data(ROUND[3:0]),
	.clk(CLOCK_50), // CLOCK_50
	.R(R2),
	.E(E3),
	.end_FPGA(end_FPGA),
	.SEQFPGA(SEQFPGA_seq)
);


wire and1;
wire or1;

or (or1,NBTN[0],NBTN[1],NBTN[2],NBTN[3]);
and (and1,or1,E2);

wire [3:0]SEQUSER;
counterGENERAL User(
.data(ROUND[3:0]),
.R(R2),
.E(and1), //fazer uma wire com um processo de AND E OR
.CLKT(CLOCK_50),
.REGISTRADOR(end_user),
.CONTADOR(SEQUSER)
);


wire [3:0]SEQMUX00;
wire [3:0]SEQMUX01;
wire [3:0]SEQMUX10;
wire [3:0]SEQMUX11;


decSeq00 SEQ1(
 .address(SEQFPGA_seq[3:0]),
 .saida(SEQMUX00[3:0])
);

decSeq01 SEQ2(
 .address(SEQFPGA_seq[3:0]),
 .saida(SEQMUX01[3:0])
);

decSeq10 SEQ3(
 .address(SEQFPGA_seq[3:0]),
 .saida(SEQMUX10[3:0])
);

decSeq11 SEQ4(
 .address(SEQFPGA_seq[3:0]),
 .saida(SEQMUX11[3:0])
 
);
wire [3:0]SEQ_FPGA;
mux4x1_4 muxFPGA(
 .SEL(SETUP[5:4]),
 .ENT0(SEQMUX00[3:0]),
 .ENT1(SEQMUX01[3:0]),
 .ENT2(SEQMUX10[3:0]),
 .ENT3(SEQMUX11[3:0]),
 .out(SEQ_FPGA[3:0])
);

//REG_USER

wire and2;
wire or2;

or(or2,NBTN[0],NBTN[1],NBTN[2],NBTN[3]);
and(and2,or2,E2);

REG_User regUSER(
	 .clk(CLOCK_50),
    .R(R2),           
    .E(and2),          
    .data({NBTN[3:0], OUT_USER[63:4]}),  
    .q(OUT_USER[63:0])  
);	


//REG_FPGA
wire CLKHZ;
REG_FPGA regFPGA(
    .clk(CLKHZ),
    .R(R2),           
    .E(E3),          
    .data({SEQ_FPGA[3:0],OUT_FPGA[63:4]}),  
    .q(OUT_FPGA[63:0]),  
    .q3()  

);

//REG_Setup
REG_Setup regSetup(
    .clk(CLOCK_50),
    .R(R1),           
    .E(E1),           
    .SW(SWITCH[7:0]),   //9:2  
    .setup(SETUP[7:0])
);
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
 
 mux4X1_1 muxFSM(
     .level(SETUP[7:6]),     
    .CL1(clk_25),            
    .CL2(clk_05),             
    .CL3(clk_1),             
    .CL4(clk_2),             
    .CLKHZ(CLKHZ)   
 );

//LOGICA
LOGICA Logica(
    .REG_SetupLEVEL(SETUP[7:6]), 
    .ROUND(ROUND[3:0]),          
    .POINTS(POINTS[7:0]),
	 .REG_SetupMAPA(SETUP[5:4])
);

//LEDR
wire [3:0]LEDR_key;
assign LEDR_key[0] = ~OUT_FPGA;
assign LEDR_key[1] = ~OUT_FPGA;
assign LEDR_key[2] = ~OUT_FPGA;
assign LEDR_key[3] = ~OUT_FPGA;
 
assign LEDS = {OUT_FPGA[63:60], LEDR_key[3:0]};

endmodule

