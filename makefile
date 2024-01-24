########### UDIT'S MAKEFILE ###########

## VERSION: 1.0

#######################################

### USEFUL LINKS ###

# https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html#Implicit-Variables
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

###

SRCDIR 	 	 		:= src
BUILDDIR 	 		:= build
BINDIR 	  	 		:= bin
LIBDIR		 		:= lib

CXX 	 	 		:= g++
LD		 	 		:= g++
TARGET 	 	 		:= game
CXXFLAGS  	 		:= -g -Wall
CPPFLAGS 	 		:= -I$(LIBDIR)/
LDFLAGS 	 		:= 

SRCS 	 	 		:= $(wildcard $(SRCDIR)/*.cpp)
OBJS 	 	 		:= $(SRCS:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)
INCLUDE_DIRS 		:= 
LIBRARY_DIRS 		:=
LIBRARIES 	 		:= SDL2

PACKAGES 	 		:= pkg1
PACKAGE_SRCS 		:= $(foreach package,$(PACKAGES), $(shell ls $(SRCDIR)/$(package)/*.cpp))
PACKAGE_OBJS 		:= $(PACKAGE_SRCS:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)
PACKAGE_BUILDDIRS 	:= $(foreach package,$(PACKAGES), $(BUILDDIR)/$(package))
PACKAGE_FOBJS 		:= $(foreach package,$(PACKAGE_BUILDDIRS), $(package).o)
PACKAGE_FL			:= .package

CPPFLAGS 	 		+= $(foreach includedir,$(INCLUDE_DIRS),-I$(includedir))
LDLIBS 		 		+= $(foreach library,$(LIBRARIES),-l$(library))

MAKE_MSG 			:= [ MAKE ]

.PHONY: one all clean genlsp build_packages build_tests run_tests clean_packages

all: $(BINDIR)/$(TARGET)

# Linker
## LINK.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
# $(LINK.cc) $^ -o $@ $(LDLIBS)
$(BINDIR)/$(TARGET): $(PACKAGE_FOBJS) $(OBJS)
	$(LD) $(CXXFLAGS) $^ -o $@ $(LDLIBS)
	
$(OBJS): $(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $< -c -o $@ $(LDLIBS)

# Creates .o file for each cpp file in each package
$(PACKAGE_OBJS): $(BUILDDIR)/%.o: $(SRCDIR)/%.cpp | $(PACKAGE_BUILDDIRS)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $< -c -o $@ $(LDLIBS)

# Creates .o files for each package
# $(PACKAGE_FOBJS): $(PACKAGE_OBJS) | clean_packages
# 	$(LD) $(LDFLAGS) $^ -o $@

# $(PACKAGE_BUILDDIRS): $(BUILDDIR)/%/$(PACKAGE_FL): | $(BUILDDIR)
$(PACKAGE_BUILDDIRS): $(BUILDDIR)/%: | $(BUILDDIR)
	@mkdir -p $@
	@touch $@/$(PACKAGE_FL)
	@echo $(MAKE_MSG) Found Pakcages! Creating Pakcage directories.

# $(PACKAGE_BUILDDIRS): $(BUILDDIR)/%/$(PACKAGE_FL): | $(BUILDDIR)
# Add this generic rule to handle the dependency on individual .o files
$(PACKAGE_FOBJS): $(BUILDDIR)/%.o: $(BUILDDIR)/% | $(PACKAGE_OBJS)
	$(LD) -r $(CXXFLAGS) $</*.o -o $@

# $(PACKAGE_BUILDDIRS): $(BUILDDIR)/%: $(BUILDDIR)/%/*.o | $(BUILDDIR)/%/$(PACKAGE_FL)
# 	$(LD) -r $(LDFLAGS) $(CXXFLAGS) $< -o $@.o $(LDLIBS)

clean_packages:
	@rm -rf $(PACKAGE_BUILDDIRS)

build_tests:
	@echo In progress!!

run_tests:
	@echo In progress!!

clean:
	@- $(RM) -r $(BINDIR)/*
	@- $(RM) -r $(BUILDDIR)/*

genlsp: clean compile_commands.json
	bear -- $(MAKE)

echo:
	@echo $(PACKAGE_BUILDDIRS)


