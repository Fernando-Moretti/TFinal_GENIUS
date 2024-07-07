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


input wire CLKT, R, E, data;

output reg [SIZE-1:0] CONTADOR;
output reg REGISTRADOR;

always @(posedge CLKT or posedge R) 
begin
  if(R==1'b1) CONTADOR <= 4'b0000;
  else 
  begin
    if ( E == 1'b1) begin
    if (CONTADOR == 4'b1001) 
      begin
       CONTADOR <= 4'b0000;
       REGISTRADOR <= 1'b1;
      end
    else begin
      CONTADOR <=  CONTADOR + 1'b1;
    REGISTRADOR <= 1'b0;
      end
    end
  end
end


endmodule
