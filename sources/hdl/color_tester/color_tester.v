// Debounces the toggle switches on the BASYS3 to change the VGA color bits to test colors
module color_tester #(
    parameter CLK_FREQ = 100_000_000    
)(
    input wire clk,
    input wire rst,
    input wire [3:0] red_switches,
    input wire [3:0] green_switches,
    input wire [3:0] blue_switches,
    output wire [3:0] red_o,
    output wire [3:0] green_o,
    output wire [3:0] blue_o
);

genvar i;

// red_switch debouncers
generate
    for(i = 0; i < 4; i = i + 1) begin : red_switch_debouncers
        debouncer #(.CLK_FREQ(CLK_FREQ)) red_debouncer 
            (.clk(clk), .rst(rst), .btn_in(red_switches[i]), .btn_out(red_o[i]));
    end

    for(i = 0; i < 4; i = i + 1) begin : green_switch_debouncers
        debouncer #(.CLK_FREQ(CLK_FREQ)) green_debouncer 
            (.clk(clk), .rst(rst), .btn_in(green_switches[i]), .btn_out(green_o[i]));
    end

    for(i = 0; i < 4; i = i + 1) begin : blue_switch_debouncers
        debouncer #(.CLK_FREQ(CLK_FREQ)) blue_debouncer 
            (.clk(clk), .rst(rst), .btn_in(blue_switches[i]), .btn_out(blue_o[i]));
    end
endgenerate

endmodule