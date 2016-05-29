
# makestuff/src/c/c.mak

-include $(MAKESTUFF)/c_vars.mak

vpath %.h $(SOURCE_DIR)/main/c
vpath %.c $(SOURCE_DIR)/main/c

BUILD_DEPENDENCIES=\
	github.com/account/repo.git

BUILD_TARGETS=\
	executable

TEST_TARGETS=

SOURCE_FILES=\
	main.c

OBJECT_FILES=$(SOURCE_FILES:.c=.o)

component.o : $(SOURCE_DIR)/main/c/component.c

test.c : $(SOURCE_DIR)/test/c/test.c

-include $(MAKESTUFF)/c_rules.mak
