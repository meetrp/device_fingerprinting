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
TESTDIR		:=	test
TARGET		:=	bin/dfing

#
# Documentation related
DOXYGEN		:= 	$(shell command -v doxygen 2> /dev/null)
DOCHTML		:=	doc/html
DOCMAN		:=	doc/man
DOC_TARGET	:=	doc/dfing.doxyfile

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
	@echo "	Cleaning..."
	@echo "	[RM ]	$(BUILDDIR)/"
	@echo "	[RM ]	$(TARGET)"
	@echo "	[RM ]	docs"
	@$(RM) -r $(BUILDDIR) $(TARGET) $(DOCHTML) $(DOCMAN)

docs:
	@echo "	Generating docs..."
ifndef DOXYGEN
	@echo "	** [ERR] doxygen is not available; please install to make docs**"
else
	@echo "	[DOX]	$(DOCHTML)"
	@echo "	[DOX]	$(DOCMAN)"
	@doxygen $(DOC_TARGET)
endif