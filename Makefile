# Dear emacs, this is -*- Makefile -*-
# Created by Andre Anjos <Andre.dos.Anjos@gmail.com>, 20-Mar-2007

# This you must set correctly
RSYNC_MASTER='andreps@andreanjos.org:andreanjos.org'
RSYNC=rsync --rsh=ssh --recursive --times --perms --owner --group --verbose --compress
PYTHON=python2.6

all: bootstrap test

.PHONY: clean restart mrproper generate_bootstrap bootstrap upgrade 

generate_bootstrap:
	$(MAKE) --directory=scripts generate

bootstrap: generate_bootstrap
	@./scripts/bootstrap.py --quiet --no-site-packages --python=$(PYTHON) sw
	@cd sw/lib && if [ ! -L current ]; then ln -s $(PYTHON) current; fi && cd -

upgrade:
	@./scripts/bootstrap.py --quiet --no-site-packages --python=$(PYTHON) --upgrade sw
	@cd sw/lib && if [ ! -L current ]; then ln -s $(PYTHON) current; fi && cd -

restart:
	@skill -15 python

clean: 	
	@find . -name '*~' -print0 | xargs -0 rm -vf 
	$(MAKE) --directory=scripts clean
	$(MAKE) --directory=project clean

mrproper: clean
	@rm -rf sw pip-log.txt
	$(MAKE) --directory=scripts mrproper 
	$(MAKE) --directory=project mrproper 
	@find . -name '*.pyc' -or -name '*.pyo' -print0 | xargs -0 rm -vf

pull:
	@echo 'Pulling Git sources'
	git pull
	@echo 'Synchronize Django database'
	$(RSYNC) $(RSYNC_MASTER)/db.sql3 ./
	@echo 'Synchronize media directory'
	$(RSYNC) $(RSYNC_MASTER)/media ./
	@echo 'Re-compiling language files'
	$(MAKE) --directory=project clean
	@echo 'Synchronization is done'

push:
	@echo 'Pushing Git sources into master repository'
	git push
	@echo 'Copying local database to master server'
	$(RSYNC) ./db.sql3 $(RSYNC_MASTER)/
	@echo 'Synchronizing local media with that of master server'
	$(RSYNC) ./media/ $(RSYNC_MASTER)/media/

test:
	$(MAKE) --directory=project BASEDIR=$(shell pwd) test
