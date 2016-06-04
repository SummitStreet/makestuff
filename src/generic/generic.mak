
#** makestuff/src/generic/generic.mak

-include $(MAKESTUFF)/generic_vars.mak

BUILD_DEPENDENCIES=\
	github.com/account/repo@version.git

BUILD_TARGETS=\
	component.ext

-include $(MAKESTUFF)/generic_rules.mak
