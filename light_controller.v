module light_controller (
    input wire clk,        // Clock input
    input wire reset,      // Asynchronous reset
    input wire button,     // Button input to toggle light
    output reg light       // Light output
);

    // State encoding
    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition on the clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= OFF; // Go to OFF state on reset
        end else begin
            current_state <= next_state; // Transition to the next state
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            OFF: begin
                light = 0; // Light is off
                if (button) begin
                    next_state = ON; // Transition to ON state
                end else begin
                    next_state = OFF; // Remain in OFF state
                end
            end

            ON: begin
                light = 1; // Light is on
                if (button) begin
                    next_state = OFF; // Transition to OFF state
                end else begin
                    next_state = ON; // Remain in ON state
                end
            end

            default: begin
                light = 0; // Default to OFF
                next_state = OFF;
            end
        endcase
    end
endmodule
