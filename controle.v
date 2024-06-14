module Controle(
input CLOCK, enter, reset, end_FPGA,
input end_User, end_time, win, match,
output reg R1, R2, E1, E2, E3, E4, SEL
);


  
  localparam ESTADO_INIT = 3'b000;
  localparam ESTADO_SETUP = 3'b001;
  localparam ESTADO_PLAY_FPGA = 3'b010;
  localparam ESTADO_PLAY_USER = 3'b011;
  localparam ESTADO_CHECK = 3'b100;
  localparam ESTADO_NEXT_ROUND = 3'b101;
  localparam ESTADO_RESULT = 3'b110;

  //variavel para armazenar o estado
  reg [2:0] estado_atual;

  
  always @(posedge CLOCK or posedge reset) begin
    if (reset) begin
      estado_atual <= ESTADO_INIT;
    end else begin
      case (estado_atual)
        ESTADO_INIT: 
          estado_atual <= ESTADO_SETUP;
        ESTADO_SETUP:
          if (enter) begin
            estado_atual <= ESTADO_PLAY_FPGA;
          end else begin
            estado_atual <= ESTADO_SETUP;
          end
        ESTADO_PLAY_FPGA:
          if (end_FPGA) begin
            estado_atual <= ESTADO_PLAY_USER;
          end else begin
            estado_atual <= ESTADO_PLAY_FPGA;
          end
        ESTADO_PLAY_USER:
          if (end_time) begin
            estado_atual <= ESTADO_RESULT;
          end else if (end_User) begin
            estado_atual <= ESTADO_CHECK;
          end else begin
            estado_atual <= ESTADO_PLAY_USER;
          end
        ESTADO_CHECK:
          if (match) begin
            estado_atual <= ESTADO_NEXT_ROUND;
          end else begin
            estado_atual <= ESTADO_RESULT;
          end
        ESTADO_NEXT_ROUND:
          if (win) begin
            estado_atual <= ESTADO_RESULT;
          end else begin
            estado_atual <= ESTADO_PLAY_FPGA;
          end
        ESTADO_RESULT:
          estado_atual <= ESTADO_RESULT;
        default:  
          estado_atual <= ESTADO_INIT;
      endcase
    end
  end

  always @(*) begin
    case (estado_atual)
      ESTADO_INIT:
        {R1, R2, E1, E2, E3, E4, SEL} <= 7'b1100000;
      ESTADO_SETUP:
        {R1, R2, E1, E2, E3, E4, SEL} <= 7'b0010000;
      ESTADO_PLAY_FPGA:
        {R1, R2, E1, E2, E3, E4, SEL} <= 7'b0000100;
      ESTADO_PLAY_USER:
        {R1, R2, E1, E2, E3, E4, SEL} <= 7'b0001000;
      ESTADO_CHECK:
        {R1, R2, E1, E2, E3, E4, SEL} <= 7'b0000010;
      ESTADO_NEXT_ROUND:
        {R1, R2, E1, E2, E3, E4, SEL} <= 7'b0100000;
      ESTADO_RESULT:
        {R1, R2, E1, E2, E3, E4, SEL} <= 7'b0000001;
      default:
        {R1, R2, E1, E2, E3, E4, SEL} <= 7'b0000000;
    endcase
  end

endmodule
