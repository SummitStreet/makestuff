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

# makestuff/src/c/c_rules.mak

include $(MAKEFILE_DIR)/global_rules.mak

### Build process-specific goals.

$(MODULE_PARAMETERS) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] CC="$(CC)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] CC_COMPILE_OPTS="$(CC_COMPILE_OPTS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] CC_LINK_OPTS="$(CC_LINK_OPTS)"

$(TEMP_DIR)/%.o : %.c
	@echo $(NOW) [SYS] [$(SELF)] [$@] Compile $^
	@$(CC) $(CC_COMPILE_OPTS) -c $< -o $@

$(BUILD_TARGET) : $(addprefix $(TEMP_DIR)/, $(OBJECT_FILES))
	@echo $(NOW) [SYS] [$(SELF)] [$@] Link $^
	@$(CC) $(CC_LINK_OPTS) $^ -o $@

$(RUN_TESTS) : $(TEST_TARGETS)
	@echo $(NOW) [SYS] [$(SELF)] [$@] $^
