`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2026 10:13:09
// Design Name: 
// Module Name: top_sobel_vga
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module top_sobel_vga(

    input clk100,
    input rst,

    output hsync,
    output vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
);

wire clk25;

clock_divider clkdiv(
    .clk_in(clk100),
    .clk_out(clk25)
);

wire [9:0] x;
wire [9:0] y;
wire video_on;

vga_controller vga(
    .clk(clk25),
    .hsync(hsync),
    .vsync(vsync),
    .video_on(video_on),
    .x(x),
    .y(y)
);

//////////////////////////
// IMAGE MEMORY
//////////////////////////

wire [7:0] pixel_in;

wire [13:0] img_addr;

assign img_addr = (y[6:0] * 128) + x[6:0];

image_bram img_mem(
    .clk(clk25),
    .addr(img_addr),
    .data(pixel_in)
);

//////////////////////////
// SOBEL EDGE DETECTOR
//////////////////////////

wire [7:0] edge_pixel;
wire valid;

wire pixel_valid;

assign pixel_valid = video_on && (x < 128) && (y < 128);

sobel_edge_detector sobel(
    .clk(clk25),
    .rst(rst),
    .pixel_in(pixel_in),
    .pixel_valid(pixel_valid),
    .edge_out(edge_pixel),
    .output_valid(valid)
);

//////////////////////////
// DISPLAY REGION
//////////////////////////

wire display_area;

assign display_area = (x < 128) && (y < 128);

assign red   = (display_area && valid) ? edge_pixel[7:4] : 4'b0000;
assign green = (display_area && valid) ? edge_pixel[7:4] : 4'b0000;
assign blue  = (display_area && valid) ? edge_pixel[7:4] : 4'b0000;

endmodule
