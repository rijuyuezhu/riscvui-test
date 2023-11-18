SRC_DIR = $(abspath ./src)
BUILD_DIR = $(abspath ./build)
AM_ORIGIN_DIR = $(BUILD_DIR)/am-origin
AM_BUILD_DIR = $(AM_ORIGIN_DIR)/build
TXT_DIR  = $(BUILD_DIR)/generate

C_SRC = $(notdir $(shell find -L $(SRC_DIR) -name "*.c"))
C_FILE = $(addprefix $(SRC_DIR)/,$(C_SRC))
BIN_FILE = $(foreach file,$(basename $(C_SRC)),$(AM_BUILD_DIR)/$(file)-riscv32-nemu.bin)
TXT_FILE = $(foreach file,$(basename $(C_SRC)),$(TXT_DIR)/$(file).txt)
NAME_FILE = $(BUILD_DIR)/NAMES.txt
CONVERTER = $(BUILD_DIR)/converter

$(shell mkdir -p $(AM_BUILD_DIR))
$(shell mkdir -p $(TXT_DIR))
$(shell ln -sf -T $(AM_HOME)/Makefile $(AM_ORIGIN_DIR)/Makefile)
$(shell ln -sf -T $(abspath ./include) $(AM_ORIGIN_DIR)/include)
$(shell ln -sf -T $(abspath ./src) $(AM_ORIGIN_DIR)/src)

.SECONDARY:
.DEFAULT_GOAL = app

$(CONVERTER): scripts/converter.c
	@echo + build $(CONVERTER)
	@$(CC) -o $@ $<

$(TXT_FILE): $(CONVERTER)

$(AM_BUILD_DIR)/%-riscv32-nemu.bin: $(SRC_DIR)/%.c
	@echo + build $(notdir $@)
	@NAME=$(basename $(notdir $<)) SRCS=src/$(notdir $<) $(MAKE) -s -C $(AM_ORIGIN_DIR) ARCH=riscv32-nemu image > /dev/null

$(TXT_DIR)/%.txt: $(AM_BUILD_DIR)/%-riscv32-nemu.bin
	@echo + convert $(notdir $@) from $(notdir $<)
	@$(CONVERTER) $< $@

$(NAME_FILE): $(TXT_FILE)
	@echo $(basename $(TXT_FILE)) | tr ' ' '\n' > $(NAME_FILE)
	@echo + generate main names in $(NAME_FILE)

app: $(NAME_FILE)
	@echo BUILD DONE.

clean:
	@-rm -rf $(BUILD_DIR)


.PHONY: clean app
