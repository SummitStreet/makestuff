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

# makestuff/src/python/python_rules.mak

include $(MAKESTUFF)/global_rules.mak

.SUFFIXES :
.SUFFIXES : .py

### Build process-specific goals.

$(MODULE_CLEAN) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)
	@rm -rf $(NPM_DIR)

$(MODULE_PARAMETERS) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYTHON="$(PYTHON)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYTHON_ARGS="$(PYTHON_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYLINT="$(PYLINT)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYLINT_ARGS="$(PYLINT_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYTHON_IMPORT_MACRO="$(PYTHON_IMPORT_MACRO)"

%.py :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Module
	@mkdir -p $(BUILD_DIR)
	@if [ -n "$+" ]; then \
		if cat $+ | grep -q $(PYTHON_IMPORT_MACRO) ; then \
			mkdir -p $(TEMP_DIR) ; \
			cat $+ | grep "^from.*import\|^import" > $(TEMP_DIR)/$@.imports ; \
			cat $+ | sed "/import/d" | sed -e "/$(PYTHON_IMPORT_MACRO)/ {" -e "r $(TEMP_DIR)/$@.imports" -e "d" -e "}" > $(BUILD_DIR)/$@ ; \
			rm -fr $(TEMP_DIR) ; \
		else \
			cat $+ > $(BUILD_DIR)/$@ ; \
		fi ; \
	fi
	@$(PYLINT) $(PYLINT_ARGS) $(BUILD_DIR)/$@ 2>/dev/null

$(RUN_TESTS): $(TEST_TARGETS)
	@echo $(NOW) [SYS] [$(SELF)] [$@] $+
