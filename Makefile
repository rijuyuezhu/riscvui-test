app:
	$(MAKE) -C am-cpu-tests
	$(MAKE) -C rv-tests

clean:
	$(MAKE) -C am-cpu-tests clean
	$(MAKE) -C rv-tests clean

.PHONY: app clean
