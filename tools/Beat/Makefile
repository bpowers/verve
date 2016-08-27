#
# Copyright (c) 2007 Microsoft Corporation.   All rights reserved.
#

BUILD = $(HOME)/src/FsLexYacc/bin
FSC = fsharpc

PPACK = ./FSPowerPack.Community.3.0.0.0

FSLEX = mono $(PPACK)/Tools/fslex.exe
FSYACC = mono $(PPACK)/Tools/fsyacc.exe
SRC = .

DLL = $(PPACK)/Lib/Net40/FSharp.PowerPack.dll

OBJ = obj
BIN = bin

#MKDIR = md
MKDIR = mkdir

BEAT_SOURCES = \
	$(SRC)/compat.fs \
	$(SRC)/ast.fs \
	$(SRC)/parse_util.fs \
	$(OBJ)/parse.fs \
	$(OBJ)/lex.fs \
	$(SRC)/arg.fs \
	$(SRC)/main.fs \

INCLUDES = \
	-I ./FSPowerPack.Core.Community.3.0.0.0/Lib/Net40

LIBS = \
	-r FSharp.PowerPack.dll

beat: $(OBJ) $(BIN) $(BIN)/beat.exe

$(PPACK):
	nuget install FSPowerPack.Community

$(DLL) $(FSLEX) $(FSYACC): $(PPACK)

$(DLL):
	nuget install FSPowerPack.Community

$(OBJ):
	$(MKDIR) $(OBJ)

$(BIN):
	$(MKDIR) $(BIN)

$(OBJ)/lex.fsi $(OBJ)/lex.fs: $(SRC)/lex.fsl $(OBJ) $(FSLEX)
	$(FSLEX) --unicode $(SRC)/lex.fsl -o $(OBJ)/lex.fs

$(OBJ)/parse.fsi $(OBJ)/parse.fs: $(SRC)/parse.fsy $(OBJ) $(FSYACC)
	$(FSYACC) --module Parse -v $(SRC)/parse.fsy -o $(OBJ)/parse.fs

$(BIN)/beat.exe: $(BEAT_SOURCES) $(DLL)
	$(FSC) --standalone --mlcompatibility -O $(BEAT_SOURCES) -o $(BIN)/beat.exe $(INCLUDES) $(LIBS)
