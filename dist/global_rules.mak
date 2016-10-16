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

#** makestuff/src/global/global_rules.mak

ifndef __GLOBAL_RULES

__GLOBAL_RULES=__global_rules

CLEAN_TARGETS+=$(COMPONENT_CLEAN)
ENVIRONMENT_TARGETS+=$(COMPONENT_ENVIRONMENT)
INIT_TARGETS+=$(COMPONENT_INIT)
TEST_TARGETS+=$(COMPONENT_TEST)

.PHONY : $(ALL) $(CHECK) $(CLEAN) $(DIST) $(DISTCLEAN) $(DVI) $(HTML) $(INFO) $(INSTALL) $(INSTALL_DVI) $(INSTALL_HTML) $(INSTALL_PDF) $(INSTALL_PS) $(INSTALL_STRIP) $(INSTALLCHECK) $(INSTALLDIRS) $(MAINTAINER_CLEAN) $(MOSTLYCLEAN) $(PDF) $(PS) $(UNINSTALL) $(TAGS) $(BUILD) $(BUILD_PREAMBLE) $(BUILD_EPILOGUE) $(DEPENDENCIES) $(ENVIRONMENT) $(MAKESTUFF_INIT) $(GLOBAL_CLEAN) $(GLOBAL_ENVIRONMENT) $(GLOBAL_INIT) $(GLOBAL_TEST) $(INIT) $(TEST) $(TEST_PREAMBLE) $(TEST_EPILOGUE) $(COMPONENT_CLEAN) $(COMPONENT_ENVIRONMENT) $(COMPONENT_INIT) $(COMPONENT_TEST)

%.git :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Install GIT Dependencies
	@$(PYTHON) $(MAKESTUFF)/makestuff.py --repo $@ install

$(ALL) : $(ENVIRONMENT) $(BUILD)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(CHECK) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(CLEAN) : $(ENVIRONMENT) $(CLEAN_TARGETS)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(DIST) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(DISTCLEAN) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)
	@rm -rf $(TEMP_DIR)
	@rm -rf $(DIST_DIR)
	@rm -rf $(REPO_DIR)

$(DVI) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(HTML) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INFO) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INSTALL) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INSTALL_DVI) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INSTALL_HTML) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INSTALL_PDF) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INSTALL_PS) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INSTALL_STRIP) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INSTALLCHECK) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INSTALLDIRS) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(MAINTAINER_CLEAN) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(MOSTLYCLEAN) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(PDF) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(PS) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(UNINSTALL) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(TAGS) : $(ENVIRONMENT)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(BUILD) : $(DEPENDENCIES) $(BUILD_PREAMBLE) $(BUILD_TARGETS) $(BUILD_EPILOGUE)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(BUILD_EPILOGUE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Completed

$(BUILD_PREAMBLE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Started

$(DEPENDENCIES) : $(BUILD_DEPENDENCIES)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(ENVIRONMENT) : $(ENVIRONMENT_TARGETS)
	@echo $(NOW) [SYS] [$(SELF)] [$@] Environment

$(GLOBAL_CLEAN) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)
	@rm -rf $(TEMP_DIR)
	@rm -rf $(DIST_DIR)

$(GLOBAL_ENVIRONMENT) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] SELF="$(SELF)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] COMPONENT_GROUP="$(COMPONENT_GROUP)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] COMPONENT_NAME="$(COMPONENT_NAME)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] COMPONENT_VERSION="$(COMPONENT_VERSION)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] BUILD_TARGETS="$(BUILD_TARGETS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] BUILD_DEPENDENCIES="$(BUILD_DEPENDENCIES)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] DIST_DIR="$(DIST_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] SRC_DIR="$(SRC_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] TEMP_DIR="$(TEMP_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] MAKESTUFF="$(MAKESTUFF)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] MAKESTUFF_JSON="$(MAKESTUFF_JSON)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] MAKESTUFF_REPO="$(MAKESTUFF_REPO)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] REPO_DIR="$(REPO_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] DATE_TIME="$(DATE_TIME)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] RUN_DATE_TIME="$(RUN_DATE_TIME)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] NOW="$(NOW)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] GIT="$(GIT)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] GIT_PROTOCOL="$(GIT_PROTOCOL)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] GIT_CLONE="$(GIT_CLONE)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] SED="$(SED)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] SED_ARGS="$(SED_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] PYTHON="$(PYTHON)"

$(GLOBAL_INIT) :
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(GLOBAL_TEST) :
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INIT) : $(ENVIRONMENT) $(INIT_PREAMBLE) $(INIT_TARGETS) $(INIT_EPILOGUE)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(INIT_EPILOGUE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Makestuff Initialization Completed

$(INIT_PREAMBLE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Makestuff Initialization Started

$(TEST) : $(ENVIRONMENT) $(BUILD) $(TEST_PREAMBLE) $(TEST_TARGETS) $(TEST_EPILOGUE)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(TEST_EPILOGUE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Tests Completed

$(TEST_PREAMBLE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Tests Started

endif
