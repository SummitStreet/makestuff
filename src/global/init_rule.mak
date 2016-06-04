
#** makestuff/src/global/init_rule.mak

EXT_DIR=.dependencies
MAKESTUFF_REPO=github.com/SummitStreet/makestuff@master.git
MAKESTUFF=`python -c 'makestuff_path.py' $(EXT_DIR) $(MAKESTUFF_REPO)`
GIT_CLONE="git clone --branch {ver} https://{repo}.git {dir} >/dev/null 2>/dev/null"

all :

### Initialize/bootstrap makestuff environment
### usage: make [-f <makefile>] init [EXT_DIR=<external_dependency_root_directory>]

init :
	@python -c 'makestuff_init.py' $(EXT_DIR) $(MAKESTUFF_REPO) $(GIT_CLONE)

.PHONY : init
