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

#** makestuff/src/global/global_vars.mak

ifndef __GLOBAL_VARS

__GLOBAL_VARS=__global_vars

SHELL=/bin/sh

# Make standard targets, see https://www.gnu.org/software/make/manual/html_node/Standard-Targets.html

ALL=all
CHECK=check
CLEAN=clean
DIST=dist
DISTCLEAN=distclean
DVI=dvi
HTML=html
INFO=info
INSTALL=install
INSTALL_DVI=install-dvi
INSTALL_HTML=install-html
INSTALL_PDF=install-pdf
INSTALL_PS=install-ps
INSTALL_STRIP=install-strip
INSTALLCHECK=installcheck
INSTALLDIRS=installdirs
MAINTAINER_CLEAN=maintainer-clean
MOSTLYCLEAN=mostlyclean
PDF=pdf
PS=ps
UNINSTALL=uninstall
TAGS=TAGS

# Additional targets.

BUILD=build
BUILD_PREAMBLE=build_preamble
BUILD_EPILOGUE=build_epilogue
COMPONENT_CLEAN=component_clean
COMPONENT_ENVIRONMENT=component_environment
COMPONENT_INIT=component_init
COMPONENT_TEST=component_test
DEPENDENCIES=dependencies
ENVIRONMENT=environment
GLOBAL_CLEAN=global_clean
GLOBAL_ENVIRONMENT=global_environment
GLOBAL_INIT=global_init
GLOBAL_TEST=global_test
INIT=init
MAKESTUFF_INIT=makestuff_init
TEST=test
TEST_PREAMBLE=test_preamble
TEST_EPILOGUE=test_epilogue

# Global variables.

CLEAN_TARGETS+=$(GLOBAL_CLEAN)
DISTCLEAN_TARGETS+=$(GLOBAL_DISTCLEAN)
ENVIRONMENT_TARGETS+=$(GLOBAL_ENVIRONMENT)
INIT_TARGETS+=$(MAKESTUFF_INIT) $(GLOBAL_INIT)
TEST_TARGETS+=$(GLOBAL_TEST)

BUILD_DEPENDENCIES=
BUILD_TARGETS=
BUILD_ENVIRONMENT=

SELF=$(strip $(firstword $(MAKEFILE_LIST)))
DATE_TIME=$(shell if [ "`uname`" == "Darwin" ]; then echo "+%Y-%m-%d %H:%M:%S" ; else echo "+%F %T" ; fi)
NOW=`date "$(DATE_TIME)"`
RUN_DATE_TIME=$(shell date "$(DATE_TIME)" | sed "s/[ :-]//g")
GIT=git
GIT_PROTOCOL=https
GIT_CLONE="$(GIT) clone --branch {ver} $(GIT_PROTOCOL)://{repo}.git {dir} >/dev/null 2>/dev/null"
PYTHON=python
SED=sed
SED_ARGS=$(if grep -c 'Darwin',-i "",-i)
SED_MATCH_ARGS=-En
REPO_DIR=.makestuff
DIST_DIR=dist
SRC_DIR=src
TEMP_DIR=temp
MAKESTUFF_JSON=makestuff.json
COMPONENT_GROUP=$(shell cat $(MAKESTUFF_JSON) | $(SED) $(SED_MATCH_ARGS) 's/.*"group"[ ]*:[ ]*"?([^"^,^]*)"?,?/\1/p')
COMPONENT_NAME=$(shell cat $(MAKESTUFF_JSON) | $(SED) $(SED_MATCH_ARGS) 's/.*"name"[ ]*:[ ]*"?([^"^,^]*)"?,?/\1/p')
COMPONENT_VERSION=$(shell cat $(MAKESTUFF_JSON) | $(SED) $(SED_MATCH_ARGS) 's/.*"version"[ ]*:[ ]*"?([^"^,^]*)"?,?/\1/p')

endif
