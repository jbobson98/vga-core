// Top level module for VGA experimentation on the Digilent BASYS 3 development board

module vga_core (
    input wire clk,
    input wire rst,
    output wire hsync,
    output wire vsync,
    output wire [3:0] red,
    output wire [3:0] green,
    output wire [3:0] blue
);


// VGA resolution parameters
localparam integer HORZ_PIXELS = 640;
localparam integer HORZ_FRONT_PORCH = 16;
localparam integer HORZ_BACK_PORCH = 48;
localparam integer HORZ_SYNC = 96;
localparam integer TOTAL_WIDTH = HORZ_PIXELS + HORZ_FRONT_PORCH + HORZ_BACK_PORCH + HORZ_SYNC;
localparam integer WIDTH_BITS = $clog2(TOTAL_WIDTH + 1);

localparam integer VERT_PIXELS = 480;
localparam integer VERT_FRONT_PORCH = 10;
localparam integer VERT_BACK_PORCH = 33;
localparam integer VERT_SYNC = 2;
localparam integer TOTAL_HEIGHT = VERT_PIXELS + VERT_FRONT_PORCH + VERT_BACK_PORCH + VERT_SYNC;
localparam integer HEIGHT_BITS = $clog2(TOTAL_HEIGHT + 1);

// Create required clock signals
wire clk_100mhz, clk_25mhz, locked;
clk_generator clocks (
    .clk_100mhz(clk_100mhz),
    .clk_25mhz(clk_25mhz),
    .reset(1'b0),
    .locked(locked),
    .clk_in1(clk)
);

// Sync/Debounce reset
wire rst_sync;
debouncer #(.CLK_FREQ(25_000_000)) reset_debouncer 
    (.clk(clk_25mhz), .rst(1'b0), .btn_in(rst), .btn_out(rst_sync));

// Instantiate vga_sync_generator
wire [WIDTH_BITS-1 : 0] x_loc;
wire [HEIGHT_BITS-1 : 0] y_loc;
wire video_active;
vga_sync_generator #(
    .HORZ_PIXELS(HORZ_PIXELS),
    .HORZ_FRONT_PORCH(HORZ_FRONT_PORCH),
    .HORZ_BACK_PORCH(HORZ_BACK_PORCH),
    .HORZ_SYNC(HORZ_SYNC),
    .VERT_PIXELS(VERT_PIXELS),
    .VERT_FRONT_PORCH(VERT_FRONT_PORCH),
    .VERT_BACK_PORCH(VERT_BACK_PORCH),
    .VERT_SYNC(VERT_SYNC)
) sync_gen (
    .clk(clk_25mhz), 
    .rst(rst_sync), 
    .hsync(hsync), 
    .vsync(vsync),
    .video_active(video_active),
    .x_loc(x_loc),
    .y_loc(y_loc)
);


// Replace this with pixel data gen at some point
assign red = 4'b1111;
assign green = 4'b1111;
assign blue = 4'b1111;



endmodule