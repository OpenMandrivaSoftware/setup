mandir = /usr/share/man

all:

clean:

install:
	install -D -m 644 group $(DESTDIR)/etc/group
	install -D -m 644 passwd $(DESTDIR)/etc/passwd
	sed -e 's/:[0-9]\+:/::/g' group > $(DESTDIR)/etc/gshadow
	sed -e "s/:.*/:*:`expr $(shell date +%s) / 86400`:0:99999:7:::/" passwd > $(DESTDIR)/etc/shadow
	sed -i -e 's/^\([^:]\+\):[^:]*:/\1:x:/' $(DESTDIR)/etc/{passwd,group}
