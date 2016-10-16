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

#** makestuff/src/xml/xml_vars.mak

ifndef __XML_VARS

__XML_VARS=__xml_vars
include $(MAKESTUFF)/global_vars.mak

# Additional targets.

XML_CLEAN=xml_clean
XML_ENVIRONMENT=xml_environment
XML_INIT=xml_init
XML_TEST=xml_test

# Global variables.

CLEAN_TARGETS+=$(XML_CLEAN)
ENVIRONMENT_TARGETS+=$(XML_ENVIRONMENT)
INIT_TARGETS+=$(XML_INIT)
TEST_TARGETS+=$(XML_TEST)

MAKESTUFF_MERGE_PY=$(MAKESTUFF)/makestuff_merge.py
XML_TEST_COMPONENTS=
XML_VALIDATOR=$(PYTHON) -c 'import sys, xml.etree.ElementTree as ET ; ET.parse(sys.argv[1])'

endif
