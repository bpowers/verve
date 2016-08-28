#
# Copyright (c) 2007 Microsoft Corporation.   All rights reserved.
#

ROOT = ../..

include $(ROOT)/build.mk

SRC = .
OBJ = $(OBJROOT)/tools/BoogieAsm
BIN = $(BINROOT)

BOOGIE_SOURCES = \
	$(SRC)/compat.fs \
	$(SRC)/ast.fs \
	$(SRC)/parse_util.fs \
	$(OBJ)/parse.fs \
	$(OBJ)/lex.fs \
	$(SRC)/arg.fs \
	$(SRC)/main.fs

INCLUDES = -I $(PPACK_CORE)/Lib/Net40
LIBS     = -r FSharp.PowerPack.dll

all: boogieasm symdiffmerge

boogieasm: $(BIN)/boogieasm.exe

symdiffmerge: $(BIN)/symdiffmerge.exe

$(PPACK):
	@echo "  NUGET   FSPowerPack"
	nuget install -OutputDirectory $(LIBROOT) FSPowerPack.Community

$(FSLEX) $(FSYACC): $(PPACK)

$(OBJ):
	$(MKDIR) $(OBJ)

$(BIN):
	$(MKDIR) $(BIN)

$(OBJ)/lex.fs: $(SRC)/lex.fsl $(OBJ) $(FSLEX_BIN)
	@echo "  FSLEX   lex.fsl"
	$(FSLEX) --unicode $(SRC)/lex.fsl -o $(OBJ)/lex.fs >/dev/null
	touch $(OBJ)

$(OBJ)/parse.fsi $(OBJ)/parse.fs: $(SRC)/parse.fsy $(OBJ) $(FSYACC_BIN)
	@echo "  FSYACC  parse.fsy"
	$(FSYACC) --module Parse -v $(SRC)/parse.fsy -o $(OBJ)/parse.fs >/dev/null
	touch $(OBJ)

$(BIN)/boogieasm.exe: $(BOOGIE_SOURCES) $(PPACK)
	@echo "  FSC     boogieasm.exe"
	$(FSC) --nologo --standalone --mlcompatibility -O $(BOOGIE_SOURCES) -o $(BIN)/boogieasm.exe $(INCLUDES) $(LIBS)
	touch $(OBJ)

$(BIN)/symdiffmerge.exe: SymdiffMerge.cs
	@echo "  CSC     symdiffmerge.exe"
	$(CSC) /debug+ /out:$(BIN)/symdiffmerge.exe SymdiffMerge.cs
	touch $(OBJ)

clean:
	$(RM) $(BIN)/boogieasm.exe
	$(RM) $(BIN)/symdiffmerge.exe
	$(RM) $(OBJ)/*.fs
	$(RM) $(OBJ)/*.fsi
