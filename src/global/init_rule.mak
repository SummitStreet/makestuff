
#** makestuff/src/global/init_rule.mak

EXT_DIR=.dependencies
MAKESTUFF_REPO=github.com/SummitStreet/makestuff@master.git
MAKESTUFF=$(shell python -c 'makestuff_path.py' $(EXT_DIR) $(MAKESTUFF_REPO))

all :

### Initialize/bootstrap makestuff environment
### usage: make [-f <makefile>] init [EXT_DIR=<external_dependency_root_directory>]

init :
	@python -c 'makestuff_init.py' $(EXT_DIR) $(MAKESTUFF_REPO) >/dev/null 2>/dev/null
	@rm -fr $(EXT_DIR)/.makestuff ; mv $(MAKESTUFF)/dist $(EXT_DIR)/.makestuff ; rm -fr $(MAKESTUFF) ; mv $(EXT_DIR)/.makestuff $(MAKESTUFF)

.PHONY : init
