PREFIX ?= /usr/local

.PHONY: all install uninstall

all:

install:
	install -D --mode=755 shef $(PREFIX)/bin/
	cd lib && find . -type f \
		| xargs -I _ install -D --mode=644 _ $(PREFIX)/lib/shef/_

uninstall:
	rm $(PREFIX)/bin/shef
	rm --recursive $(PREFIX)/lib/shef
