module Counter_FPGA
#(parameter SIZE = 4)
(
	data,
	clk,
	R,
	E,
	end_FPGA,
	SEQFPGA
);

input wire [SIZE-1:0] data;
input wire clk, R, E;
output reg [SIZE-1:0] SEQFPGA;
output reg end_FPGA;

always @(posedge clk or posedge R or posedge E or posedge SEQFPGA or posedge data) begin
	if (R == 1'b1) begin SEQFPGA <= 4'b0000; end_FPGA <= 1'b0; end
	else begin 
	if (E == 1'b1)	begin
	  	SEQFPGA <= SEQFPGA + 1'b1;
		end_FPGA <= 1'b0;
	  
		if (SEQFPGA == data) begin
			SEQFPGA <= 4'b0000; //???
			end_FPGA <= 1'b1;
		end
		else begin
			end_FPGA <= 4'b0000;
		end
		
		end
	end
end

endmodule
