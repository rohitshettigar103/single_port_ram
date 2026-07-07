//`include "defines.svh"
class ram_environment;

        virtual inf.DRV drv_vif;
        virtual inf.REF ref_vif;
        virtual inf.MON mon_vif;

        //mailbox generator to driver
        mailbox#(transaction) mbx_gen_drv;
        //driver to reference modet
        mailbox#(transaction) mbx_drv_ref;
        //monitor to scoreboard
        mailbox#(transaction) mbx_mon_scr;
        //reference model to scoreboard
	mailbox#(transaction) mbx_ref_scr;

        //declaring handles for all the classes done
        ram_generator gen;
        ram_driver drv;
        ram_monitor mon;
        ram_scoreboard scr;
        ram_reference ref_scr;


        function new(virtual inf.DRV drv_vif,virtual inf.REF ref_vif,virtual inf.MON mon_vif);
                this.drv_vif=drv_vif;
                this.ref_vif=ref_vif;
                this.mon_vif=mon_vif;
        endfunction

        //creating a task that creates object for mailbox and other component
        task build();
	begin
	mbx_gen_drv=new;
	mbx_drv_ref=new;
	mbx_mon_scr=new;
	mbx_ref_scr=new;

	gen=new(mbx_gen_drv);
	drv=new(mbx_gen_drv,mbx_drv_ref,drv_vif);
	mon=new(mbx_mon_scr,mon_vif);
	scr=new(mbx_mon_scr,mbx_ref_scr);
	ref_scr=new(mbx_drv_ref,mbx_ref_scr,ref_vif);

	end
	endtask

	task start();
fork
	gen.start();
	drv.start();
	mon.start();
	scr.start();
	ref_scr.start();
join
scr.compare_report();
endtask
endclass


