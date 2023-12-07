# $(BIN_FILE) can be given outside (default: $(BUILD_DIR)/am-origin/build/$(NAME)-riscv32-riscvui_test.bin
# $(NAME)     shall be set appropriately.
# $(ROOT_DIR) shall be set appropriately.

ifeq ($(wildcard $(ROOT_DIR)/scripts/converter.mk),)
$(error The ROOT_DIR is not set appropriately)
endif

ifeq ($(findstring $(MAKECMDGOALS),clean),)

ifeq ($(NAME),)
$(error The NAME is not set appropriately)
endif

endif
ifeq ($(MAKECMDGOALS),run)
AM_ARCHS         ?= native
else
AM_ARCHS         ?= riscv32-riscvui_test
endif
BUILD_DIR        ?= $(abspath ./build)
HEX_DIR           = $(BUILD_DIR)/generate
BIN_FILE         ?= $(foreach name,$(NAME),$(BUILD_DIR)/am-origin/build/$(name)-$(AM_ARCHS).bin)
BIN_DIR           = $(shell dirname $(firstword $(BIN_FILE)))
HEX_FILE          = $(foreach name,$(NAME),$(HEX_DIR)/$(name).hex)
NAME_FILE         = $(BUILD_DIR)/NAMES.txt
CONVERTER         = $(BUILD_DIR)/converter

SCRIPTS_DIR       = $(ROOT_DIR)/scripts
CONVERTER_SRC     = $(SCRIPTS_DIR)/converter.c
AM_REMOTE_MKFILE  = $(SCRIPTS_DIR)/am-remote/$(AM_ARCHS).mk
AM_REMOTE_MKFILE_RECIEVE  = $(AM_HOME)/scripts/$(AM_ARCHS).mk

$(shell mkdir -p $(HEX_DIR))

ifeq ($(wildcard $(AM_REMOTE_MKFILE_RECIEVE)),)
$(shell ln -sf -T $(AM_REMOTE_MKFILE) $(AM_REMOTE_MKFILE_RECIEVE))
endif

.DEFAULT_GOAL = app
# app is defined outside.

$(CONVERTER): $(CONVERTER_SRC)
	@$(CC) -o $@ $<
	@echo + build $(CONVERTER)
$(HEX_FILE): $(CONVERTER)

$(HEX_FILE): $(HEX_DIR)/%.hex: $(BIN_DIR)/%-$(AM_ARCHS).bin
	@$(CONVERTER) $< $@
	@echo + convert $(notdir $@) from $(notdir $<)

$(NAME_FILE): $(HEX_FILE)
	@echo + generate main names in $(NAME_FILE)
	@echo $(basename $(HEX_FILE)) | tr ' ' '\n' > $(NAME_FILE)

convert: $(NAME_FILE)
	@echo "\33[1;31mNote: \33[1;32m$(NAME) \33[1;31mconvert done.\33[0m"

clean-am-remote-sym:
	@-unlink $(AM_REMOTE_MKFILE_RECIEVE)

clean: clean-am-remote-sym

.PHONY: convert clean-am-remote-sym clean
