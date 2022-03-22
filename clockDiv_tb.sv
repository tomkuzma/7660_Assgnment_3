// clockDiv testbench
// Author: Tom Kuzma
// Date: March 21. 2022

module clockDiv_tb();

logic clk = 1;
logic divClk;

// instantiate dut with divisor of 5
clockDiv #(.DIVISOR(5)) dut_0(.*);

initial begin
    // init counter in dut
    dut_0.count = '1;

    // do 30 clock cycles
    repeat(30)@ (posedge clk);

    $stop;
end

// generate clock
always
	#1us clk = ~clk;

endmodule