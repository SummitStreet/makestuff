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

# etc/src/global/global_vars.mak

SHELL=/bin/sh

# Make standard targets.

# ALL
#	Compile the entire program.
# CHECK
#	Perform self-tests (if any).
# CLEAN
#	Delete all files from the current directory that are normally created by
#	builidng the program.
# DIST
#	Create a distribution tar file for this program.
# DISTCLEAN
#	Delete all files from the current directory that are created by
#	configuring or building the program.
# DVI
#	Generate DVI files for all Texinfo documentation.
# INFO
#	Generate any info files needed.
# INSTALL
#	Compile the program and copy the executables, libraries, and so on to
#	the file names where they should reside for actual use.
# INSTALLCHECK
#	Perofmr installation tests (if any).
# INSTALLDIRS
#	It's useful to add a target named 'installdirs' to create the
#	directorieswhere files are installed, and their parent directories.
# INSTALL_STRIP
#	Like install, but strip the executable files while installing them.
# MAINTAINER_CLEAN
#	Delete almost everything from the current directory that can be
#	reconstructed with this Makefile.
# MOSTLYCLEAN
#	Like 'clean', but may refrain from deleting a few files that people
#	normally don't want to recompile.
# UNINSTALL
#	Delete all the installed files--the copies that the 'install' target
#	creates.
# TAGS
#	Update a tags table for this program.

ALL=all
CHECK=check
CLEAN=clean
DIST=dist
DISTCLEAN=distclean
DVI=dvi
INFO=info
INSTALL=install
INSTALLCHECK=installcheck
INSTALLDIRS=installdirs
INSTALL_STRIP=install-strip
MAINTAINER_CLEAN=maintainer-clean
MOSTLYCLEAN=mostlyclean
UNINSTALL=uninstall
TAGS=TAGS

# Additional targets.

MODULE_CLEAN=module_clean
COMPONENT_CLEAN=component_clean
DEPENDENCIES=dependencies
DEV_DEPENDENCIES=dev_dependencies
BUILD=build
BUILD_PREAMBLE=build_preamble
BUILD_EPILOGUE=build_epilogue
TEST=test
TEST_PREAMBLE=test_preamble
TEST_EPILOGUE=test_epilogue
RUN_TESTS=run_tests
ENVIRONMENT_INFO=environment_info
GLOBAL_PARAMETERS=global_parameters
MODULE_PARAMETERS=module_parameters
COMPONENT_PARAMETERS=component_parameters

SELF=$(strip $(firstword $(MAKEFILE_LIST)))
DATE_TIME=$(shell if [ "`uname`" == "Darwin" ]; then echo "+%Y-%m-%d %H:%M:%S" ; else echo "+%F %T" ; fi)
NOW=`date "$(DATE_TIME)"`
RUN_DATE_TIME=$(shell date "$(DATE_TIME)" | sed "s/[ :-]//g")
GIT=git
GIT_PROTOCOL=https
GIT_CLONE="$(GIT) clone --branch {1} $(GIT_PROTOCOL)://{0}.git {2} >/dev/null 2>/dev/null"
SED=sed
SED_ARGS=$(if grep -c 'Darwin',-i "",-i)
SED_REPO_NAMESPACE="s/\([^@]*\)\(@\(.*\)\)*\.git/\1/p"
SED_REPO_VERSION="s/\([^@]*\)\(@\(.*\)\)*\.git/\3/p"
BUILD_INFO=build_info
BUILD_DIR=dist
SOURCE_DIR=src
TEMP_DIR=temp
EXT_DIR=.dependencies
