`timescale 1ns / 1ps
module seven_seg(
    input  wire        clk,
    input  wire [13:0] value,    // the number to display (0..9999)
    output wire [6:0]  seg,
    output wire [3:0]  an
);
    // Split into 4 digits
    wire [3:0] d0 =  value             % 10;
    wire [3:0] d1 = (value /   10)     % 10;
    wire [3:0] d2 = (value /  100)     % 10;
    wire [3:0] d3 = (value / 1000)     % 10;

    // Refresher
    reg [16:0] refresh;
    always @(posedge clk) refresh <= refresh + 1'b1;
    wire [1:0] sel = refresh[16:15];
    
    // Mux to set each display
    reg [3:0] digit;
    reg [3:0] an_r;
    always @(*) begin
        case (sel)
            2'd0: begin digit = d0; an_r = 4'b1110; end
            2'd1: begin digit = d1; an_r = 4'b1101; end
            2'd2: begin digit = d2; an_r = 4'b1011; end
            2'd3: begin digit = d3; an_r = 4'b0111; end
        endcase
    end
    assign an = an_r;

    // Mux to set each number
    reg [6:0] seg_r;
    always @(*) begin
        case (digit)
            4'd0: seg_r = 7'b1000000;
            4'd1: seg_r = 7'b1111001;
            4'd2: seg_r = 7'b0100100;
            4'd3: seg_r = 7'b0110000;
            4'd4: seg_r = 7'b0011001;
            4'd5: seg_r = 7'b0010010;
            4'd6: seg_r = 7'b0000010;
            4'd7: seg_r = 7'b1111000;
            4'd8: seg_r = 7'b0000000;
            4'd9: seg_r = 7'b0010000;
            default: seg_r = 7'b1111111;
        endcase
    end
    assign seg = seg_r;
endmodule