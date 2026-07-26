`timescale 1ns / 1ps
module button_counter(
    input  wire        clk,
    input  wire        btnC, btnL, btnR, btnT, btnB,
    output reg  [13:0] count
);
    // Debounce for each button
    wire ev_c, ev_l, ev_r, ev_t, ev_b;
    debounce db_c(.clk(clk), .btn(btnC), .ev(ev_c));
    debounce db_l(.clk(clk), .btn(btnL), .ev(ev_l));
    debounce db_r(.clk(clk), .btn(btnR), .ev(ev_r));
    debounce db_t(.clk(clk), .btn(btnT), .ev(ev_t));
    debounce db_b(.clk(clk), .btn(btnB), .ev(ev_b));

    // Counting Logic
    // Goes from 0-255 and addresses edge case where value is less than
    // 10 away from max and the +10 button is pressed by setting it to
    // the max value of 255. Also applies to the min value of 0.
    always @(posedge clk) begin
        if (ev_c)
            count <= 0;
        else if (ev_r) begin
            if (count != 14'd255) count <= count + 1'b1;
        end else if (ev_l) begin
            if (count != 14'd0)   count <= count - 1'b1;
        end else if (ev_t) begin
            if (count <= 14'd245) count <= count + 14'd10;
            else                  count <= 14'd255;         // Max out
        end else if (ev_b) begin
            if (count >= 14'd10)  count <= count - 14'd10;
            else                  count <= 14'd0;           // Min out
        end
    end
endmodule