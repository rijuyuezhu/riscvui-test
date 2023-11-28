SRCS = $(shell find src/ -name "*.cc" -or -name "*.cpp" -or -name "*.c" -or -name "*.S")
include $(AM_HOME)/Makefile
