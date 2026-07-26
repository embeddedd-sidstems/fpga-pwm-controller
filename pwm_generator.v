`timescale 1ns / 1ps
module pwm_gen(
    input  wire        clk,
    input  wire [7:0]  duty,     // Brightness
    output wire        pwm
);
    
    // 8 Bit Counter that counts to 255 and wraps back to 0
    reg [7:0] pwm_cnt;
    always @(posedge clk) pwm_cnt <= pwm_cnt + 1'b1;
    
    // Sets the PWM High when the counter is below duty
    // Example: 
    // Duty Cycle = 64
    // Between 0-63 Clock Cycles: Output High
    // Between 64-255 Clock Cycles: Output Low
    // 25% Duty Cycle
    assign pwm = (pwm_cnt < duty);
endmodule