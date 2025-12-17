// 16x4 ROM implementing a simple combinational function.
// Here, the output is just a made-up mapping of Addr -> F,
// but it could be parity, 7-seg codes, etc.
module rom16x4_func (
    input  wire [3:0] addr,
    output reg  [3:0] F
);

    always @* begin
        case (addr)
            4'h0: F = 4'b0000;
            4'h1: F = 4'b0001;
            4'h2: F = 4'b0010;
            4'h3: F = 4'b0011;
            4'h4: F = 4'b0100;
            4'h5: F = 4'b0101;
            4'h6: F = 4'b0110;
            4'h7: F = 4'b0111;
            4'h8: F = 4'b1000;
            4'h9: F = 4'b1001;
            4'hA: F = 4'b1010;
            4'hB: F = 4'b1011;
            4'hC: F = 4'b1100;
            4'hD: F = 4'b1101;
            4'hE: F = 4'b1110;
            4'hF: F = 4'b1111;
            default: F = 4'b0000;
        endcase
    end

endmodule
