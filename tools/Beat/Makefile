#
# Copyright (c) 2007 Microsoft Corporation.   All rights reserved.
#

ROOT = ../..

include $(ROOT)/build.mk

SRC = .
OBJ = $(OBJROOT)/tools/Beat
BIN = $(BINROOT)

BEAT_SOURCES = \
	$(SRC)/compat.fs \
	$(SRC)/ast.fs \
	$(SRC)/parse_util.fs \
	$(OBJ)/parse.fs \
	$(OBJ)/lex.fs \
	$(SRC)/arg.fs \
	$(SRC)/main.fs

INCLUDES = -I $(PPACK_CORE)/Lib/Net40
LIBS     = -r FSharp.PowerPack.dll

all: beat

beat: $(BIN)/beat.exe

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

$(BIN)/beat.exe: $(BEAT_SOURCES) $(BIN) $(PPACK)
	@echo "  FSC     beat.exe"
	$(FSC) --nologo --standalone --mlcompatibility -O $(BEAT_SOURCES) -o $(BIN)/beat.exe $(INCLUDES) $(LIBS)
	touch $(OBJ)

.PHONY: all
