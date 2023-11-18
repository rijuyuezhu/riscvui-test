CPUTEST_DIR = $(NEMU_HOME)/../am-kernels/tests/cpu-tests
CPUTEST_TESTS_DIR = $(CPUTEST_DIR)/tests
CPUTEST_BUILD_DIR = $(CPUTEST_DIR)/build
BUILD_DIR  = $(abspath ./build)
TXT_DIR  = $(BUILD_DIR)/generate

C_SRC = $(notdir $(shell find $(CPUTEST_TESTS_DIR) -name "*.c"))
C_FILE = $(addprefix $(CPUTEST_TESTS_DIR)/,$(C_SRC))
BIN_FILE = $(addprefix $(CPUTEST_BUILD_DIR)/,$(foreach file,$(basename $(C_SRC)),$(file)-riscv32-nemu.bin))
TXT_FILE = $(addprefix $(TXT_DIR)/,$(C_SRC:.c=.txt))
NAME_FILE = $(BUILD_DIR)/NAMES.txt
CONVERTER = $(BUILD_DIR)/converter

$(shell mkdir -p $(TXT_DIR))

.DEFAULT_GOAL = app

$(CONVERTER): scripts/converter.c
	@$(CC) -o $@ $<

$(CPUTEST_BUILD_DIR)/%-riscv32-nemu.bin: $(CPUTEST_TESTS_DIR)/%.c
	@echo build $(notdir $@)
	@$(MAKE) -s -C $(CPUTEST_DIR) ARCH=riscv32-nemu ALL=$(notdir $(basename $<))

$(TXT_FILE): $(CONVERTER)

$(TXT_DIR)/%.txt: $(CPUTEST_BUILD_DIR)/%-riscv32-nemu.bin
	@echo convert $(notdir $@) from $(notdir $<)
	@$(CONVERTER) $< $@

	
app: $(TXT_FILE)
	@echo $(basename $(TXT_FILE)) | tr ' ' '\n' > $(NAME_FILE)

clean:
	@-rm -rf $(BUILD_DIR)

.PHONY: app clean
