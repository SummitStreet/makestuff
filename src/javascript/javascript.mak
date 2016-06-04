
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
