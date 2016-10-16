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

#** makestuff/src/c/c_vars.mak

ifndef __C_VARS

__C_VARS=__c_vars
include $(MAKESTUFF)/global_vars.mak

# Additional targets.

C_CLEAN=C_clean
C_ENVIRONMENT=c_environment
C_INIT=c_init
C_TEST=c_test

# Global variables.

CLEAN_TARGETS+=$(C_CLEAN)
ENVIRONMENT_TARGETS+=$(C_ENVIRONMENT)
INIT_TARGETS+=$(C_INIT)
TEST_TARGETS+=$(C_TEST)

C_TEST_COMPONENTS=
CC=gcc
CC_COMPILE_OPTS=-std=c99
CC_LINK_OPTS=

endif
