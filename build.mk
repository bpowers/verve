# quiet output, but allow us to look at what commands are being
# executed by passing 'V=1' to make, without requiring temporarily
# editing the Makefile.
ifneq ($V, 1)
MAKEFLAGS += -s
endif

# GNU make, you are the worst.  Remove a bunch of the built in rules
# for version control systems that haven't been used this millenium.
.SUFFIXES:
%: %,v
%: RCS/%,v
%: RCS/%
%: s.%
%: SCCS/s.%


BUILD         = $(ROOT)/../base/build
OBJROOT       = $(ROOT)/obj
LIBROOT       = $(ROOT)/lib
BINROOT       = $(ROOT)/bin
SPEC          = $(ROOT)/src/Trusted/Spec

PPACK         = $(LIBROOT)/FSPowerPack.Community.3.0.0.0
PPACK_CORE    = $(LIBROOT)/FSPowerPack.Core.Community.3.0.0.0

FSLEX_BIN     = $(PPACK)/Tools/fslex.exe
FSYACC_BIN    = $(PPACK)/Tools/fsyacc.exe

FSLEX         = mono $(FSLEX_BIN)
FSYACC        = mono $(FSYACC_BIN)

BEAT_EXE      = $(BINROOT)/beat.exe
BOOGIEASM_EXE = $(BINROOT)/boogieasm.exe
BEAT          = mono $(BEAT_EXE)
BOOGIEASM     = mono $(BOOGIEASM_EXE)
BOOGIE        = boogie
MKDIR         = mkdir -p
RM            = rm -f
FSC           = fsharpc
CSC           = csharp
