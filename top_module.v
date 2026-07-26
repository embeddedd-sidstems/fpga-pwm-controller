`timescale 1ns / 1ps
module top_module(
    input  wire       clk,
    input  wire       btnC,       // reset to 0
    input  wire       btnL,       // decrement by 1
    input  wire       btnR,       // increment by 1
    input  wire       btnT,       // increment by 10
    input  wire       btnB,       // decrement by 10
    output wire [6:0] seg,
    output wire [3:0] an,
    output wire [15:0] led
);

    // User uses the buttons to decide the values.
    wire [13:0] count;
    button_counter buttons(
        .clk  (clk),
        .btnC (btnC),
        .btnL (btnL),
        .btnR (btnR),
        .btnT (btnT),
        .btnB (btnB),
        .count(count)
    );


    // Displays user selected values on the seven segment display
    seven_seg display(
        .clk   (clk),
        .value (count),
        .seg   (seg),
        .an    (an)
    );
    
    
    // PWM Generator Module
    wire pwm;
    pwm_gen pwmgen(
        .clk  (clk),
        .duty (count[7:0]),
        .pwm  (pwm)
    );
    assign led = {16{pwm}};
    

    
endmodule