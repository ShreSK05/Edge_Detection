module vga_controller(

input clk,
output reg hsync,
output reg vsync,
output video_on,
output [9:0] x,
output [9:0] y
);

reg [9:0] h_count = 0;
reg [9:0] v_count = 0;

always @(posedge clk)
begin
    if(h_count == 799)
    begin
        h_count <= 0;

        if(v_count == 524)
            v_count <= 0;
        else
            v_count <= v_count + 1;
    end
    else
        h_count <= h_count + 1;
end

assign x = h_count;
assign y = v_count;

assign video_on = (h_count < 640) && (v_count < 480);

always @(*)
begin
    hsync = ~(h_count >= 656 && h_count < 752);
    vsync = ~(v_count >= 490 && v_count < 492);
end

endmodule