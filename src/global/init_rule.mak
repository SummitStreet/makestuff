
#** makestuff/src/global/init_rule.mak

REPO_DIR=.makestuff
MAKESTUFF_REPO=github.com/SummitStreet/makestuff@master.git
MAKESTUFF=$(shell python -c 'makestuff_path.py' $(REPO_DIR) $(MAKESTUFF_REPO))

# The default target is 'all'.

all :

### Initialize/bootstrap makestuff environment
### usage: make [-f <makefile>] init [REPO_DIR=<external_repo_base_directory>]

init :
	@rm -fr $(MAKESTUFF)
	@python -c 'makestuff_init.py' $(REPO_DIR) $(MAKESTUFF_REPO) >/dev/null 2>/dev/null
	@rm -fr $(REPO_DIR)/.tmp ; mv $(MAKESTUFF)/dist $(REPO_DIR)/.tmp ; rm -fr $(MAKESTUFF) ; mv $(REPO_DIR)/.tmp $(MAKESTUFF)

.PHONY : all init
