module REG_FPGA (
    clk,
    R,           
    E,          
    data,  
    q,  
    q3  
);
	input clk, R, E;
	input [63:0]data;
	output reg[63:0]q;
	output reg[3:0]q3; //MVP BITS
    always @(posedge clk or posedge R) begin
        if (R) begin
            q <= 64'b0;    
            q3 <= 4'b0;   
        end else if (E) begin
            q <= data;
            q3 <= data[63:60]; 
        end 
    end

endmodule 