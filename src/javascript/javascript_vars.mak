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

#** makestuff/src/javascript/javascript_vars.mak

ifndef __JAVASCRIPT_VARS

__JAVASCRIPT_VARS=__javascript_vars
include $(MAKESTUFF)/global_vars.mak

# Additional targets.

JAVASCRIPT_CLEAN=javascript_clean
JAVASCRIPT_ENVIRONMENT=javascript_environment
JAVASCRIPT_TEST=javascript_test

# JavaScript-specific variables.

CLEAN_TARGETS+=$(JAVASCRIPT_CLEAN)
ENVIRONMENT_TARGETS+=$(JAVASCRIPT_ENVIRONMENT)
TEST_TARGETS+=$(JAVASCRIPT_TEST)

JAVASCRIPT_TEST_COMPONENTS=
JSLINT=eslint
JSLINT_ARGS=
NPM=npm
NPM_ARGS=
NPM_DIR=node_modules
NODE=node
NODE_ARGS=
SED_MLC_REGEX="/\/\*\*/,/\*\//d"
SED_SLC_REGEX="/\/\//d"

endif
