CPUTEST_TEST = $(AM_HOME)/../am-kernels/tests/cpu-tests/tests
CPUTEST_INCLUDE = $(AM_HOME)/../am-kernels/tests/cpu-tests/include
$(shell ln -sf -T $(CPUTEST_TEST) $(abspath ./src))
$(shell ln -sf -T $(CPUTEST_INCLUDE) $(abspath ./include))

include ../single-program/Makefile

clean-am-cpu-tests-sym:
	@-unlink ./src
	@-unlink ./include

.DEFAULT_GOAL = am-cpu-tests-app

am-cpu-tests-app: single-program-app
	@$(MAKE) -s clean-am-cpu-tests-sym

clean: clean-am-cpu-tests-sym

.PHONY: clean clean-am-cpu-tests-sym am-cpu-tests-app
