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

# etc/src/global/global_rules.mak

.SUFFIXES :

.PHONY : $(ALL) $(CHECK) $(CLEAN) $(DIST) $(DISTCLEAN) $(DVI) $(INFO) $(INSTALL) $(INSTALLCHECK) $(INSTALLDIRS) $(INSTALL_STRIP) $(MAINTAINER_CLEAN) $(MOSTLYCLEAN) $(UNINSTALL) $(TAGS) $(MODULE_CLEAN) $(COMPONENT_CLEAN) $(GLOBAL_PARAMETERS) $(MODULE_PARAMETERS) $(COMPONENT_PARAMETERS) $(ENVIRONMENT_INFO) $(DEPENDENCIES) $(DEV_DEPENDENCIES) $(BUILD_PREAMBLE) $(BUILD) $(BUILD_EPILOGUE) $(RUN_TESTS) $(TEST_PREAMBLE) $(TEST) $(TEST_EPILOGUE)

%.git :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Install GIT Dependencies
	@namespace=$(shell echo "$@" | sed -n $(SED_REPO_NAMESPACE)) ; \
		version=$(shell echo "$@" | sed -n $(SED_REPO_VERSION)) ; \
		if [ -z "$$version" ]; then \
			version="master" ; \
		fi ; \
		package_dir=$(EXT_DIR)/$$namespace/$$version ; \
		if [ ! -d "$$package_dir" ]; then \
			mkdir -p $$package_dir ; \
			$(GIT) clone --branch $$version $(GIT_PROTOCOL)://$$namespace.git $$package_dir >/dev/null 2>/dev/null ; \
		fi

$(CLEAN) : $(ENVIRONMENT_INFO) $(MODULE_CLEAN) $(COMPONENT_CLEAN)
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)
	@rm -rf $(TEMP_DIR)
	@rm -rf $(BUILD_DIR)

$(DISTCLEAN) : $(ENVIRONMENT_INFO)
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)
	@rm -rf $(TEMP_DIR)
	@rm -rf $(BUILD_DIR)
	@rm -rf $(EXT_DIR)

$(GLOBAL_PARAMETERS) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] SELF="$(SELF)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] ENV="$(ENV)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] BUILD_DIR="$(BUILD_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] SOURCE_DIR="$(SOURCE_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] TEMP_DIR="$(TEMP_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] MAKESTUFF="$(MAKESTUFF)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] BUILD_DEPENDENCIES="$(BUILD_DEPENDENCIES)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] BUILD_TARGETS="$(BUILD_TARGETS)"

$(ENVIRONMENT_INFO) : $(GLOBAL_PARAMETERS) $(MODULE_PARAMETERS) $(COMPONENT_PARAMETERS)
	@echo $(NOW) [SYS] [$(SELF)] [$@] Environment Info

$(DEPENDENCIES) : $(BUILD_DEPENDENCIES)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(BUILD_PREAMBLE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Started

$(BUILD_EPILOGUE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Completed

$(BUILD) : $(DEPENDENCIES) $(BUILD_PREAMBLE) $(BUILD_TARGETS) $(BUILD_EPILOGUE)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(ALL) : $(ENVIRONMENT_INFO) $(BUILD)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

$(TEST_PREAMBLE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Tests Started

$(TEST_EPILOGUE) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Tests Completed

$(TEST): $(ENVIRONMENT_INFO) $(BUILD) $(TEST_PREAMBLE) $(RUN_TESTS) $(TEST_EPILOGUE)
	@echo $(NOW) [SYS] [$(SELF)] [$@]
