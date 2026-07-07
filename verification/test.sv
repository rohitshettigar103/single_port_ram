//`include "defines.svh"
class ram_test;
	virtual inf.DRV drv_vif;
	virtual inf.REF ref_vif;
	virtual inf.MON mon_vif;
	ram_environment env;

	function new(
		virtual inf.DRV drv_vif,
		virtual inf.REF ref_vif,
		virtual inf.MON mon_vif);

		this.drv_vif=drv_vif;
		this.ref_vif=ref_vif;
		this.mon_vif=mon_vif;
	endfunction

	task run();
		env=new(drv_vif,ref_vif,mon_vif);
		env.build;
		env.start;
	endtask
endclass


