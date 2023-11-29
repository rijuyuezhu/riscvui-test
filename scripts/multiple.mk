SRC_DIR       = $(abspath ./src)
BUILD_DIR     = $(abspath ./build)
SRCS          = $(shell find src/ -name "*.cc" -or -name "*.cpp" -or -name "*.c" -or -name "*.S")
AM_ORIGIN_DIR = $(BUILD_DIR)/am-origin

$(shell mkdir -p $(AM_ORIGIN_DIR))
$(shell ln -sf -T $(abspath ./include) $(AM_ORIGIN_DIR)/include)
$(shell ln -sf -T $(abspath ./src)     $(AM_ORIGIN_DIR)/src)

include $(ROOT_DIR)/scripts/converter.mk

$(BIN_FILE): $(SRCS)
	@echo 'NAME = $(NAME)' > $(AM_ORIGIN_DIR)/Makefile
	@echo 'SRCS = $$(shell find src/ -name "*.cc" -or -name "*.cpp" -or -name "*.c" -or -name "*.S")' >> $(AM_ORIGIN_DIR)/Makefile
	@echo 'include $$(AM_HOME)/Makefile' >> $(AM_ORIGIN_DIR)/Makefile
	@$(MAKE) -s -C $(AM_ORIGIN_DIR) ARCH=$(AM_ARCHS) image > /dev/null

app: convert

clean:
	@-rm -rf $(BUILD_DIR)

.PHONY: clean app
