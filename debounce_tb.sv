module debounce_tb();

logic rawInput=0, debouncedInput, clk=0, reset_n=0;

debounce dut_0 (.*);

initial begin

    repeat(4) @(posedge clk);
    reset_n = 1;

    #100us rawInput = 1;
    #200us rawInput = 0;
    #100us rawInput = 1;
    #500us rawInput = 0;
    #100us rawInput = 1;
    #300us rawInput = 0;
    #400us rawInput = 1;

    repeat(10) @(posedge clk);

    #100us rawInput = 0;
    #200us rawInput = 1;
    #100us rawInput = 0;
    #500us rawInput = 1;
    #100us rawInput = 0;
    #300us rawInput = 1;
    #400us rawInput = 0;

    repeat(10) @(posedge clk); 

    #100us rawInput = 1;
    #200us rawInput = 0;
    #100us rawInput = 1;
    #500us rawInput = 0;
    #100us rawInput = 1;
    #300us rawInput = 0;
    #400us rawInput = 1;

    $stop // end tb
end

always
    #1ms clk = ~clk;

endmodule