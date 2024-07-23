# vga-core

## Modules
- disp_config
- vga_sync_gen
- vga_pixel_clock
- vga_data_gen


## VGA Sync Generator (vga_sync_gen)
- inputs: clock (from pixel clock gen), reset
- outputs: hsync, vsync, data_enable (high when counters in active display area not blanking)

## Display Configuration (disp_config)
The display configuration module takes inputs from the interfaces on the BASYS3 development board to set the display resolution and refresh rates.

## Pixel Clock Generator
Clock frequency for the VGA controller (Pixel Frequency) is based on the number of display pixels.  
  
`Pixel Frequency = [Horiz_Res + Horiz_Blanking] * [Vert_Res + Vert_Blanking] * Refresh_Rate`

