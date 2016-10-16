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

#** makestuff/src/java/java.mak

ifndef __JAVA_RULES

__JAVA_RULES=__java_rules
include $(MAKESTUFF)/global_rules.mak

.PHONY : $(JAVA_CLEAN) $(JAVA_ENVIRONMENT) $(JAVA_INIT) $(JAVA_TEST)

%.class :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Module "($^)"
	@mkdir -p $(JAVA_CLASSES_DIR)
	@$(JAVAC) -d $(JAVA_CLASSES_DIR) -classpath $(JAVA_CLASSPATH):$(JAVA_CLASSES_DIR):$(JAVA_SRC_DIR) $^

%.jar :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Module "($^)"
	@mkdir -p $(dir $@)
	@$(FINDBUGS) $(FINDBUGS_ARGS) $(JAVA_CLASSES_DIR)
	@echo '$(subst $(JAVA_CLASSES_DIR)/,-C $(JAVA_CLASSES_DIR) ,$(sort $^))' | xargs $(JAR) $(JAR_ARGS) -cvf $@ >/dev/null

%.java :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Build Module "($^)"
	@mkdir -p $(JAVA_TEMP_DIR)
	@$(JAVAC) -d $(JAVA_TEMP_DIR) -classpath $(JAVA_CLASSPATH):$(JAVA_CLASSES_DIR):$(JAVA_SRC_DIR) $^
	@rm -rf $(JAVA_TEMP_DIR)
	@mkdir -p $(dir $@)
	@cat $^ > $@
	@$(PYTHON) $(PYTHON_ARGS) $(MAKESTUFF_MERGE_PY) $^ > $@

$(JAVA_CLEAN) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] Cleaning $(SELF)
	@rm -rf $(JAVA_CLASSES_DIR)
	@rm -rf $(JAVA_TEMP_DIR)

$(JAVA_ENVIRONMENT) :
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAR="$(JAR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAR_ARGS="$(JAR_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVA="$(JAVA)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVA_ARGS="$(JAVA_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVAC="$(JAVAC)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVAC_ARGS="$(JAVAC_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] FINDBUGS="$(FINDBUGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] FINDBUGS_ARGS="$(FINDBUGS_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JUNIT="$(JUNIT)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JUNIT_ARGS="$(JUNIT_ARGS)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVA_CLASSPATH="$(JAVA_CLASSPATH)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVA_CLASSES_DIR="$(JAVA_CLASSES_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVA_SRC_DIR="$(JAVA_SRC_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVA_TEMP_DIR="$(JAVA_TEMP_DIR)"
	@echo $(NOW) [SYS] [$(SELF)] [$@] JAVA_TEST_COMPONENTS="$(JAVA_TEST_COMPONENTS)"

$(JAVA_INIT) :
	@echo $(NOW) [SYS] [$(SELF)] [$@]

# findbugs, junit

$(JAVA_TEST) : $(JAVA_TEST_COMPONENTS)
	@echo $(NOW) [SYS] [$(SELF)] [$@]

# $(MAVEN) :
# 	@echo $(NOW) [SYS] [$(SELF)] [$@] Installing into local maven repository
# 	@$(MAVEN) install:install-file -Dfile=$@ -DgroupId= -DartifactId= -Dversion= -Dpackaging= -DgeneratePom=true

endif
