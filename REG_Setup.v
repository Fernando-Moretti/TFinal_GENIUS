module REG_Setup (
    clk,
    R,          
    E,          
    SW,    
    setup 
);
input clk, R, E;
input wire [7:0]SW;
output reg [7:0]setup;
    always @(posedge clk or posedge R) begin
        if (R) begin
            setup <= 8'b0;   
        end else if (E) begin
            setup <= SW;   
        end
      
else 
      
  setup <= setup;
    end

endmodule
