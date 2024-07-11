module FSM_clock(
	reset,
	CLOCK_50,
	C025Hz,
	C05Hz,
	C1Hz,
	C2Hz
);

input wire reset,  CLOCK_50;
output reg C025Hz, C05Hz, C1Hz, C2Hz;
 
reg [27:0] r_C025Hz; reg [27:0] r_C05Hz; 
reg [27:0] r_C2Hz;  reg [27:0] r_C1Hz; 

initial C1Hz <= 0;
initial r_C1Hz <= 0;
//50*10^6 / 2*0,25 = 100.000.000
//C025Hz
always @(posedge CLOCK_50 or posedge reset)
begin
	if(reset == 1'b1)
	begin
		C025Hz <= 1'b0;
		r_C025Hz <= 28'h0000000;
	end
	else 
	begin
		r_C025Hz <= r_C025Hz + 1'b1;
		if (C025Hz == 28'h5F5E100)
		begin
			r_C025Hz <= 28'h0000000;
			C025Hz <= ~C025Hz;
		end
	end
end

//50*10^6 / 2*2 = 12.500.000
//C2Hz
always @(posedge CLOCK_50 or posedge reset)
begin
  if(reset == 1'b1)
	begin
		C2Hz <= 1'b0;
		r_C2Hz <= 28'h0000000;
	end
	else
	begin
		r_C2Hz <= r_C2Hz + 1'b1;
		if (C2Hz == 28'h0BEBC1F)
		begin
			r_C2Hz <= 28'h0000000;
			C2Hz <= ~C2Hz;
		end
	end
end

//50*10^6 / 2*1 = 25.000.000
//C1Hz
always @(posedge CLOCK_50 or posedge reset)
begin
	if(reset == 1'b1)
	begin
		C1Hz <= 1'b0;
		r_C1Hz <= 28'h0000000;
	end
	else 
	begin
		r_C1Hz <= r_C1Hz + 1'b1;
		if (C1Hz == 28'h17D_783F)
		begin
			r_C1Hz <= 28'h0000000;
			C1Hz <= ~C1Hz;
		end
	end
end

//50*10^6 / 2*0,5 = 50.000.000
//C05Hz
always @(posedge CLOCK_50 or posedge reset)
begin
	if(reset == 1'b1)
	begin
		C05Hz <= 1'b0;
		r_C05Hz <= 28'h0000000;
	end
	else 
	begin
		r_C05Hz <= r_C05Hz + 1'b1;
		if (C05Hz == 28'h2FAF080)
		begin
			r_C05Hz <= 28'h0000000;
			C05Hz <= ~C05Hz;
		end
	end
end

endmodule