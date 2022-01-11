PACKAGE = setup
VERSION = 2.9.4
GITPATH = git@github.com:OpenMandrivaSoftware/setup.git

LIST =	csh.cshrc csh.login ethertypes host.conf hosts.allow hosts.deny inputrc \
	motd motd-ssh printcap protocols services shells profile \
	filesystems hosts

FILES = $(LIST) Makefile NEWS

all:

clean:
	rm -f *~ \#*\#

install:
	install -d -m 755 $(DESTDIR)/etc/
	install -d -m 755 $(DESTDIR)/etc/profile.d
	install -d -m 755 $(DESTDIR)/var/log/
	for i in $(LIST); do \
		cp -avf $$i $(DESTDIR)/etc/$$i; \
	done
	install -m 755 10lang.sh $(DESTDIR)/etc/profile.d/10lang.sh
	install -m 755 10lang.csh $(DESTDIR)/etc/profile.d/10lang.csh
	install -m 755 10inputrc.sh $(DESTDIR)/etc/profile.d/10inputrc.sh
	install -m 755 10inputrc.csh $(DESTDIR)/etc/profile.d/10inputrc.csh
	touch $(DESTDIR)/var/log/lastlog
	install -m644 group -D $(DESTDIR)/etc/group
	sed -e 's/:[0-9]\+:/::/g' group > $(DESTDIR)/etc/gshadow
	install -m644 passwd -D $(DESTDIR)/etc/passwd
	sed -e "s/:.*/:*:`expr $(shell date +%s) / 86400`:0:99999:7:::/" passwd > $(DESTDIR)/etc/shadow
	sed -i -e 's/^\([^:]\+\):[^:]*:/\1:x:/' $(DESTDIR)/etc/{passwd,group}

# rules to build a public distribution

dist: tar gittag

tar:
	git archive --format=tar --prefix=$(PACKAGE)-$(VERSION)/ HEAD | xz -vf > $(PACKAGE)-$(VERSION).tar.xz

gittag:
	git tag 'v$(VERSION)'
