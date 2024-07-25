module move_ball_top (
    input wire clk_in,
    input wire rst_in,
    input wire up_in,
    input wire down_in,
    input wire left_in,
    input wire right_in,
    input wire center_in,
    output wire vga_hsync_o,
    output wire vga_vsync_o,
    output wire [11:0] vga_color_o // [4'bRED, 4'bGREEN, 4'bBLUE] 
);

/* Create required clocks */
wire clk_100mhz, clk_25mhz, locked;
clk_generator clocks (
    .clk_100mhz(clk_100mhz),
    .clk_25mhz(clk_25mhz),
    .reset(1'b0),
    .locked(locked),
    .clk_in1(clk_in)
);

/* Debounce and synchronize buttons */
wire rst_sync, up_sync, down_sync, left_sync, right_sync, center_sync;
debouncer #(.CLK_FREQ(25_000_000)) reset_debouncer 
    (.clk(clk_25mhz), .rst(1'b0), .btn_in(rst_in), .btn_out(rst_sync));
debouncer #(.CLK_FREQ(25_000_000)) up_debouncer 
    (.clk(clk_25mhz), .rst(1'b0), .btn_in(up_in), .btn_out(up_sync));
debouncer #(.CLK_FREQ(25_000_000)) down_debouncer 
    (.clk(clk_25mhz), .rst(1'b0), .btn_in(down_in), .btn_out(down_sync));
debouncer #(.CLK_FREQ(25_000_000)) left_debouncer 
    (.clk(clk_25mhz), .rst(1'b0), .btn_in(left_in), .btn_out(left_sync));
debouncer #(.CLK_FREQ(25_000_000)) right_debouncer 
    (.clk(clk_25mhz), .rst(1'b0), .btn_in(right_in), .btn_out(right_sync));
debouncer #(.CLK_FREQ(25_000_000)) center_debouncer 
    (.clk(clk_25mhz), .rst(1'b0), .btn_in(center_in), .btn_out(center_sync));

/* Instantiate VGA core */
reg [11:0] vga_color_in;
wire [15:0] vga_x_coord, vga_y_coord;
vga_core vga (
    .clk(clk_25mhz),
    .rst(rst_sync),
    .color_in(vga_color_in),
    .hsync(vga_hsync_o),
    .vsync(vga_vsync_o),
    .color_o(vga_color_o),
    .x_coord(vga_x_coord),
    .y_coord(vga_y_coord)
);



/* Cursor Stuff (testing) */

// Square cursor for testing
localparam integer CURSOR_WIDTH = 10;
wire [15:0] cursor_x, cursor_y; // location of top left corner of cursor

movement_controller movement (
    .clk(clk_25mhz),
    .rst(rst_sync),
    .up(up_sync),
    .down(down_sync),
    .left(left_sync),
    .right(right_sync),
    .center(center_sync),
    .x_pos(cursor_x),
    .y_pos(cursor_y)
);


/*
always @(posedge clk_25mhz or posedge rst_sync) begin
    if(rst_sync) begin
        cursor_x <= 0;
        cursor_y <= 0;
    end else begin
        cursor_x <= 0;
        cursor_y <= 0;
    end
end
*/




always @(posedge clk_25mhz) begin
    if((vga_x_coord >= cursor_x) && (vga_x_coord <= cursor_x + CURSOR_WIDTH) && 
       (vga_y_coord >= cursor_y) && (vga_y_coord <= cursor_y + CURSOR_WIDTH)) 
    begin
        vga_color_in <= 12'b111111111111;
    end else begin
        vga_color_in <= 12'b000000001111;
    end
end



endmodule