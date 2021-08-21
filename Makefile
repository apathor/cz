all: test www

test: unit lint

unit:
	./test/cztest

lint:
	shellcheck ./cz

WWW_SOURCES := $(wildcard www/*.org)

%.html: %.org
	pandoc -s $< -o $@

www: www/ $(WWW_SOURCES:.org=.html) README.md

README.md:
	pandoc -s www/index.org -o README.md

www/:
	mkdir -p ./www

.PHONY: test unit lint www
