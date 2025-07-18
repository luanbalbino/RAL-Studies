.PHONY: all run run_xrun run_xrun_gui clean

# ---------------------------------------------------------------------------
# Common Variables
# ---------------------------------------------------------------------------
SRC = ./if/dummy_if.sv ./RTL/dummy_dut.sv pkg.sv top.sv

gui ?= 0
assert ?= 0

SEED = random
OPT = +UVM_NO_RELNOTES -uvm -64bit -access +rwc -timescale 1ns/1ps +UVM_VERBOSITY=UVM_LOW -UVMLINEDEBUG
TESTNAME = functional_test

# ---------------------------------------------------------------------------
# Usage: make run or make run gui=1
# ---------------------------------------------------------------------------
run:
ifeq ($(gui),1)
	$(MAKE) run_xrun_gui
else
	$(MAKE) run_xrun
endif

# ---------------------------------------------------------------------------
# xrun (batch mode)
# ---------------------------------------------------------------------------
run_xrun: clean
	@echo "Starting simulation with Cadence xrun (batch mode)..."
	xrun $(OPT) $(SRC) -svseed $(SEED) +UVM_TESTNAME=$(TESTNAME)
	@echo "Simulation completed."

# ---------------------------------------------------------------------------
# xrun (GUI mode)
# ---------------------------------------------------------------------------
run_xrun_gui: clean
	@echo "Starting simulation with Cadence xrun (GUI mode)..."
	xrun $(OPT) -gui $(SRC) -svseed $(SEED) +UVM_TESTNAME=$(TESTNAME)
	@echo "Simulation started."


# ---------------------------------------------------------------------------
# Clean target
# ---------------------------------------------------------------------------
clean:
	@echo "Cleaning generated files..."
	-rm -rf *.log *.wlf irun.key xcelium.d *.shm .simvision *.history *.key *.diag cov_work
	@echo "Cleaning done."

