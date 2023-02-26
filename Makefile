SHELL := /bin/bash
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

README.md: www/index.org
	pandoc -s www/index.org -t gfm -o README.md

www/:
	mkdir -p ./www

gif:
	gifcut -b1 "$$(capture -Wt20)" "www/img/window-$$(date +%s).gif"

.PHONY: gif lint test unit www
