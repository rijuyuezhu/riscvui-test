# riscvui-test

This project helps the automatic testing and program building for RV32I CPUs(it is OK for adding M and Zicsr extentions). It contains four parts: am-cpu-tests, single-program, rv-tests, and multiple-program.

To start your testing, pull this repository first.

## am-cpu-tests

This part uses the `cpu-tests` of [NJU-ProjectN/abstract-machine](https://github.com/NJU-ProjectN/abstract-machine) & [NJU-ProjectN/am-kernels](https://github.com/NJU-ProjectN/am-kernels) for testing.

### Prerequisitions

Before building the tests, make sure that you pull the components of abstract-machine and am-kernels correctly, and `$AM_HOME/../am-kernels/` is exactly your root directory of am-kernels.

### Usage

- Run `make -C am-cpu-tests` directly.
- Refer to `am-cpu-tests/build/NAMES.txt` to obtain the **main name**(denoted by `<MN>` later) for each of the cpu-tests testcase.
- Then use `$readmemh(<MN>.txt, ...)` to load the content of the instructions and data into your memory in verilog, or use `$readmemh(<MN>0/1/2/3.txt, ...)` to load the content of specific bytes of each word of instructions and data in verilog.
- Start your testing! ~~Note that the am-kernels/cpu-tests has RV32M instructions in some of its testcases.~~ (After **riscvui-test version 1.1.0**, RV32M instructions compilation is supported, and they are converted to aid function calls to operation simulation functions by the compiler).
- The program ends when it meets `ebreak`(`0x00100073`), with `a0(R[10])` being the return value(normally 0). It's wise to identify these cases to judge the correctness of your design.

## single-program

This part allows you to compile and convert your own programs, but with single file.

### Prerequisitions

you need to ensure that the environment variable `$am_home` is the root directory of abstract-machine.

### Usage

The usage of `single-program` is the same as that for am-cpu-tests, just changing the directory name from `am-cpu-tests` to `single-program`. (In fact, `am-cpu-tests` is implemented by this part).


## rv-tests

This part uses the RV official testing set. Some functionalities are added to help with automatic testing.

### Prerequisitions

None.

### Usage

- Run `make -C rv-tests` directly.
- Refer to `rv-tests/build/NAMES.txt` to obtain the **main name**(denoted by `<MN>` later) for each of the cpu-tests testcase.
- Then use `$readmemh(<MN>.hex, ...)` to load the content of the instructions into your memory in verilog, or use `$readmemh(<MN>_d.hex, ...)` to load the content of the data into your memory in verilog, or use `$readmemh(<MN>_d0/1/2/3.hex, ...)` to load the content of specific bytes of each word of data in verilog.
- Start your testing! The instruction to flag the end of program is `0xdead10cc`, with `a0(R[10])` equals to `0xc0ffee` meaning the testing is passed, and `a0(R[10])` equals to `0xdeaddead` meaning the testing failed.

## multiple-program

This part allows building user programs with multiple files. 

### prerequisitions

you need to ensure that the environment variable `$am_home` is the root directory of abstract-machine.

### Usage

For every project, it has its own subdirectory under `multiple-program/`(except `multiple-program/scripts`, which is not a project itself but contains some scripts necessary for building, please do not change them). The structure of a specific project is as follows: (we use the example project `examples` to illustrate this).

```
multiple-program
├── examples            # One spesific project
│   ├── include         # Project header files
│   │   └── main.h
│   ├── Makefile        # Project Makefile: can be CHANGED at your convinience
│   └── src             # Project source codes. [*.cc, *.S, *.c, *.cpp] are supported
│       ├── func1.cc
│       ├── func2.S
│       └── main.c
├── ...                 # Other projects
│
├── Makefile            # Makefile for compiling all projects. DO NOT CHANGE!
└── scripts             # Scripts for making projects. DO NOT CHANGE!
    ├── am-origin.mk
    └── build.mk
```

To build a new project, follow the structure of `examples`. You might modify the `Makefile` INSIDE the project:

```make
# In multiple-program/<project>/Makefile

NAME = examples
# Change the NAME of the project at your convinience.

include ../scripts/build.mk
```

And run `make` under `multiple-program/<project>/` to compile and convert. The main name list lies in `multiple-program/<project>/build/NAMES.txt`. (This shall contain exclusive one line, though.)

## Automatic testing

The project provides simple automatic test structure at `am-cpu-tests/scripts/test.sh` and `rv-tests/scripts/test.sh`. Feel free to modify and use them. Here is an example of automatic tests on rv-tests, using verilator: 

<div align="center">
<img src="resources/pic1.png" width="60%"/>
</div>
