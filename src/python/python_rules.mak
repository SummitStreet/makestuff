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

#** makestuff/src/python/python_rules.mak

ifndef __PYTHON_RULES

__PYTHON_RULES=__python_rules
include $(MAKESTUFF)/global_rules.mak

.PHONY : $(PYTHON_CLEAN) $(PYTHON_ENVIRONMENT) $(PYTHON_INIT) $(PYTHON_TEST)

%.py :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Module "($^)"
	@mkdir -p $(dir $@)
	@$(PYTHON) $(PYTHON_ARGS) $(MAKESTUFF_MERGE_PY) $^ > $@
	@$(PYLINT) $(PYLINT_ARGS) $@ 2>/dev/null

%.py+test :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Test Module
	@export PYTHONPATH=$(PYTHON_PATH):$(PYTHONPATH) ; \
		$(PYLINT) $(PYLINT_ARGS) $(*D)/$(*F).py 2>/dev/null ; \
		$(PYTHON) $(PYTHON_ARGS) $(*D)/$(*F).py

$(PYTHON_CLEAN) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)

$(PYTHON_ENVIRONMENT) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYTHON="$(PYTHON)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYTHON_ARGS="$(PYTHON_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYTHON_PATH="$(PYTHON_PATH)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYLINT="$(PYLINT)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYLINT_ARGS="$(PYLINT_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYTHON_TEST_TARGETS="$(PYTHON_TEST_TARGETS)"

$(PYTHON_INIT) :
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(PYTHON_TEST) : $(PYTHON_TEST_COMPONENTS) $(patsubst %.py,%.py+test,$(PYTHON_TEST_COMPONENTS))
	@echo $(NOW) [SYS] [$(SELF)] [$@]

endif
