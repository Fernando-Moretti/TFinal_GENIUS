`timescale 1ns/100ps
module top_tb;

reg clk_tb;
initial clk_tb <= 0;

always #10 clk_tb <= ~clk_tb;
reg R_R2, R_E2;
top U00
(
	CLOCK_50(clk_tb),
	KEY(),
	SW({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,R_R2,R_E2}), 
	LEDR(),
	HEX0(),
	HEX1(),
	HEX2(),
	HEX3(),
	HEX4(),
	HEX5()
);


initial begin
 R_R2 = 1;
 R_E2 = 0;
 #5;
  R_R2 = 0;
  R_E2 = 1;
  #1000;
  $stop;
  
end


endmodule

