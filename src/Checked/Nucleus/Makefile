ROOT = ../../..

include $(ROOT)/build.mk

OBJ = $(OBJROOT)/Checked/Nucleus

SPECS         = base memory assembly stacks interrupts io bartok BitVectors
SPEC_S_OBJS   = $(addprefix $(SPEC)/, $(addsuffix .bpl, $(SPECS)))
SPEC_I_OBJS   = $(addprefix $(SPEC)/, $(addsuffix _i.bpl, $(SPECS)))
SPEC_OBJS     = $(SPEC_S_OBJS) $(SPEC_I_OBJS)

SOURCES       = Base/Util Base/Overflow Base/Separation \
                GC/BitVectorsBuiltin GC/BitVectors GC/Reach GC/Common GC/MarkSweepCollector
SOURCE_S_OBJS = $(addprefix $(OBJ)/, $(addsuffix .bpl, $(SOURCES)))
SOURCE_I_OBJS = $(addprefix $(OBJ)/, $(addsuffix _i.bpl, $(SOURCES)))
SOURCE_OBJS   = $(SPEC_S_OBJS) $(SPEC_I_OBJS)

OBJS          = $(SPEC_OBJS) $(SOURCE_OBJS)

all: $(OBJ)/nucleus_ms.asm $(OBJ)/nucleus_cp.asm

Base GC Main:
	make -C $@

$(OBJ)/nucleus_ms.asm: Base GC Main
	$(BOOGIEASM) -out $(OBJ)/nucleus_ms.asm $(OBJS) $(OBJ)/Main/EntryMS.bpl

$(OBJ)/nucleus_cp.asm: Base GC Main
	$(BOOGIEASM) -out $(OBJ)/nucleus_cp.asm $(OBJS) $(OBJ)/Main/EntryCP.bpl

.PHONY: all Base GC Main
