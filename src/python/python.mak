
#** makestuff/src/python/python.mak

-include $(MAKESTUFF)/python_vars.mak

BUILD_DEPENDENCIES=\
	github.com/account/repo@version.git

BUILD_TARGETS=\
	component.py

PYTHON_TEST_COMPONENTS=\
	test.py

component.py : $(SRC_DIR)/main/python/component.py

test.py : $(SRC_DIR)/test/python/test.py

-include $(MAKESTUFF)/python_rules.mak
