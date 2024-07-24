module flex_counter #(
    parameter MAX_COUNT = 255,
    parameter WIDTH = 0 // if counter width less than bits need to reach max count, calculated bits will be used
)(
    input wire clk,
    input wire rst,
    input wire cen,    // count enable
    output reg maxcnt, // MAX_COUNT reached
    output reg [COUNT_BITS-1 : 0] count
);

localparam integer MIN_BITS = $clog2(MAX_COUNT + 1);
localparam integer COUNT_BITS = (WIDTH < MIN_BITS) ? MIN_BITS : WIDTH;

always @(posedge clk or posedge rst) begin

    if(rst) begin
        count <= 0;
        maxcnt <= 1'b0;
    end else begin
        if(cen) begin
            if(count < MAX_COUNT) begin
                count <= count + 1;
                maxcnt <= 1'b0;
            end else begin
                count <= 0;
                maxcnt <= 1'b1;
            end
        end
    end
end

endmodule