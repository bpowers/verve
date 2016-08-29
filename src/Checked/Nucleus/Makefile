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

all: build

build: build-ms

$(OBJ)/nucleus_ms.asm:
	make -C Base build-ms
	make -C GC build-ms
	make -C Main build-ms
	$(BOOGIEASM) >$(OBJ)/nucleus_ms.asm $(OBJS) $(OBJ)/Main/EntryMS

$(OBJ)/nucleus_cp.asm:
	make -C Base build-cp
	make -C GC build-cp
	make -C Main build-cp
	$(BOOGIEASM) >$(OBJ)/nucleus_cp.asm $(OBJS) $(OBJ)/Main/EntryCP

build-ms: $(OBJ)/nucleus_ms.asm

build-cp: $(OBJ)/nucleus_cp.asm

clean:
	make -C Base clean
	make -C GC clean
	make -C Main clean
	$(RM) $(OBJ)/nucleus_cp.asm $(OBJ)/nucleus_ms.asm

.PHONY: all clean Base GC Main
