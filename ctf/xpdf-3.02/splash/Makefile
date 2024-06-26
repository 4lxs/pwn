#========================================================================
#
# Splash library Makefile
#
# Copyright 2003 Glyph & Cog, LLC
#
#========================================================================

SHELL = /bin/sh

srcdir = .


GOOSRCDIR = $(srcdir)/../goo
GOOLIBDIR = ../goo
FOFISRCDIR = $(srcdir)/../fofi
FOFILIBDIR = ../fofi

CXXFLAGS = -g -O2 -DHAVE_CONFIG_H -I.. -I$(GOOSRCDIR) -I$(FOFISRCDIR) -I$(srcdir)  

CXX = /root/AFLplusplus/afl-clang-fast++
AR = ar rc
RANLIB = ranlib

LIBPREFIX = lib

#------------------------------------------------------------------------

.SUFFIXES: .cc

.cc.o:
	$(CXX) $(CXXFLAGS) -c $<

#------------------------------------------------------------------------

CXX_SRC = \
	$(srcdir)/Splash.cc \
	$(srcdir)/SplashBitmap.cc \
	$(srcdir)/SplashClip.cc \
	$(srcdir)/SplashFTFont.cc \
	$(srcdir)/SplashFTFontEngine.cc \
	$(srcdir)/SplashFTFontFile.cc \
	$(srcdir)/SplashFont.cc \
	$(srcdir)/SplashFontEngine.cc \
	$(srcdir)/SplashFontFile.cc \
	$(srcdir)/SplashFontFileID.cc \
	$(srcdir)/SplashPath.cc \
	$(srcdir)/SplashPattern.cc \
	$(srcdir)/SplashScreen.cc \
	$(srcdir)/SplashState.cc \
	$(srcdir)/SplashT1Font.cc \
	$(srcdir)/SplashT1FontEngine.cc \
	$(srcdir)/SplashT1FontFile.cc \
	$(srcdir)/SplashXPath.cc \
	$(srcdir)/SplashXPathScanner.cc

#------------------------------------------------------------------------

all: $(LIBPREFIX)splash.a

#------------------------------------------------------------------------

SPLASH_OBJS = \
	Splash.o \
	SplashBitmap.o \
	SplashClip.o \
	SplashFTFont.o \
	SplashFTFontEngine.o \
	SplashFTFontFile.o \
	SplashFont.o \
	SplashFontEngine.o \
	SplashFontFile.o \
	SplashFontFileID.o \
	SplashPath.o \
	SplashPattern.o \
	SplashScreen.o \
	SplashState.o \
	SplashT1Font.o \
	SplashT1FontEngine.o \
	SplashT1FontFile.o \
	SplashXPath.o \
	SplashXPathScanner.o

$(LIBPREFIX)splash.a: $(SPLASH_OBJS)
	rm -f $(LIBPREFIX)splash.a
	$(AR) $(LIBPREFIX)splash.a $(SPLASH_OBJS)
	$(RANLIB) $(LIBPREFIX)splash.a

#------------------------------------------------------------------------

clean:
	rm -f $(SPLASH_OBJS) $(LIBPREFIX)splash.a

#------------------------------------------------------------------------

depend:
	$(CXX) $(CXXFLAGS) -MM $(CXX_SRC) >Makefile.dep

include Makefile.dep
