# Makefile for Paginator
# Documentation: $ make help

SHELL = /bin/sh
makefile = $(lastword $(MAKEFILE_LIST))

.PHONY: all build
all build: jquery.paginator.auto.min.js jquery.paginator.coffee
	@## Create minified production, and coffee, files

%.min.js: src/%.js
	uglifyjs $< > $@

src/jquery.paginator.auto.js: lib/jquery.ba-hashchange.js src/jquery.paginator.js
	cat lib/jquery.ba-hashchange.js LF LF src/jquery.paginator.js | \
		sed '/^[/][/]/d' > src/jquery.paginator.auto.js

jquery.paginator.coffee: src/jquery.paginator.js
	cat $< | js2coffee > $@

.PHONY: check test
check test:
	## Lint the source
	jshint src/jquery.paginator.js

.PHONY: commit
commit: check
	## Commit the code and push to github
	git add .
	git commit -a
	git push origin master

.PHONY: clean
clean:
	## Clean result and intermediate files
	-rm src/jquery.paginator.auto.js
	-rm jquery.paginator.auto.min.js
	-rm jquery.paginator.coffee

.PHONY: help targets
help targets:
	@## Show Makefile targets and their functions
	@sed -n '/^.@*## /{s/@*## //;x;s/:.*//;G;p;};h' $(makefile)
