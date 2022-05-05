module DigitalCLK(
    Clk_1sec,  		// Clock with 1 Hz frequency
    reset,     
    seconds,
    minutes,
    hours,
	setmode,		// setmode = 1 : confirm that time will be set at beginning
	set_seconds,	// set value seconds for clock
	set_minutes,	// set value minutes for clock
	set_hours);		// set value hours for clock

//  Input variables
    input Clk_1sec;  
    input reset;
	input setmode;
	input [6:0] set_seconds;
	input [6:0] set_minutes;
	input [5:0] set_hours;
	
//  Output variables
    output [6:0] seconds;
    output [6:0] minutes;
    output [5:0] hours;
	
//  Internal variables
    reg [6:0] seconds;
    reg [6:0] minutes;
    reg [5:0] hours; 
	reg setmode_state = 1'b0;		// setmode_state = 0: not ever set time 
									// setmode_state = 1: already set time -> not set time anymore
	
//  Execute the always blocks when the Clock or reset inputs exist
//  posedge: Changing from 0 to 1
    always @(posedge(Clk_1sec) or posedge(reset))
    begin
        if(reset == 1'b1) 			// Check for active high reset
		begin  
            seconds = 6'd0;
            minutes = 6'd0;
            hours = 5'd0;  
		end
			
        else if(Clk_1sec == 1'b1)  // At the beginning of each second
		begin
			if ((setmode == 1'b1) && (setmode_state == 1'b0))
			begin
				seconds = set_seconds;
				minutes = set_minutes;
				hours = set_hours;
				setmode_state = 1'b1;
			end
			
            seconds = seconds + 6'd1; 
            if(seconds == 6'd60) 
			begin 
                seconds = 6'd0;  
                minutes = minutes + 6'd1; 
                if(minutes == 6'd60) 
				begin 
                    minutes = 6'd0;  
                    hours = hours + 5'd1;  
                    if(hours ==  5'd24) 
					begin  
                        hours = 5'd0; 
                    end 
                end
            end     
        end
    end     

endmodule