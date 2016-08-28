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

#** makestuff/src/javascript/javascript.mak

ifndef __JAVASCRIPT_RULES

__JAVASCRIPT_RULES=__javascript_rules
include $(MAKESTUFF)/global_rules.mak

.PHONY : $(JAVASCRIPT_CLEAN) $(JAVASCRIPT_ENVIRONMENT) $(JAVASCRIPT_TEST)

%.js :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Module "($^)"
	@mkdir -p $(DIST_DIR)
	@cat $^ > $(DIST_DIR)/$@
	@sed $(SED_ARGS) $(SED_SLC_REGEX) $(DIST_DIR)/$@
	@sed $(SED_ARGS) $(SED_MLC_REGEX) $(DIST_DIR)/$@
	@$(JSLINT) $(JSLINT_ARGS) $(DIST_DIR)/$@

%.js+test :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Test Module
	@$(NODE) $(NODE_ARGS) $(DIST_DIR)/$(*D)/$(*F).js

%.npm :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Install NPM Dependencies
	@if [ ! -d "$(NPM_DIR)/$(subst .git,,$(notdir $(basename $@)))" ]; then \
		if [ ".git" == "$(findstring .git, $(basename $@))" ]; then \
			$(NPM) $(NPM_ARGS) install $(GIT_PROTOCOL)://$(basename $@) > /dev/null ; \
		else \
			$(NPM) $(NPM_ARGS) install $(basename $@) > /dev/null ; \
		fi \
	fi

$(JAVASCRIPT_CLEAN) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)
	@rm -rf $(NPM_DIR)

$(JAVASCRIPT_ENVIRONMENT) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVASCRIPT_TEST_COMPONENTS="$(JAVASCRIPT_TEST_COMPONENTS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JSLINT="$(JSLINT)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JSLINT_ARGS="$(JSLINT_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] NPM="$(NPM)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] NPM_ARGS="$(NPM_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] NPM_DIR="$(NPM_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] NODE="$(NODE)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] NODE_ARGS="$(NODE_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] SED_MLC_REGEX="$(SED_MLC_REGEX)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] SED_SLC_REGEX="$(SED_SLC_REGEX)"

$(JAVASCRIPT_TEST) : $(JAVASCRIPT_TEST_COMPONENTS) $(patsubst %.js,%.js+test,$(JAVASCRIPT_TEST_COMPONENTS))
	@echo $(NOW) [SYS] [$(SELF)] [$@]

endif
