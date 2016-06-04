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

#** makestuff/src/global/init_rule.mak

EXT_DIR=.dependencies
MAKESTUFF_REPO=github.com/SummitStreet/makestuff@master.git
MAKESTUFF=`python -c 'import os, re, sys ; R, V = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups() ; print os.sep.join([sys.argv[1], R, V[1:]])' $(EXT_DIR) $(MAKESTUFF_REPO)`
GIT_CLONE="git clone --branch {ver} https://{repo}.git {dir} >/dev/null 2>/dev/null"

all :

### Initialize/bootstrap makestuff environment
### usage: make [-f <makefile>] init [EXT_DIR=<external_dependency_root_directory>]

init :
	@python -c 'import os, re, sys ; R, V = re.match(r"(.+?)(@.*)?.git", sys.argv[2]).groups() ; D = os.sep.join([sys.argv[1], R, V[1:]]) ; None if os.path.isdir(D) else os.system(sys.argv[3].format(repo=R, ver=V[1:], dir=D))' $(EXT_DIR) $(MAKESTUFF_REPO) $(GIT_CLONE)

.PHONY : init

#** makestuff/src/javascript/javascript.mak

-include $(MAKESTUFF)/javascript_vars.mak

BUILD_DEPENDENCIES=\
	github.com/account/repo.git

BUILD_TARGETS=\
	component.js

TEST_TARGETS=\
	test.js

component.js : $(SOURCE_DIR)/main/javascript/component.js

test.js : $(SOURCE_DIR)/test/javascript/test.js

-include $(MAKESTUFF)/javascript_rules.mak
