module REG_User (
    clk,
    R,           
    E,          
    data,  
    q  
);
 input clk, R, E;
 input [63:0]data;
 output reg[63:0]q;
    always @(posedge clk or posedge R) begin
        if (R) begin
            q <= 64'b0;    
        end else if (E) begin
            q <= data;
        end
    end

endmodule