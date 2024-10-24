module light_controller_tb;
    reg clk;
    reg reset;
    reg button;
    wire light;

    // Instantiate the light_controller
    light_controller uut (
        .clk(clk),
        .reset(reset),
        .button(button),
        .light(light)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;    // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        button = 0;
        #10;

        // Release reset
        reset = 0;
        #10;

        // Toggle light ON during positive edge of clock
        button = 1;
        #10;
        button = 0;
        #10;

        // Toggle light OFF during positive edge of clock
        button = 1;
        #10;
        button = 0;
        #10;

        // Assert reset
        reset = 1;
        #10;
        reset = 0;

        // End simulation
        #10;
        $finish;
    end

    // Monitor the output during simulation and dump the wavefor for visualization in GTKWave
    initial begin
        $monitor("Time: %0d, Light: %b", $time, light);
        $dumpfile("light_controller_tb.vcd");
        $dumpvars(0,light_controller_tb);
    end
endmodule
