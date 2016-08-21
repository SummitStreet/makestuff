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

include $(MAKESTUFF)/global_rules.mak

.SUFFIXES :
.SUFFIXES : .js .js.git

### Build process-specific goals.

$(MODULE_CLEAN) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)
	@rm -rf $(NPM_DIR)

$(MODULE_PARAMETERS) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] ETC_BIN="$(ETC_BIN)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] NPM_DIR="$(NPM_DIR)"

%.npm :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Install NPM Dependencies
	@if [ ! -d "$(NPM_DIR)/$(subst .git,,$(notdir $(basename $@)))" ]; then \
		if [ ".git" == "$(findstring .git, $(basename $@))" ]; then \
			$(NPM) $(NPM_ARGS) install $(GIT_PROTOCOL)://$(basename $@) > /dev/null ; \
		else \
			$(NPM) $(NPM_ARGS) install $(basename $@) > /dev/null ; \
		fi \
	fi

%.js :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Module
	@mkdir -p $(DIST_DIR)
	@cat $^ > $(DIST_DIR)/$@
	@sed $(SED_ARGS) $(SED_SLC_REGEX) $(DIST_DIR)/$@
	@sed $(SED_ARGS) $(SED_MLC_REGEX) $(DIST_DIR)/$@
	@$(JSLINT) $(JSLINT_ARGS) $(DIST_DIR)/$@

$(RUN_TESTS) : $(TEST_TARGETS)
	@echo $(NOW) [SYS] [$(SELF)] [$@] $^
	@$(foreach test,$^,$(NODE) $(NODE_ARGS) $(DIST_DIR)/$(test))
