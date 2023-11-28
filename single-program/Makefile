SRC_DIR = $(abspath ./src)
BUILD_DIR = $(abspath ./build)
AM_ORIGIN_DIR = $(BUILD_DIR)/am-origin
AM_BUILD_DIR = $(AM_ORIGIN_DIR)/build
TXT_DIR  = $(BUILD_DIR)/generate

C_SRC = $(notdir $(shell find -L $(SRC_DIR) -name "*.c"))
C_FILE = $(addprefix $(SRC_DIR)/,$(C_SRC))
BIN_FILE = $(foreach file,$(basename $(C_SRC)),$(AM_BUILD_DIR)/$(file)-riscv32-riscvui_test.bin)
TXT_FILE = $(foreach file,$(basename $(C_SRC)),$(TXT_DIR)/$(file).txt)
NAME_FILE = $(BUILD_DIR)/NAMES.txt
CONVERTER = $(BUILD_DIR)/converter
PUT_MKFILE = $(AM_HOME)/scripts/riscv32-riscvui_test.mk

$(shell mkdir -p $(AM_BUILD_DIR))
$(shell mkdir -p $(TXT_DIR))
$(shell ln -sf -T $(AM_HOME)/Makefile $(AM_ORIGIN_DIR)/Makefile)
$(shell ln -sf -T $(abspath ./include) $(AM_ORIGIN_DIR)/include)
$(shell ln -sf -T $(abspath ./src) $(AM_ORIGIN_DIR)/src)
$(shell ln -sf -T $(abspath ../global-scripts/riscv32-riscvui_test.mk) $(PUT_MKFILE))

.SECONDARY:
.DEFAULT_GOAL = single-program-app

$(CONVERTER): ../global-scripts/converter.c
	@echo + build $(CONVERTER)
	@$(CC) -o $@ $<

$(TXT_FILE): $(CONVERTER)

$(AM_BUILD_DIR)/%-riscv32-riscvui_test.bin: $(SRC_DIR)/%.c
	@echo + build $(notdir $@)
	@NAME=$(basename $(notdir $<)) SRCS=src/$(notdir $<) $(MAKE) -s -C $(AM_ORIGIN_DIR) ARCH=riscv32-riscvui_test image > /dev/null

$(TXT_DIR)/%.txt: $(AM_BUILD_DIR)/%-riscv32-riscvui_test.bin
	@echo + convert $(notdir $@) from $(notdir $<)
	@$(CONVERTER) $< $@

$(NAME_FILE): $(TXT_FILE)
	@echo $(basename $(TXT_FILE)) | tr ' ' '\n' > $(NAME_FILE)
	@echo + generate main names in $(NAME_FILE)

single-program-app: $(NAME_FILE)
	@echo === BUILD DONE ===
	@$(MAKE) -s clean-single-program-sym

clean-single-program-sym:
	@-unlink $(PUT_MKFILE)
clean: clean-single-program-sym
	@-rm -rf $(BUILD_DIR)


.PHONY: clean single-program-app clean-single-program-sym
