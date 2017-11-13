##
# Name        : Makefile
# Created on  : Nov 9, 2017
# Author      : Rp
# Copyright   : @www.meetrp.com
# Description : Finger print devices by sniffing on network packets
##

CXX			:= g++

SRCDIR		:=	src
BUILDDIR	:=	build
DOCDIR		:=	doc
TESTDIR		:=	test
TARGET		:=	bin/dfing
DOC_TARGET	:=	dfing.doxy

SRCEXT		:=	cpp
SOURCES		:=	$(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS		:=	$(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))

CXXFLAGS	:=	-O2 -g -Wall -fmessage-length=0
LIBS		:=
INC			:=	-I include


all:	$(TARGET)

$(TARGET):	$(OBJECTS)
	@echo "	[LD ]	$@"
	@$(CXX) -o $@ $^

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@echo "	[CC ]	$@"
	@$(CXX) -c -o $@ $(CXXFLAGS) $(INC) $<

clean:
	@echo "	Cleaning..."; 
	@$(RM) -r $(BUILDDIR) $(TARGET) $(DOCDIR)/* $(DOC_TARGET)

$(DOC_TARGET):
	@echo > $(DOC_TARGET)
	@echo "PROJECT_NAME           = \"DFing\"" >> $(DOC_TARGET)
	@echo "OUTPUT_DIRECTORY       = \"$(DOCDIR)\"" >> $(DOC_TARGET)
	@echo "PROJECT_BRIEF          = \"Finger print devices by sniffing on network packets\"" >> $(DOC_TARGET)
	@echo "EXTRACT_ALL            = YES" >> $(DOC_TARGET)
	@echo "INPUT                  = $(SRCDIR)" >> $(DOC_TARGET)
	@echo "EXCLUDE                = $(TESTDIR)" >> $(DOC_TARGET)

docs: $(DOC_TARGET) $(SRCS)
	@mkdir -p $(DOCDIR)
	@doxygen $(DOC_TARGET)
	