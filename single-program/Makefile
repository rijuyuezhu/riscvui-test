SRC_DIR       = $(abspath ./src)
BUILD_DIR     = $(abspath ./build)
AM_ORIGIN_DIR = $(BUILD_DIR)/am-origin

ROOT_DIR     ?= $(abspath ..)
NAME         ?= $(basename $(notdir $(shell find -L $(SRC_DIR) -name "*.c")))

$(shell mkdir -p $(AM_ORIGIN_DIR))
$(shell ln -sf -T $(AM_HOME)/Makefile  $(AM_ORIGIN_DIR)/Makefile)
$(shell ln -sf -T $(abspath ./include) $(AM_ORIGIN_DIR)/include)
$(shell ln -sf -T $(abspath ./src)     $(AM_ORIGIN_DIR)/src)

include $(ROOT_DIR)/scripts/converter.mk


$(BIN_DIR)/%-$(AM_ARCHS).bin: $(SRC_DIR)/%.c
	@NAME=$(basename $(notdir $<)) SRCS=src/$(shell realpath $< --relative-to $(SRC_DIR)) $(MAKE) -s -C $(AM_ORIGIN_DIR) ARCH=$(AM_ARCHS) image > /dev/null
	@echo + build $(notdir $@)

app: convert

clean:
	@-rm -rf $(BUILD_DIR)

.PHONY: clean app
