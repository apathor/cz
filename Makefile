

test: unit lint

unit:
	./test/cztest

lint:
	shellcheck ./cz

.PHONY: test
