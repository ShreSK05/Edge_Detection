module sobel_edge_detector #(
   parameter IMAGE_WIDTH  = 128,
   parameter IMAGE_HEIGHT = 128
)(
    input  wire        clk,
    input  wire        rst,
    input  wire [7:0]  pixel_in,
    input  wire        pixel_valid,
    output reg  [7:0]  edge_out,
    output reg         output_valid
);

reg [7:0] line0 [0:IMAGE_WIDTH-1];
reg [7:0] line1 [0:IMAGE_WIDTH-1];
reg [7:0] line2 [0:IMAGE_WIDTH-1];

reg [15:0] col;
reg [15:0] row;

reg [7:0] w00,w01,w02;
reg [7:0] w10,w11,w12;
reg [7:0] w20,w21,w22;

integer i;

wire signed [10:0] gx, gy;
wire [10:0] mag;

assign gx = (w02 + (w12<<1) + w22) -
            (w00 + (w10<<1) + w20);

assign gy = (w00 + (w01<<1) + w02) -
            (w20 + (w21<<1) + w22);

assign mag = (gx[10] ? -gx : gx) +
             (gy[10] ? -gy : gy);

parameter THRESHOLD = 100;

reg [10:0] mag_reg;

always @(posedge clk) begin

if (rst) begin

    col <= 0;
    row <= 0;
    output_valid <= 0;
    edge_out <= 0;
    mag_reg <= 0;

    for (i=0;i<IMAGE_WIDTH;i=i+1)
    begin
        line0[i] <= 0;
        line1[i] <= 0;
        line2[i] <= 0;
    end

end
else if (pixel_valid) begin

    line2[col] <= line1[col];
    line1[col] <= line0[col];
    line0[col] <= pixel_in;

    if (row >= 2 && col >= 2) begin

        w00 <= line2[col-2];
        w01 <= line2[col-1];
        w02 <= line2[col];

        w10 <= line1[col-2];
        w11 <= line1[col-1];
        w12 <= line1[col];

        w20 <= line0[col-2];
        w21 <= line0[col-1];
        w22 <= line0[col];

        mag_reg <= mag;

        edge_out <= (mag_reg > THRESHOLD) ? 8'hFF : 8'h00;
        output_valid <= 1;

    end
    else
        output_valid <= 0;

    if (col == IMAGE_WIDTH-1) begin
        col <= 0;
        row <= row + 1;
    end
    else
        col <= col + 1;

end
else
    output_valid <= 0;

end

endmodule