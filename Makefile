app:
	$(MAKE) -s -C am-cpu-tests
	$(MAKE) -s -C rv-tests
	$(MAKE) -s -C own-program

clean:
	$(MAKE) -s -C am-cpu-tests clean
	$(MAKE) -s -C rv-tests clean
	$(MAKE) -s -C own-program clean

.PHONY: app clean
