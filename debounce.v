`timescale 1ns / 1ps
module debounce(
    input  wire clk,
    input  wire btn,
    output wire ev
);

    // Since buttons are Async, we make two flip-flops
    reg [1:0] sync;
    always @(posedge clk) sync <= {sync[0], btn};

    // Waits for change after 10ms to prevent debouncing
    reg [19:0] cnt;
    reg state, state_prev;
    always @(posedge clk) begin
        if (sync[1] == state) cnt <= 0;
        else begin
            cnt <= cnt + 1'b1;
            if (cnt == 20'hFFFFF) state <= sync[1];
        end
        state_prev <= state; // Edge detector
    end
    assign ev = state & ~state_prev;
endmodule