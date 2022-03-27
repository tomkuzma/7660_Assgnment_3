// debounce.sv
// debounces an asynchronous input after 10ms with 1kHz clock 
// Author: Tom Kuzma
// Date: March 26, 2022

module debounce(
    input logic rawInput,
    output logic debouncedInput,
    input logic clk, reset_n
);

    // internal signals
    logic [3:0] count, count_next;
    logic syncIn1, syncIn2, count_enable, count_reset, debounce_next;

    // input sync ff and counter ff 
    always_ff @( posedge clk, negedge reset_n ) begin: 
        if (~reset_n) begin
            syncIn1 <= 1'b0;
            syncIn2 <= 1'b0;
            count <= '0;
        end
        else begin 
            syncIn1 <= rawInput;
            syncIn2 <= syncIn1;
            count <= count_next;
            debounce_next <= count_enable? debouncedInput:syncIn2;
        end
    end

    // next counter logic
    always_comb begin

        case({count_enable, count_reset})
            2'b00: count_next = count;
            2'b01: count_next = count + 1;
            default: count = '0;
        endcase

    end

    assign count_reset = (syncIn1^syncIn2); // reset counter on input change with xor
    assign count_enable = (count < 10);     // count when less than 10
    assign debouncedInput = debounce_next; // debounced output once counter to 10

endmodule