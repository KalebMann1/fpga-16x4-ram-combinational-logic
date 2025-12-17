`timescale 1ns/1ps

module tb_ram16x4;

    // Testbench signals
    reg        clk;
    reg        we;
    reg  [3:0] addr;
    reg  [3:0] data_in;
    wire [3:0] data_out;

    integer i;

    // DUT
    ram16x4 dut (
        .clk     (clk),
        .we      (we),
        .addr    (addr),
        .data_in (data_in),
        .data_out(data_out)
    );

    // Simple 10 ns period clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Init
        we      = 0;
        addr    = 0;
        data_in = 0;

        // Small delay before starting
        #20;

        // -------- WRITE PHASE --------
        // Write a unique pattern to each address
        we = 1;
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge clk);      // set inputs before rising edge
            addr    = i[3:0];
            data_in = (i * 3) & 4'hF;  // some deterministic pattern
        end
        @(negedge clk);
        we = 0;

        // -------- READBACK PHASE --------
        // Read all addresses and display results
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge clk);
            addr = i[3:0];
            #1; // small delay for read to settle
            $display("ADDR=%0d  DATA_OUT=%b", i, data_out);
        end

        #20;
        $finish;
    end

endmodule
