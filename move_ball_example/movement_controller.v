module movement_controller (
    input wire clk,
    input wire rst,
    input wire up,
    input wire down,
    input wire left,
    input wire right,
    input wire center,
    output reg [15:0] x_pos,
    output reg [15:0] y_pos
);

wire ms_10; // goes high every 10ms
wire [17:0] count;
flex_counter #(.MAX_COUNT(250_000), .WIDTH(18)) ms_counter 
    (.clk(clk), .rst(rst), .cen(1'b1), .maxcnt(ms_10), .count(count));


always @(posedge clk or posedge rst) begin
    if(rst) begin
        x_pos <= 0;
        y_pos <= 0;
    end else begin
        if(ms_10) begin
            if(right) x_pos <= x_pos + 1;
            if(left) x_pos <= x_pos - 1;
            if(up) y_pos <= y_pos - 1;
            if(down) y_pos <= y_pos + 1;
        end
    end
end

endmodule