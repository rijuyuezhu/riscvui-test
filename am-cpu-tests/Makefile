CPUTEST_TEST = $(AM_HOME)/../am-kernels/tests/cpu-tests/tests
CPUTEST_INCLUDE = $(AM_HOME)/../am-kernels/tests/cpu-tests/include
$(shell ln -sf -T $(CPUTEST_TEST) $(abspath ./src))
$(shell ln -sf -T $(CPUTEST_INCLUDE) $(abspath ./include))

include ../own-program/Makefile
