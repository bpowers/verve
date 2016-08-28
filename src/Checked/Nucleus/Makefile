ROOT = ../../..

include $(ROOT)/build.mk

OBJ = $(OBJROOT)/Checked/Nucleus

SPECS         = Memory Assembly Stacks Interrupts Io Bartok BitVectors
SPEC_S_OBJS   = $(addprefix $(SPEC)/, $(SPECS))
#SPEC_S_OBJS   = $(addprefix $(SPEC)/, $(addsuffix .bpl, $(SPECS)))
SPEC_I_OBJS   = $(addprefix $(SPEC)/, $(addsuffix _i.bpl, $(SPECS)))
#SPEC_OBJS     = $(SPEC)/Base_i.bpl $(SPEC_S_OBJS) $(SPEC_I_OBJS)
SPEC_OBJS     = $(SPEC_S_OBJS)

SOURCES       = Base/Util Base/Overflow Base/Separation \
                GC/Reach GC/Common GC/MarkSweepCollector
SOURCE_S_OBJS = $(addprefix $(OBJ)/, $(SOURCES))
#SOURCE_S_OBJS = $(addprefix $(OBJ)/, $(addsuffix .bpl, $(SOURCES)))
#SOURCE_I_OBJS = $(addprefix $(OBJ)/, $(addsuffix _i.bpl, $(SOURCES)))
SOURCE_OBJS   = $(SOURCE_S_OBJS) GC/BitVectorsBuiltin GC/BitVectors

OBJS = \
	$(SPEC)/Base $(SPEC)/Memory $(SPEC)/Assembly $(SPEC)/Stacks \
	$(SPEC)/Interrupts $(SPEC)/Io $(SPEC)/Bartok $(SPEC)/BitVectors \
	$(OBJ)/Base/Util $(OBJ)/Base/Overflow $(OBJ)/Base/Separation \
	GC/BitVectorsBuiltin GC/BitVectors \
	$(OBJ)/GC/Reach $(OBJ)/GC/Common $(OBJ)/GC/MarkSweepCollector

#OBJS          = $(SPEC_OBJS) $(SOURCE_OBJS)

all: $(OBJ)/nucleus_ms.asm $(OBJ)/nucleus_cp.asm

Base GC Main:
	make -C $@

$(OBJ)/nucleus_ms.asm: #Base GC Main
#	$(BOOGIEASM) >$(OBJ)/nucleus_ms.asm $(OBJS) $(OBJ)/Main/EntryMS.bpl
	$(BOOGIEASM) $(OBJS) $(OBJ)/Main/EntryMS

$(OBJ)/nucleus_cp.asm: #Base GC Main
#	$(BOOGIEASM) >$(OBJ)/nucleus_cp.asm $(OBJS) $(OBJ)/Main/EntryCP.bpl
	$(BOOGIEASM) $(OBJS) $(OBJ)/Main/EntryCP

.PHONY: all Base GC Main
