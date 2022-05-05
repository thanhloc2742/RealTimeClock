`timescale 100ms / 100ms
module TB_CLK;

    // Input variables
    reg Clk_1sec;
    reg reset;
	reg setmode = 1'b1;
	reg [6:0] set_seconds = 6'd6;
	reg [6:0] set_minutes = 6'd6;
	reg [5:0] set_hours = 6'd6;

    // Output variables
    wire [6:0] seconds;
    wire [6:0] minutes;
    wire [5:0] hours;
	
    // Block test for testing values of Digital_Clock
    DigitalCLK test (
        .Clk_1sec(Clk_1sec), 
        .reset(reset), 
        .seconds(seconds), 
        .minutes(minutes), 
        .hours(hours),
		.setmode(setmode),
		.set_seconds(set_seconds),
		.set_minutes(set_minutes),
		.set_hours(set_hours)
    );

	//  Generating the Clock with 1 Hz frequency
    initial begin 
		Clk_1sec = 1'b1;
		forever #5 Clk_1sec=~Clk_1sec;
	end
	
    initial begin
        reset = 1'b1;
		#10 // Wait 1 second to reset  			
		reset = 1'b0;
    end
      
endmodule