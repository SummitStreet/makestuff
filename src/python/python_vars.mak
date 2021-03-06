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

#** makestuff/src/python/python_vars.mak

ifndef __PYTHON_VARS

__PYTHON_VARS=__python_vars
include $(MAKESTUFF)/global_vars.mak

# Additional targets.

PYTHON_CLEAN=python_clean
PYTHON_ENVIRONMENT=python_environment
PYTHON_INIT=python_init
PYTHON_TEST=python_test

# Global variables.

CLEAN_TARGETS+=$(PYTHON_CLEAN)
ENVIRONMENT_TARGETS+=$(PYTHON_ENVIRONMENT)
INIT_TARGETS+=$(PYTHON_INIT)
TEST_TARGETS+=$(PYTHON_TEST)

MAKESTUFF_MERGE_PY=$(MAKESTUFF)/makestuff_merge.py
PYLINT=pylint
PYLINT_ARGS=-r n --persistent=n --disable=I
PYTHON=python
PYTHON_ARGS=
PYTHON_PATH=
PYTHON_TEST_COMPONENTS=

endif
