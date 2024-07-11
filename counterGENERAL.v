module counterGENERAL
# (parameter SIZE = 4)
(
  CLKT,
  R,
  E,
  CONTADOR,
REGISTRADOR,
data
);


input wire CLKT, R, E;
input wire [SIZE-1:0]data;

output reg [SIZE-1:0] CONTADOR;
output reg REGISTRADOR;

always @(posedge CLKT or posedge R) 
begin
  if(R==1'b1) begin CONTADOR[3:0] <= 4'b0000; REGISTRADOR <= 0; end
  else 
  begin
    if ( E == 1'b1) begin
    if (CONTADOR[3:0] == data) 
      begin
       CONTADOR[3:0] <= 4'b0000;
       REGISTRADOR <= 1'b1;
      end
    else begin
      CONTADOR[3:0] <=  CONTADOR[3:0] + 1'b1;
    REGISTRADOR <= 1'b0;
      end
    end
  end
end


endmodule
