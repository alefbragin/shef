PREFIX ?= /usr/local

.PHONY: all install uninstall

all:

install:
	mkdir --parents ${DESTDIR}${PREFIX}/bin
	cp --force shef ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/shef
	mkdir --parents ${DESTDIR}${PREFIX}/lib/shef
	cp --force --recursive lib/* ${DESTDIR}${PREFIX}/lib/shef
	chmod --recursive 644 ${DESTDIR}${PREFIX}/lib/shef

uninstall:
	rm --force ${PREFIX}/bin/shef
	rm --force --recursive ${PREFIX}/lib/shef
