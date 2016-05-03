
# makestuff/src/global/init_rule.mak

EXT_DIR=.dependencies
MAKESTUFF_NAMESPACE=github.com/SummitStreet/makestuff
MAKESTUFF_VERSION=master
MAKESTUFF=$(EXT_DIR)/$(MAKESTUFF_NAMESPACE)/$(MAKESTUFF_VERSION)/dist

all :

### Initialize/bootstrap makestuff environment
### usage: make [-f <makefile>] init [EXT_DIR=<external_dependency_root_directory>]

init :
		package_dir="$(EXT_DIR)/$(MAKESTUFF_NAMESPACE)/$(MAKESTUFF_VERSION)" ; if [ ! -d "$$package_dir" ]; then \
			mkdir -p $$package_dir ; \
			git clone --branch $(MAKESTUFF_VERSION) https://$(MAKESTUFF_NAMESPACE).git $$package_dir >/dev/null 2>/dev/null ; \
		fi

.PHONY : init
