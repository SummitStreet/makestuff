#
# The MIT License (MIT)
#
# Copyright (c) 2015 David Padgett/Summit Street, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# makestuff/src/global/init_rule.mak

EXT_DIR=.dependencies
MAKESTUFF_NAMESPACE=github.com/SummitStreet/makestuff
MAKESTUFF_VERSION=master
MAKESTUFF=$(EXT_DIR)/$(MAKESTUFF_NAMESPACE)/$(MAKESTUFF_VERSION)/dist

all :

### Initialize/bootstrap makestuff environment
### usage: make [-f <makefile>] init [EXT_DIR=<external_dependency_root_directory>]

init :
		@package_dir="$(EXT_DIR)/$(MAKESTUFF_NAMESPACE)/$(MAKESTUFF_VERSION)" ; if [ ! -d "$$package_dir" ]; then \
			mkdir -p $$package_dir ; \
			git clone --branch $(MAKESTUFF_VERSION) https://$(MAKESTUFF_NAMESPACE).git $$package_dir >/dev/null 2>/dev/null ; \
		fi

.PHONY : init

# makestuff/src/python/python.mak

-include $(MAKESTUFF)/python_vars.mak

BUILD_DEPENDENCIES=\
	github.com/account/repo@version.git

BUILD_TARGETS=\
	component.py

TEST_TARGETS=\
	test.py

component.py : $(SOURCE_DIR)/main/python/component.py

test.py : $(SOURCE_DIR)/test/python/test.py

-include $(MAKESTUFF)/python_rules.mak
