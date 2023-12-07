BIN_FILE ?= $(PROJ_DIR)/build/$(NAME)-$(AM_ARCHS).bin

define operation_sequence ?=
	@$(MAKE) -s -C $(PROJ_DIR) ARCH=$(AM_ARCHS) image > /dev/null
endef

include $(ROOT_DIR)/scripts/converter.mk

$(BIN_FILE):
	$(operation_sequence)
	@echo + enter $(PROJ_DIR) to build $(notdir $@)

app: convert

clean:
	@-rm -rf $(BUILD_DIR)

.PHONY: clean app $(BIN_FILE)
