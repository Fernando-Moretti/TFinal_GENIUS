// Button Press Synchronizer para keys que são ativas baixas (ou seja, quando pressionadas vao para nivel baixo)

module ButtonSync (
	KEY0, KEY1, KEY2, KEY3, CLK,
	BTN0, BTN1, BTN2, BTN3

);

input wire  KEY0, KEY1, KEY2, KEY3, CLK;
output reg	BTN0, BTN1, BTN2, BTN3;

reg [1:0] btn0state, btn1state, btn2state, btn3state;
reg [1:0] btn0next, btn1next, btn2next, btn3next;
		
localparam EsperaApertar = 2'b00, SaidaAtiva = 2'b01, EsperaSoltar = 2'b10;

// NAO CONVENCINAL
initial begin
	btn0state <= EsperaApertar; btn1state <= EsperaApertar; btn2state <= EsperaApertar; btn3state <= EsperaApertar;
	btn0next <= EsperaApertar; btn1next <= EsperaApertar; btn2next <= EsperaApertar; btn3next <= EsperaApertar; 
end
		
always@(posedge CLK)
begin
	btn0state <= btn0next;
	btn1state <= btn1next;
	btn2state <= btn2next;
	btn3state <= btn3next;
end


always @ (KEY0 or btn0state) begin
	case (btn0state)
		EsperaApertar: begin
			if (KEY0 == 0) btn0next <= SaidaAtiva; 
			else	btn0next <= EsperaApertar;
		end
		
		SaidaAtiva:begin
			if (KEY0 == 0) btn0next <= EsperaSoltar; 
			else btn0next <= EsperaApertar; 
		end
			
		EsperaSoltar:begin
			if (KEY0 == 0) btn0next <= EsperaSoltar;	
			else btn0next <= EsperaApertar;
		end		
	endcase
end	

always @ (btn0state) begin
	case (btn0state)
		EsperaApertar:
			BTN0 <= 1'b1;
		SaidaAtiva:
			BTN0 <= 1'b0;
		EsperaSoltar:
			BTN0 <= 1'b1;
	endcase
end	

always @ (KEY1 or btn1state) begin
	case (btn1state)
		EsperaApertar: begin
			if (KEY1 == 0) btn1next <= SaidaAtiva; 
			else	btn1next <= EsperaApertar;
		end
		
		SaidaAtiva:begin
			if (KEY1 == 0) btn1next <= EsperaSoltar; 
			else btn1next <= EsperaApertar; 
		end
			
		EsperaSoltar:begin
			if (KEY1 == 0) btn1next <= EsperaSoltar;	
			else btn1next <= EsperaApertar;
		end		
	endcase
end	

always @ (btn1state) begin
	case (btn1state)
		EsperaApertar:
			BTN1 <= 1'b1;
		SaidaAtiva:
			BTN1 <= 1'b0;
		EsperaSoltar:
			BTN1 <= 1'b1;
	endcase
end

always @ (KEY2 or btn2state) begin
	case (btn2state)
		EsperaApertar: begin
			if (KEY2 == 0) btn2next <= SaidaAtiva; 
			else	btn2next <= EsperaApertar;
		end
		
		SaidaAtiva:begin
			if (KEY2 == 0) btn2next <= EsperaSoltar; 
			else btn2next <= EsperaApertar; 
		end
			
		EsperaSoltar:begin
			if (KEY2 == 0) btn2next <= EsperaSoltar;	
			else btn2next <= EsperaApertar;
		end		
	endcase
end	

always @ (btn2state) begin
	case (btn2state)
		EsperaApertar:
			BTN2 <= 1'b1;
		SaidaAtiva:
			BTN2 <= 1'b0;
		EsperaSoltar:
			BTN2 <= 1'b1;
	endcase
end


always @ (KEY3 or btn3state) begin
	case (btn3state)
		EsperaApertar: begin
			if (KEY3 == 0) btn3next <= SaidaAtiva; 
			else	btn3next <= EsperaApertar;
		end
		
		SaidaAtiva:begin
			if (KEY3 == 0) btn3next <= EsperaSoltar; 
			else btn3next <= EsperaApertar; 
		end
			
		EsperaSoltar:begin
			if (KEY3 == 0) btn3next <= EsperaSoltar;	
			else btn3next <= EsperaApertar;
		end		
	endcase
end	

always @ (btn3state) begin
	case (btn3state)
		EsperaApertar:
			BTN3 <= 1'b1;
		SaidaAtiva:
			BTN3 <= 1'b0;
		EsperaSoltar:
			BTN3 <= 1'b1;
	endcase
end

endmodule

