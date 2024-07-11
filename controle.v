module controle(
CLOCK, enter,
reset, end_FPGA, end_User, end_time, win, match,
R1, R2, E1, E2, E3, E4, SEL
);

input wire CLOCK, enter, reset, end_FPGA, end_User, end_time, win, match; 
output reg R1, R2, E1, E2, E3, E4, SEL;
 
localparam NSTATES = 3;
localparam [NSTATES-1:0]Init       = 3'h0, 
								Setup      = 1,
								Play_FPGA  = 3'o2,
								Play_User  = 3'b011,
								Check      = 3'b100,
								Next_Round = 3'b101,
								Result     = 3'b110;

reg [NSTATES-1:0] state;								
reg [NSTATES-1:0] next_state;

always@ (posedge CLOCK) begin
	if (reset) state <= Init;
	else state = next_state;
end

always@ (enter or end_FPGA or end_User or end_time or win or match or state)	begin
	next_state = state;
	case(state)
		Init: 
			begin
			next_state = Setup;
			end
		Setup: 
			begin
				if (enter == 1'b1) next_state = Play_FPGA; 
			end
		Play_FPGA: 
			begin 
				if (end_FPGA) next_state = Play_User;
			end
		Play_User: 
			begin 
				if (end_time == 1'b1) next_state = Result;
				else if (end_User == 1'b1) next_state = Check;
				else next_state = Play_User;
			end
		Check: 
		begin
			if (match == 1'b1) next_state = Next_Round;
			else next_state = Result;
		end
		Next_Round: 
			begin
				if (win == 1'b1) next_state = Result;
				else next_state = Play_FPGA;
			end
		Result: next_state = Result;
		
	endcase
end	
always@(state) begin
	R1 = 1'b0; R2 = 1'b0; E1 = 1'b0; E2 = 1'b0; E3 = 1'b0; E4 = 1'b0; SEL = 1'b0;
	
	case(state)
		Init: begin R1 = 1'b1; R2 = 1'b1; E1 = 1'b0; E2 = 1'b0; E3 = 1'b0; E4 = 1'b0; SEL = 1'b0; end	
		Setup: begin R1 = 1'b0; R2 = 1'b0; E1 = 1'b1; E2 = 1'b0; E3 = 1'b0; E4 = 1'b0; SEL = 1'b0; end
		Play_FPGA:	begin R1 = 1'b0; R2 = 1'b0; E1 = 1'b0; E2 = 1'b0; E3 = 1'b1; E4 = 1'b0; SEL = 1'b0; end	
		Play_User: begin R1 = 1'b0; R2 = 1'b0; E1 = 1'b0; E2 = 1'b1; E3 = 1'b0; E4 = 1'b0; SEL = 1'b0; end		
		Check: 	begin R1 = 1'b0; R2 = 1'b0; E1 = 1'b0; E2 = 1'b0; E3 = 1'b0; E4 = 1'b1; SEL = 1'b0; end	
		Next_Round:	 begin R1 = 1'b0; R2 = 1'b1; E1 = 1'b0; E2 = 1'b0; E3 = 1'b0; E4 = 1'b0; SEL = 1'b0; end	
		Result:	begin R1 = 1'b0; R2 = 1'b0; E1 = 1'b0; E2 = 1'b0; E3 = 1'b0; E4 = 1'b0; SEL = 1'b1; end			
	endcase
end

endmodule   
