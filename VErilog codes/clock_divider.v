module clock_divider(
    input clk_in,
    output clk_out
);

reg [1:0] count = 0;

always @(posedge clk_in)
begin
    count <= count + 1;
end

assign clk_out = count[1];

endmodule