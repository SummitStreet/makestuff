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

ALL=all
CLEAN=clean

# Additional targets.

BUILD=build
BUILD_PREAMBLE=build_preamble
BUILD_EPILOGUE=build_epilogue
ENVIRONMENT_INFO=environment_info
GLOBAL_PARAMETERS=global_parameters

SELF=$(strip $(firstword $(MAKEFILE_LIST)))
DATE_TIME=$(shell if [ "`uname`" == "Darwin" ]; then echo "+%Y-%m-%d %H:%M:%S" ; else echo "+%F %T" ; fi)
NOW=`date "$(DATE_TIME)"`
SED_ARGS=$(if grep -c 'Darwin',-i "",-i)
DIST_DIR=dist
SOURCE_DIR=src
TEMP_DIR=temp

.SUFFIXES :
.PHONY : $(ALL) $(CLEAN) $(GLOBAL_PARAMETERS) $(ENVIRONMENT_INFO) $(BUILD_PREAMBLE) $(BUILD) $(BUILD_EPILOGUE)

$(ALL) :

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
	makestuff_merge.py

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
	$(SOURCE_DIR)/main/python/makestuff.py

makestuff_merge.py : \
	$(SOURCE_DIR)/main/python/makestuff_merge.py

$(TEMP_DIR)/init_rule.mak+py : $(SOURCE_DIR)/main/python/inline.py $(SOURCE_DIR)/main/python/makestuff_init.py $(SOURCE_DIR)/main/python/makestuff_path.py
	@mkdir -p $(TEMP_DIR)
	$(foreach script,$^,$(shell pylint -r n -E --persistent=n $(script) 2>/dev/null))
	@cat $(SOURCE_DIR)/global/init_rule.mak | sed 's/makestuff_init.py/$(shell cat $(SOURCE_DIR)/main/python/makestuff_init.py | python $(SOURCE_DIR)/main/python/inline.py)/' | sed 's/makestuff_path.py/$(shell cat $(SOURCE_DIR)/main/python/makestuff_path.py | python $(SOURCE_DIR)/main/python/inline.py)/' > $@

%.py :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Python Module
	@mkdir -p $(DIST_DIR)
	@cat $^ > $(DIST_DIR)/$@
	@pylint -r n -E --persistent=n $(DIST_DIR)/$@ 2>/dev/null

%.mak :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Makefile Module
	@mkdir -p $(DIST_DIR)
	@cat $^ > $(DIST_DIR)/$@

$(CLEAN) : $(ENVIRONMENT_INFO)
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)
	@rm -rf $(DIST_DIR) $(TEMP_DIR)

$(GLOBAL_PARAMETERS) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] SELF="$(SELF)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] DIST_DIR="$(DIST_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] BUILD_TARGETS="$(BUILD_TARGETS)"

$(ENVIRONMENT_INFO) : $(GLOBAL_PARAMETERS)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(BUILD_PREAMBLE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Started

$(BUILD_EPILOGUE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Completed

$(BUILD) : $(BUILD_PREAMBLE) $(BUILD_TARGETS) $(BUILD_EPILOGUE)
	@echo $(NOW) [SYS] [$(SELF)] [$@]
	@rm -rf $(TEMP_DIR)

$(ALL) : $(ENVIRONMENT_INFO) $(BUILD)
	@echo $(NOW) [SYS] [$(SELF)] [$@]
