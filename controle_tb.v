`timescale 1ns / 1ps

module Controle_tb;

  // Entradas
  reg CLOCK;
  reg enter;
  reg reset;
  reg end_FPGA;
  reg end_User;
  reg end_time;
  reg win;
  reg match;

  // Sa�das
  wire R1;
  wire R2;
  wire E1;
  wire E2;
  wire E3;
  wire E4;
  wire SEL;

  // Instancia��o do m�dulo Controle
  Controle uut (
    .CLOCK(CLOCK), 
    .enter(enter), 
    .reset(reset), 
    .end_FPGA(end_FPGA), 
    .end_User(end_User), 
    .end_time(end_time), 
    .win(win), 
    .match(match), 
    .R1(R1), 
    .R2(R2), 
    .E1(E1), 
    .E2(E2), 
    .E3(E3), 
    .E4(E4), 
    .SEL(SEL)
  );

  // Gera��o do clock
  initial begin
    CLOCK = 0;
    forever #5 CLOCK = ~CLOCK;
  end

  initial begin
    // Inicializa��o
    enter = 0;
    reset = 1;
    end_FPGA = 0;
    end_User = 0;
    end_time = 0;
    win = 0;
    match = 0;
    
    // Espera por reset
    #10;
    reset = 0;
    #10;
    
    // Teste de transi��o para ESTADO_SETUP
    $display("Testando transi��o para ESTADO_SETUP");
    #10;
    
    // Teste de transi��o para ESTADO_PLAY_FPGA
    $display("Testando transi��o para ESTADO_PLAY_FPGA");
    enter = 1;
    #10;
    enter = 0;
    #10;
    
    // Teste de transi��o para ESTADO_PLAY_USER
    $display("Testando transi��o para ESTADO_PLAY_USER");
    end_FPGA = 1;
    #10;
    end_FPGA = 0;
    #10;
    
    // Teste de transi��o para ESTADO_CHECK
    $display("Testando transi��o para ESTADO_CHECK");
    end_User = 1;
    #10;
    end_User = 0;
    
    // Teste de transi��o para ESTADO_NEXT_ROUND (match)
    $display("Testando transi��o para ESTADO_NEXT_ROUND (match)");
    match = 1;
    #10;
    match = 0;
    
    // Teste de transi��o para ESTADO_PLAY_FPGA (pr�xima rodada)
    $display("Testando transi��o para ESTADO_PLAY_FPGA (pr�xima rodada)");
    #10;
    
    // Teste de transi��o para ESTADO_PLAY_USER
    $display("Testando transi��o para ESTADO_PLAY_USER");
    end_FPGA = 1;
    #10;
    end_FPGA = 0;
    #10;
    
    // Teste de transi��o para ESTADO_CHECK
    $display("Testando transi��o para ESTADO_CHECK");
    end_User = 1;
    #10;
    end_User = 0;
    
    // Teste de transi��o para ESTADO_RESULT (n�o match)
    $display("Testando transi��o para ESTADO_RESULT (n�o match)");
    #10;
    
    // Teste de transi��o para ESTADO_PLAY_FPGA (win)
    $display("Testando transi��o para ESTADO_PLAY_FPGA (win)");
    win = 1;
    #10;
    win = 0;
    
    // Teste de transi��o para ESTADO_RESULT (end_time)
    $display("Testando transi��o para ESTADO_RESULT (end_time)");
    end_time = 1;
    #10;
    end_time = 0;

    $finish;
  end

endmodule
