`timescale 1ns/1ps
`include "wallace_8bit.sv"

module tb_wallaceTreeMultiplier8Bit;

    // Testbench signals
    logic [7:0]  a;
    logic [7:0]  b;
    logic [15:0] result;

    // Instantiate the DUT (Device Under Test)
    wallaceTreeMultiplier8Bit dut (
        .result(result),
        .a(a),
        .b(b)
    );

    // Task to apply test vectors and check results
    task automatic test_mul(input logic [7:0] ta, input logic [7:0] tb);
        logic [15:0] expected;
        begin
            a = ta;
            b = tb;
            expected = ta * tb;
            if (result !== expected) begin
                $error("Mismatch: %0d * %0d = %0d, DUT result = %0d", ta, tb, expected, result);
            end else begin
                $display("PASS: %0d * %0d = %0d", ta, tb, result);
            end
        end
    endtask

    task automatic run_random_tests(input int num_tests);
    logic [7:0] rand_a, rand_b;
    for (int i = 0; i < num_tests; i++) begin
        rand_a = $urandom_range(0, 255);
        rand_b = $urandom_range(0, 255);
        test_mul(rand_a, rand_b);
    end
    endtask

    initial begin
        $display("Starting testbench for wallaceTreeMultiplier8Bit...");

        // Test known values
        test_mul(8'd0, 8'd0);
        test_mul(8'd1, 8'd1);
        test_mul(8'd15, 8'd10);
        test_mul(8'd255, 8'd255);
        test_mul(8'd128, 8'd2);
        test_mul(8'd100, 8'd25);

        // Randomized testing
        run_random_tests(20);

        $display("Testbench completed.");
        $finish;
    end

endmodule