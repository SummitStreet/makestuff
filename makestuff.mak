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

# makestuff/makestuff.mak

REPO_DIR=.makestuff
MAKESTUFF=src/global
include src/python/python_vars.mak
MAKESTUFF_MERGE_PY=src/main/python/makestuff_merge.py

REPO_DIR=.makestuff
LAUNCHPAD_REPO=github.com/SummitStreet/launchpad@master.git
LAUNCHPAD=$(shell python -c 'import os, re, sys ; R, V = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups() ; print os.sep.join([sys.argv[1], R, V[1:]])' $(REPO_DIR) $(LAUNCHPAD_REPO))

$(ALL) :

### Initialize/bootstrap makestuff environment
### usage: make [-f <makefile>] init [REPO_DIR=<external_repo_base_directory>]

init :
	@python -c 'import os, re, sys ; C = "git clone --branch {1} https://{0}.git {2}" ; R, V = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups() ; D = os.sep.join([sys.argv[1], R, V[1:]]) ; None if os.path.isdir(D) else os.system(C.format(R, V[1:], D))' $(REPO_DIR) $(LAUNCHPAD_REPO) >/dev/null 2>/dev/null
	@rm -fr $(REPO_DIR)/.tmp ; mv $(LAUNCHPAD)/src/main/python $(REPO_DIR)/.tmp ; rm -fr $(LAUNCHPAD) ; mv $(REPO_DIR)/.tmp $(LAUNCHPAD)

BUILD_TARGETS=\
	global_rules.mak \
	global_vars.mak \
	c.mak \
	c_rules.mak \
	c_vars.mak \
	generic.mak \
	generic_rules.mak \
	generic_vars.mak \
	javascript.mak \
	javascript_rules.mak \
	javascript_vars.mak \
	python.mak \
	python_rules.mak \
	python_vars.mak \
	makestuff.py \
	makestuff_merge.py \
	__clean

%.mak :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Makefile Module
	@mkdir -p $(DIST_DIR)
	@cat $^ > $(DIST_DIR)/$@

$(TEMP_DIR)/init_rule.mak+py : $(SOURCE_DIR)/main/python/inline.py $(SOURCE_DIR)/main/python/makestuff_init.py $(SOURCE_DIR)/main/python/makestuff_path.py
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Module "($^)"
	@mkdir -p $(TEMP_DIR)
	$(foreach script,$^,$(shell pylint -r n -E --persistent=n $(script) 2>/dev/null))
	@cat $(SOURCE_DIR)/global/init_rule.mak | sed 's/makestuff_init.py/$(shell cat $(SOURCE_DIR)/main/python/makestuff_init.py | python $(SOURCE_DIR)/main/python/inline.py)/' | sed 's/makestuff_path.py/$(shell cat $(SOURCE_DIR)/main/python/makestuff_path.py | python $(SOURCE_DIR)/main/python/inline.py)/' > $@

__clean :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Removing Temporary Files
	@rm -fr $(TEMP_DIR)

global_rules.mak : \
	$(SOURCE_DIR)/global/global_rules.mak

global_vars.mak : \
	$(SOURCE_DIR)/global/global_vars.mak

c.mak : \
	$(SOURCE_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SOURCE_DIR)/c/c.mak

c_rules.mak : \
	$(SOURCE_DIR)/c/c_rules.mak

c_vars.mak : \
	$(SOURCE_DIR)/c/c_vars.mak

generic.mak : \
	$(SOURCE_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SOURCE_DIR)/generic/generic.mak

generic_rules.mak : \
	$(SOURCE_DIR)/generic/generic_rules.mak

generic_vars.mak : \
	$(SOURCE_DIR)/generic/generic_vars.mak

javascript.mak : \
	$(SOURCE_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SOURCE_DIR)/javascript/javascript.mak

javascript_rules.mak : \
	$(SOURCE_DIR)/javascript/javascript_rules.mak

javascript_vars.mak : \
	$(SOURCE_DIR)/javascript/javascript_vars.mak

python.mak : \
	$(SOURCE_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SOURCE_DIR)/python/python.mak

python_rules.mak : \
	$(SOURCE_DIR)/python/python_rules.mak

python_vars.mak : \
	$(SOURCE_DIR)/python/python_vars.mak

makestuff.py : \
	$(LAUNCHPAD)/service.py \
	$(SOURCE_DIR)/main/python/makestuff.py

makestuff_merge.py : \
	$(SOURCE_DIR)/main/python/makestuff_merge.py

include src/python/python_rules.mak
