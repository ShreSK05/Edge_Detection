module image_bram(

    input clk,
    input [13:0] addr,
    output reg [7:0] data
);

reg [7:0] memory [0:16383];

initial begin
    $readmemh("input.mem", memory);
end

always @(posedge clk)
begin
    data <= memory[addr];
end

endmodule