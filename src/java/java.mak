
#** makestuff/src/java/java.mak

-include $(MAKESTUFF)/java_vars.mak

BUILD_DEPENDENCIES=\
	github.com/account/repo.git

BUILD_TARGETS=\
	component.java

JAVA_CLASSPATH=\
	dependency.jar

JAVA_TEST_COMPONENTS=\
	test.js

component.js : $(SRC_DIR)/main/java/component.js

test.js : $(SRC_DIR)/test/java/test.js

-include $(MAKESTUFF)/java_rules.mak
