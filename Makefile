PREFIX ?= /usr/local

.PHONY: all install uninstall test

all:

install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f shef ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/shef
	mkdir -p ${DESTDIR}${PREFIX}/lib/shef
	cp -r -f lib/shef ${DESTDIR}${PREFIX}/lib/shef/
	chmod -R 644 ${DESTDIR}${PREFIX}/lib/shef

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/shef
	rm -r -f ${DESTDIR}${PREFIX}/lib/shef

test:
	tests/inclusion/test
