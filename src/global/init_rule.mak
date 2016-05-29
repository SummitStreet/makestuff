
# makestuff/src/global/init_rule.mak

EXT_DIR=.dependencies
GIT_CLONE="git clone --branch {ver} https://{repo}.git {dir} >/dev/null 2>/dev/null"
MAKESTUFF_REPO=github.com/SummitStreet/makestuff@master.git
MAKESTUFF=$(EXT_DIR)/github.com/SummitStreet/makestuff/master/dist

all :

### Initialize/bootstrap makestuff environment
### usage: make [-f <makefile>] init [EXT_DIR=<external_dependency_root_directory>]

init :
	@python -c 'init_rule.py' $(EXT_DIR) $(MAKESTUFF_REPO) $(GIT_CLONE)

.PHONY : init
