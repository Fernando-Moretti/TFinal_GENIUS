module FSM_clock(
    input reset,
    input CLOCK_50,
    output reg C025Hz,
    output reg C05Hz,
    output reg C1Hz,
    output reg C2Hz
);

    reg [27:0] counter25Hz, counter5Hz, counter1Hz, counter2Hz;

    always @(posedge CLOCK_50 or posedge reset) begin
        if (reset) begin
            counter25Hz <= 0;
            counter5Hz <= 0;
            counter1Hz <= 0;
            counter2Hz <= 0;
        end else begin
            counter25Hz <= counter25Hz + 1;
            counter5Hz <= counter5Hz + 1;
            counter1Hz <= counter1Hz + 1;
            counter2Hz <= counter2Hz + 1;

            if (counter25Hz == 199_999_999) begin 
                C025Hz <= ~C025Hz; 
                counter25Hz <= 0; 
            end
            if (counter5Hz == 99_999_999) begin 
                C05Hz <= ~C05Hz; 
                counter5Hz <= 0; 
            end
            if (counter1Hz == 49_999_999) begin 
                C1Hz <= ~C1Hz; 
                counter1Hz <= 0; 
            end
            if (counter2Hz == 24_999_999) begin 
                C2Hz <= ~C2Hz; 
                counter2Hz <= 0; 
            end
        end
    end

endmodule