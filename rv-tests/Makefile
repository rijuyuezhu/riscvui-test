ROOT_DIR       = $(abspath ..)


BUILD_DIR     ?= $(abspath ./build)
HEX_DIR        = $(BUILD_DIR)/generate
DATA_DIR       = $(abspath ./data)
NAME           = $(basename $(notdir $(shell find -L $(DATA_DIR) -name "*.hex" -and -not -name "*_d.hex")))
HEX_FILE       = $(foreach name,$(NAME),$(HEX_DIR)/$(name).hex)
NAME_FILE      = $(BUILD_DIR)/NAMES.txt
TRANSFERER     = $(BUILD_DIR)/transferer

SCRIPTS_DIR    = $(ROOT_DIR)/scripts
TRANSFERER_SRC = $(SCRIPTS_DIR)/transferer.c

$(shell mkdir -p $(HEX_DIR))

.DEFAULT_GOAL = app

$(TRANSFERER): $(TRANSFERER_SRC)
	@$(CC) -o $@ $<
	@echo + build $(TRANSFERER)

$(HEX_FILE): $(TRANSFERER)

$(HEX_FILE): $(HEX_DIR)/%.hex: $(DATA_DIR)/%_d.hex

$(HEX_FILE): $(HEX_DIR)/%.hex: $(DATA_DIR)/%.hex
	@$(TRANSFERER) $(basename $<)_d.hex $@
	@cp $< $@
	@cp $(basename $<)_d.hex $(basename $@)_d.hex
	@echo + transfer $(notdir $@)

$(NAME_FILE): $(HEX_FILE)
	@echo + generate main names in $(NAME_FILE)
	@echo $(basename $(HEX_FILE)) | tr ' ' '\n' > $(NAME_FILE)

transfer: $(NAME_FILE)
	@echo "\33[1;31mNote: \33[1;32m$(NAME) \33[1;31mtransfer done.\33[0m"

app: transfer

clean:
	@rm -rf $(TRANSFER) $(BUILD_DIR)

.PHONY: app clean transfer
