
interface inf(input bit clk,input bit rst);
	logic [7:0]data_in,data_out;
	logic [4:0]addr;
	logic w_en,r_en;

	clocking drv_cb@(posedge clk);
		output w_en,r_en;
		output data_in;
		output addr;
		input rst;
		default input #1 output #0;
	endclocking

	clocking mon_cb@(posedge clk);
		input w_en,r_en;
		input data_in,data_out;
		input addr;
		default input #1 output #0;
	endclocking

	clocking ref_cb@(posedge clk);
		input w_en,r_en;
		input data_in;
		input addr;
		output data_out;
		default input #1 output #0;
	endclocking

	modport DRV(clocking drv_cb);
	modport MON(clocking mon_cb);
	modport REF(clocking ref_cb);
endinterface
