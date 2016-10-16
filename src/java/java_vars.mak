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

#** makestuff/src/java/java_vars.mak

ifndef __JAVA_VARS

__JAVA_VARS=__java_vars
include $(MAKESTUFF)/global_vars.mak

# Additional targets.

JAVA_CLEAN=java_clean
JAVA_ENVIRONMENT=java_environment
JAVA_INIT=java_init
JAVA_TEST=java_test

# Global variables.

CLEAN_TARGETS+=$(JAVA_CLEAN)
ENVIRONMENT_TARGETS+=$(JAVA_ENVIRONMENT)
INIT_TARGETS+=$(JAVA_INIT)
TEST_TARGETS+=$(JAVA_TEST)

MAKESTUFF_MERGE_PY=$(MAKESTUFF)/makestuff_merge.py
FINDBUGS=
FINDBUGS_ARGS=-textui
JAR=jar
JAR_ARGS=
JAVA=java
JAVA_ARGS=
JAVA_CLASSPATH=
JAVA_CLASSES_DIR=$(DIST_DIR)/classes
JAVA_SRC_DIR=$(SRC_DIR)/java/main
JAVA_TEST_COMPONENTS=
JAVAC=javac
JAVAC_ARGS=-Xlint:unchecked
JUNIT=
JUNIT_ARGS=
JAVA_TEMP_DIR=java_temp
endif
