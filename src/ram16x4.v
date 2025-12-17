// 16x4 single-port RAM
// - 16 addresses: 0..15
// - 4-bit data width
// - Synchronous write on rising edge of clk when WE = 1
// - Asynchronous read: DataOut follows contents at Addr
module ram16x4 (
    input  wire        clk,
    input  wire        we,        // write enable
    input  wire [3:0]  addr,      // address 0..15
    input  wire [3:0]  data_in,   // data to write
    output wire [3:0]  data_out   // data read
);

    // Memory array: 16 locations of 4 bits each
    reg [3:0] mem [0:15];

    // Synchronous write
    always @(posedge clk) begin
        if (we) begin
            mem[addr] <= data_in;
        end
    end

    // Asynchronous read
    assign data_out = mem[addr];

endmodule
