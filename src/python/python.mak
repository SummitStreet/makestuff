
# makestuff/src/python/python.mak

-include $(MAKESTUFF)/python_vars.mak

BUILD_DEPENDENCIES=\
	github.com/account/repo@version.git

BUILD_TARGETS=\
	component.py

TEST_TARGETS=\
	test.py

component.py : $(SOURCE_DIR)/main/python/component.py

test.py : $(SOURCE_DIR)/test/python/test.py

-include $(MAKESTUFF)/python_rules.mak
