SHELL := /bin/bash
all: test www

test: lint unit structure

lint:
	shellcheck ./bin/cz

unit:
	./test/unit

structure:
	./test/structure

WWW_SOURCES := $(wildcard www/*.org)

%.html: %.org
	pandoc -s $< -o $@

www: www/ $(WWW_SOURCES:.org=.html) README.md

README.md: www/index.org
	pandoc -s www/index.org -t gfm -o README.md

www/:
	mkdir -p ./www

gif:
	gifcut -b1 "$$(capture -W)" "www/img/window-$$(date +%s).gif"

docker: docker-build
	docker run -i -t cz

docker-build:
	docker build -t cz .

.PHONY: gif docker docker-build lint test unit www
