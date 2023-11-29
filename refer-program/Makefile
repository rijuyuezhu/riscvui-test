SUBMODULES = $(filter-out .,$(notdir $(shell find . -maxdepth 1 -type d)))

app: $(SUBMODULES)

$(SUBMODULES):
	@$(MAKE) -s --no-print-directory -C $@ $(MAKECMDGOALS)

clean: $(SUBMODULES)

.PHONY: apps $(SUBMODULES) clean
