########### UDIT'S MAKEFILE ###########

## VERSION: 1.0

#######################################

### USEFUL LINKS ###

# https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html#Implicit-Variables
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

###

SRCDIR 	 	 := src
BUILDDIR 	 := build
BINDIR 	  	 := bin
LIBDIR		 := lib

CXX 	 	 := g++
LD		 	 := g++
TARGET 	 	 := game
CXXFLAGS  	 := -g -Wall
CPPFLAGS 	 := -I$(LIBDIR)/
LDFLAGS 	 := 

PACKAGES 	 := $(dir $(wildcard src/*/.))

SRCS 	 	 := $(wildcard $(SRCDIR)/*.cpp)
OBJS 	 	 := $(SRCS:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)
PACKAGE_OBJS := $(PACKAGES:/=.o)
INCLUDE_DIRS := 
LIBRARY_DIRS :=
LIBRARIES 	 := SDL2

CPPFLAGS 	 += $(foreach includedir,$(INCLUDE_DIRS),-I$(includedir))
LDLIBS 		 += $(foreach library,$(LIBRARIES),-l$(library))

.PHONY: one all clean

one:
	@echo $(OBJS)

all: $(BINDIR)/$(TARGET)

# Linker
## LINK.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
# $(LINK.cc) $^ -o $@ $(LDLIBS)
$(BINDIR)/$(TARGET): $(OBJS) build_packages
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDLIBS)
	
$(OBJS): $(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $< -c -o $@ $(LDLIBS)

build_packages:
	

build_tests:
	@echo In progress!!

run_tests:
	@echo In progress!!

clean:
	@- $(RM) $(BINDIR)/*
	@- $(RM) $(BUILDDIR)/*
