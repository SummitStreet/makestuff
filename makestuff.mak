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
INIT_TARGETS+=makestuff_init
MAKESTUFF_MERGE_PY=src/main/python/makestuff_merge.py

REPO_DIR=.makestuff
LAUNCHPAD_REPO=github.com/SummitStreet/launchpad@master.git
LAUNCHPAD=$(shell python -c 'import os, re, sys ; R, V = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups() ; print os.sep.join([sys.argv[1], R, V[1:]])' $(REPO_DIR) $(LAUNCHPAD_REPO))

$(ALL) :

### Initialize/bootstrap makestuff environment
### usage: make [-f <makefile>] init [REPO_DIR=<external_repo_base_directory>]

__makestuff_clean :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Removing Temporary Files
	@rm -fr $(TEMP_DIR)

$(COMPONENT_ENVIRONMENT) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] MAKESTUFF_MERGE_PY="$(MAKESTUFF_MERGE_PY)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] LAUNCHPAD_REPO="$(LAUNCHPAD_REPO)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] LAUNCHPAD="$(LAUNCHPAD)"

$(COMPONENT_INIT) :
	@rm -fr $(LAUNCHPAD)
	@python -c 'import os, re, sys ; C = "git clone --branch {1} https://{0}.git {2}" ; R, V = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups() ; D = os.sep.join([sys.argv[1], R, V[1:]]) ; None if os.path.isdir(D) else os.system(C.format(R, V[1:], D))' $(REPO_DIR) $(LAUNCHPAD_REPO) >/dev/null 2>/dev/null
	@rm -fr $(REPO_DIR)/.tmp ; mv $(LAUNCHPAD)/dist $(REPO_DIR)/.tmp ; rm -fr $(LAUNCHPAD) ; mv $(REPO_DIR)/.tmp $(LAUNCHPAD)

BUILD_TARGETS=\
	$(DIST_DIR)/global_rules.mak \
	$(DIST_DIR)/global_vars.mak \
	$(DIST_DIR)/c.mak \
	$(DIST_DIR)/c_rules.mak \
	$(DIST_DIR)/c_vars.mak \
	$(DIST_DIR)/generic.mak \
	$(DIST_DIR)/generic_rules.mak \
	$(DIST_DIR)/generic_vars.mak \
	$(DIST_DIR)/java.mak \
	$(DIST_DIR)/java_rules.mak \
	$(DIST_DIR)/java_vars.mak \
	$(DIST_DIR)/javascript.mak \
	$(DIST_DIR)/javascript_rules.mak \
	$(DIST_DIR)/javascript_vars.mak \
	$(DIST_DIR)/makestuff.json \
	$(DIST_DIR)/python.mak \
	$(DIST_DIR)/python_rules.mak \
	$(DIST_DIR)/python_vars.mak \
	$(DIST_DIR)/makestuff.py \
	$(DIST_DIR)/makestuff_merge.py \
	$(DIST_DIR)/xml.mak \
	$(DIST_DIR)/xml_rules.mak \
	$(DIST_DIR)/xml_vars.mak \
	__makestuff_clean

%.json :
	@echo $(NOW) [SYS] [$(SELF)] [$@]
	@mkdir -p $(dir $@)
	@cat $^ > $@

%.mak :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Makefile Module
	@mkdir -p $(dir $@)
	@cat $^ > $@

$(TEMP_DIR)/init_rule.mak+py : $(SRC_DIR)/main/python/inline.py $(SRC_DIR)/main/python/makestuff_init.py $(SRC_DIR)/main/python/makestuff_path.py
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Module "($^)"
	@mkdir -p $(TEMP_DIR)
	$(foreach script,$^,$(shell pylint -r n -E --persistent=n $(script) 2>/dev/null))
	@cat $(SRC_DIR)/global/init_rule.mak | sed 's/makestuff_init.py/$(shell cat $(SRC_DIR)/main/python/makestuff_init.py | python $(SRC_DIR)/main/python/inline.py)/' | sed 's/makestuff_path.py/$(shell cat $(SRC_DIR)/main/python/makestuff_path.py | python $(SRC_DIR)/main/python/inline.py)/' > $@

$(DIST_DIR)/global_rules.mak : \
	$(SRC_DIR)/global/global_rules.mak

$(DIST_DIR)/global_vars.mak : \
	$(SRC_DIR)/global/global_vars.mak

$(DIST_DIR)/c.mak : \
	$(SRC_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SRC_DIR)/c/c.mak

$(DIST_DIR)/c_rules.mak : \
	$(SRC_DIR)/c/c_rules.mak

$(DIST_DIR)/c_vars.mak : \
	$(SRC_DIR)/c/c_vars.mak

$(DIST_DIR)/generic.mak : \
	$(SRC_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SRC_DIR)/generic/generic.mak

$(DIST_DIR)/generic_rules.mak : \
	$(SRC_DIR)/generic/generic_rules.mak

$(DIST_DIR)/generic_vars.mak : \
	$(SRC_DIR)/generic/generic_vars.mak

$(DIST_DIR)/java.mak : \
	$(SRC_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SRC_DIR)/java/java.mak

$(DIST_DIR)/java_rules.mak : \
	$(SRC_DIR)/java/java_rules.mak

$(DIST_DIR)/java_vars.mak : \
	$(SRC_DIR)/java/java_vars.mak

$(DIST_DIR)/javascript.mak : \
	$(SRC_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SRC_DIR)/javascript/javascript.mak

$(DIST_DIR)/javascript_rules.mak : \
	$(SRC_DIR)/javascript/javascript_rules.mak

$(DIST_DIR)/javascript_vars.mak : \
	$(SRC_DIR)/javascript/javascript_vars.mak

$(DIST_DIR)/makestuff.json : \
	$(SRC_DIR)/main/conf/makestuff.json

$(DIST_DIR)/python.mak : \
	$(SRC_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SRC_DIR)/python/python.mak

$(DIST_DIR)/python_rules.mak : \
	$(SRC_DIR)/python/python_rules.mak

$(DIST_DIR)/python_vars.mak : \
	$(SRC_DIR)/python/python_vars.mak

$(DIST_DIR)/makestuff.py : \
	$(LAUNCHPAD)/service.py \
	$(SRC_DIR)/main/python/makestuff.py

$(DIST_DIR)/makestuff_merge.py : \
	$(SRC_DIR)/main/python/makestuff_merge.py

$(DIST_DIR)/xml.mak : \
	$(SRC_DIR)/global/license.mak \
	$(TEMP_DIR)/init_rule.mak+py \
	$(SRC_DIR)/xml/xml.mak

$(DIST_DIR)/xml_rules.mak : \
	$(SRC_DIR)/xml/xml_rules.mak

$(DIST_DIR)/xml_vars.mak : \
	$(SRC_DIR)/xml/xml_vars.mak

include src/python/python_rules.mak
