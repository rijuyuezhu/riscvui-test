CPUTEST_TEST = $(AM_HOME)/../am-kernels/tests/cpu-tests/tests
CPUTEST_INCLUDE = $(AM_HOME)/../am-kernels/tests/cpu-tests/include
$(shell ln -sf -T $(CPUTEST_TEST) $(abspath ./src))
$(shell ln -sf -T $(CPUTEST_INCLUDE) $(abspath ./include))

ROOT_DIR ?= $(abspath ..)

include $(ROOT_DIR)/single-program/Makefile

clean-am-cpu-tests-sym:
	@-unlink ./src
	@-unlink ./include

clean: clean-am-cpu-tests-sym

.PHONY: clean clean-am-cpu-tests-sym
