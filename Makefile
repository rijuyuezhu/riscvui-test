SUBMODULES = am-cpu-tests rv-tests single-program multiple-program refer-program

app: $(SUBMODULES)

$(SUBMODULES):
	@$(MAKE) -s --no-print-directory -C $@ $(MAKECMDGOALS)

clean: $(SUBMODULES)

.PHONY: apps $(SUBMODULES) clean
