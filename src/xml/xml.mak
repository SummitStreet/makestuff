
#** makestuff/src/xml/xml.mak

-include $(MAKESTUFF)/xml_vars.mak

BUILD_DEPENDENCIES=\
	github.com/account/repo.git

BUILD_TARGETS=\
	document.xml

document.xml : $(SRC_DIR)/resources/xml/document.xml

-include $(MAKESTUFF)/xml_rules.mak
