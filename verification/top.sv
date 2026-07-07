`include "defines.svh"
`include"ram_package.sv"
`include "design.v"
`include "interface.sv"

 
module top(); 
	//Importing the ram package 
    import ram_package::*;  
    
	logic clk; 
	    logic rst; 
 
	initial clk = 0;
  	initial 
     	forever #10 clk=~clk; // Period is 20ns --> Frequency is 50Mhz 
 
  	initial begin 
    	@(posedge clk);rst=0; 
      	repeat(1)@(posedge clk);rst=1;

		@(posedge clk);
		rst = 0;
	 repeat(4) @(posedge clk);
		rst = 1;	
    end 

	inf i1(clk,rst); 
	
	RAM DUV(.data_in(i1.data_in), .write_enb(i1.w_en), .read_enb(i1.r_en), 
			.data_out(i1.data_out), .address(i1.addr), .clk(clk), .reset(rst) 
			); 

	ram_test test= new(i1.DRV,i1.REF,i1.MON); 

	initial begin 
		test.run(); 
		//$monitor("clk:%b",clk,$time);
		//#1000;
		$finish(); 
	end 

endmodule 
