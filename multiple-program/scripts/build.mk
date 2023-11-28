ifeq ($(findstring $(MAKECMDGOALS),clean),)

ifeq ($(NAME),)
	$(error No NAME is given)
endif

endif

export NAME

SRCS = $(shell find src/ -name "*.cc" -or -name "*.cpp" -or -name "*.c" -or -name "*.S")
SRC_DIR = $(abspath ./src)
BUILD_DIR = $(abspath ./build)
AM_ORIGIN_DIR = $(BUILD_DIR)/am-origin
AM_BUILD_DIR = $(AM_ORIGIN_DIR)/build
TXT_DIR  = $(BUILD_DIR)/generate

BIN_FILE = $(AM_BUILD_DIR)/$(NAME)-riscv32-riscvui_test.bin
TXT_FILE = $(TXT_DIR)/$(NAME).txt
NAME_FILE = $(BUILD_DIR)/NAMES.txt
CONVERTER = $(BUILD_DIR)/converter
PUT_MKFILE = $(AM_HOME)/scripts/riscv32-riscvui_test.mk
INNER_MKFILE = $(AM_ORIGIN_DIR)/Makefile

$(shell mkdir -p $(AM_BUILD_DIR))
$(shell mkdir -p $(TXT_DIR))
$(shell ln -sf -T $(AM_HOME)/Makefile $(AM_ORIGIN_DIR)/Makefile)
$(shell ln -sf -T $(abspath ./include) $(AM_ORIGIN_DIR)/include)
$(shell ln -sf -T $(abspath ./src) $(AM_ORIGIN_DIR)/src)
$(shell ln -sf -T $(abspath ../../global-scripts/riscv32-riscvui_test.mk) $(PUT_MKFILE))
$(shell ln -sf -T $(abspath ../scripts/am-origin.mk) $(INNER_MKFILE))

.SECONDARY:
.DEFAULT_GOAL = multiple-program-app

$(CONVERTER): ../../global-scripts/converter.c
	@echo + build $(CONVERTER)
	@$(CC) -o $@ $<

$(BIN_FILE): $(SRCS)
	@$(MAKE) -s -C $(AM_ORIGIN_DIR) ARCH=riscv32-riscvui_test image > /dev/null

$(TXT_FILE): $(CONVERTER)

$(TXT_FILE): $(BIN_FILE)
	@echo + convert $(notdir $@) from $(notdir $<)
	@$(CONVERTER) $< $@

$(NAME_FILE): $(TXT_FILE)
	@echo $(basename $(TXT_FILE)) > $(NAME_FILE)
	@echo + generate main names in $(NAME_FILE)

multiple-program-app: $(NAME_FILE)
	@echo === BUILD DONE ===
	@$(MAKE) -s clean-multiple-program-sym

clean-multiple-program-sym:
	@-unlink $(PUT_MKFILE)

clean: clean-multiple-program-sym
	@-rm -rf $(BUILD_DIR)

.PHONY: clean multiple-program-app clean-multiple-program-sym
