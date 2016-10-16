
#** makestuff/src/c/c.mak

-include $(MAKESTUFF)/c_vars.mak

vpath %.h $(SRC_DIR)/main/c
vpath %.c $(SRC_DIR)/main/c

BUILD_DEPENDENCIES=\
	github.com/account/repo.git

SOURCE_FILES=\
	main.c

BUILD_TARGETS=\
	executable

C_TEST_COMPONENTS=

OBJECT_FILES=$(SOURCE_FILES:.c=.o)

-include $(MAKESTUFF)/c_rules.mak
