ROOT = ../../../..

include $(ROOT)/build.mk

OBJ    = $(OBJROOT)/Checked/Nucleus/Main
BOBJ   = $(OBJROOT)/Checked/Nucleus/Base
GCOBJ  = $(OBJROOT)/Checked/Nucleus/GC
SOBJ   = $(OBJROOT)/Trusted/Spec

SPECS  = $(SPEC)/Base_i.bpl $(SPEC)/Memory_i.bpl $(SPEC)/Stacks_i.bpl $(SPEC)/Assembly_i.bpl $(SPEC)/Bartok_i.bpl $(SPEC)/Interrupts_i.bpl $(SPEC)/Io_i.bpl
AXIOMS = $(SPEC)/Base_axioms.bpl $(SPEC)/Memory_axioms.bpl $(SPEC)/Stacks_axioms.bpl $(SPEC)/Assembly_axioms.bpl $(SPEC)/Bartok_axioms.bpl $(SPEC)/Io_axioms.bpl

BASES  = $(BOBJ)/Overflow_i.bpl $(BOBJ)/Util_i.bpl $(BOBJ)/Separation_i.bpl

all: build

$(OBJ):
	$(MKDIR) $(OBJ)

build build-cp build-ms: $(OBJ)
	cp $(SOBJ)/EntryMS_i.bpl $(OBJ)/EntryMS_i.bpl
	cp $(SOBJ)/EntryCP_i.bpl $(OBJ)/EntryCP_i.bpl

	$(BEAT) >$(OBJ)/EntryMS.bpl <Entry.beat -i ../Base/Separation_i.beat -i ../GC/MarkSweepCollector_i.beat
	$(BEAT) >$(OBJ)/EntryCP.bpl <Entry.beat -i ../Base/Separation_i.beat -i ../GC/CopyingCollector_i.beat

	$(BOOGIE) >$(OBJ)/EntryMS_i.v $(SPECS) $(AXIOMS) $(BASES) ../GC/BitVectors_i.bpl $(GCOBJ)/Reach_i.bpl $(GCOBJ)/Common_i.bpl $(GCOBJ)/MarkSweepCollector_i.bpl $(OBJ)/EntryMS_i.bpl
	$(BOOGIE) >$(OBJ)/EntryMS.v   $(SPECS) $(AXIOMS) $(BASES) ../GC/BitVectors_i.bpl $(GCOBJ)/Reach_i.bpl $(GCOBJ)/Common_i.bpl $(GCOBJ)/MarkSweepCollector_i.bpl $(OBJ)/EntryMS_i.bpl $(SPEC)/Word_axioms.bpl $(OBJ)/EntryMS.bpl

	$(BOOGIE) >$(OBJ)/EntryCP_i.v $(SPECS) $(AXIOMS) $(BASES) ../GC/BitVectors_i.bpl $(GCOBJ)/Reach_i.bpl $(GCOBJ)/Common_i.bpl $(GCOBJ)/CopyingCollector_i.bpl   $(OBJ)/EntryCP_i.bpl
	$(BOOGIE) >$(OBJ)/EntryCP.v   $(SPECS) $(AXIOMS) $(BASES) ../GC/BitVectors_i.bpl $(GCOBJ)/Reach_i.bpl $(GCOBJ)/Common_i.bpl $(GCOBJ)/CopyingCollector_i.bpl   $(OBJ)/EntryCP_i.bpl $(SPEC)/Word_axioms.bpl $(OBJ)/EntryCP.bpl

clean:
	$(RM) $(OBJ)/*.bpl $(OBJ)/*.v

.PHONY: all build clean
