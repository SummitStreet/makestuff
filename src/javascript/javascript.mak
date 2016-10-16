
#** makestuff/src/javascript/javascript.mak

-include $(MAKESTUFF)/javascript_vars.mak

BUILD_DEPENDENCIES=\
	github.com/account/repo.git

BUILD_TARGETS=\
	component.js

JAVASCRIPT_TEST_COMPONENTS=\
	test.js

component.js : $(SRC_DIR)/main/javascript/component.js

test.js : $(SRC_DIR)/test/javascript/test.js

-include $(MAKESTUFF)/javascript_rules.mak
