module led_test #(
    parameter CLK_FREQ = 25_000_000
)(
    input wire clk,
    input wire rst,
    input wire btn_in,
    output wire led
);

wire rst_debounced;
wire clk_25mhz;
wire btn_debounced;

assign led = btn_debounced;

clk_100mhz_to_25mhz clk100to25 (.clk_in1(clk), .clk_out1(clk_25mhz), .reset(1'b0));

// LED Button
debouncer #(.CLK_FREQ(CLK_FREQ)) btndebouncer 
    (.clk(clk_25mhz), .rst(rst_debounced), .btn_in(btn_in), .btn_out(btn_debounced));

// Reset Button
debouncer #(.CLK_FREQ(CLK_FREQ)) rstdebouncer 
    (.clk(clk_25mhz), .rst(1'b0), .btn_in(rst), .btn_out(rst_debounced));


endmodule