ROOT = ../../../..

include $(ROOT)/build.mk

OBJ    = $(OBJROOT)/Checked/Nucleus/GC
BOBJ   = $(OBJROOT)/Checked/Nucleus/Base
SOBJ   = $(OBJROOT)/Trusted/Spec

SPECS  = $(SPEC)/Base_i.bpl $(SPEC)/Memory_i.bpl $(SPEC)/Stacks_i.bpl $(SPEC)/Assembly_i.bpl $(SPEC)/Bartok_i.bpl $(SPEC)/Interrupts_i.bpl $(SPEC)/Io_i.bpl
AXIOMS = $(SPEC)/Base_axioms.bpl $(SPEC)/Memory_axioms.bpl $(SPEC)/Stacks_axioms.bpl $(SPEC)/Assembly_axioms.bpl $(SPEC)/Bartok_axioms.bpl

BASES  = $(BOBJ)/Overflow_i.bpl $(BOBJ)/Util_i.bpl $(BOBJ)/Separation_i.bpl

all: build

$(OBJ):
	$(MKDIR) $(OBJ)

build: $(OBJ)
	$(BEAT) >$(OBJ)/Reach_i.bpl  <Reach_i.beat
	$(BEAT) >$(OBJ)/Reach.bpl    <Reach.beat
	$(BEAT) >$(OBJ)/Common_i.bpl <Common_i.beat -i ../Base/Separation_i.beat
	$(BEAT) >$(OBJ)/Common.bpl   <Common.beat   -i ../Base/Separation_i.beat

	$(BEAT) >$(OBJ)/MarkSweepCollector__i.bpl <MarkSweepCollector_i.beat -i ../Base/Separation_i.beat -i $(SOBJ)/CollectorMS_i.bpl
	cat $(SOBJ)/CollectorMS_i.bpl $(OBJ)/MarkSweepCollector__i.bpl >$(OBJ)/MarkSweepCollector_i.bpl
	$(BEAT) >$(OBJ)/MarkSweepCollector.bpl    <MarkSweepCollector.beat   -i ../Base/Separation_i.beat -i $(SOBJ)/CollectorMS_i.bpl -i MarkSweepCollector_i.beat

	$(BEAT) >$(OBJ)/CopyingCollector__i.bpl   <CopyingCollector_i.beat  -i ../Base/Separation_i.beat -i $(SOBJ)/CollectorCP_i.bpl
	cat $(SOBJ)/CollectorCP_i.bpl $(OBJ)/CopyingCollector__i.bpl >$(OBJ)/CopyingCollector_i.bpl
	$(BEAT) >$(OBJ)/CopyingCollector.bpl      <CopyingCollector.beat    -i ../Base/Separation_i.beat -i $(SOBJ)/CollectorCP_i.bpl -i CopyingCollector_i.beat

	$(BOOGIE) >$(OBJ)/BitVectorsBuiltin_i.v  /bv:z $(SPEC)/base_i.bpl $(SPEC)/memory_i.bpl $(SPEC)/assembly_axioms.bpl $(SPEC)/BitVectorsBuiltin_i.bpl BitVectorsBuiltin_i.bpl
	$(BOOGIE) >$(OBJ)/BitVectorsBuiltin.v    /bv:z $(SPEC)/base_i.bpl $(SPEC)/memory_i.bpl $(SPEC)/assembly_axioms.bpl $(SPEC)/BitVectorsBuiltin_i.bpl BitVectorsBuiltin_i.bpl $(SPEC)/BitVectors_axioms.bpl BitVectorsBuiltin.bpl
	$(BOOGIE) >$(OBJ)/BitVectors_i.v               $(SPEC)/assembly_axioms.bpl $(SPEC)/base_i.bpl $(SPEC)/memory_i.bpl $(SPEC)/BitVectors_i.bpl BitVectors_i.bpl
	$(BOOGIE) >$(OBJ)/BitVectors.v           /bv:z $(SPEC)/assembly_axioms.bpl $(SPEC)/base_i.bpl $(SPEC)/memory_i.bpl $(SPEC)/BitVectors_i.bpl BitVectors_i.bpl BitVectorsBuiltin_i.bpl $(SPEC)/BitVectors_axioms.bpl BitVectors.bpl
	$(BOOGIE) >$(OBJ)/Reach_i.v                    $(SPECS) $(AXIOMS) $(BASES) $(OBJ)/Reach_i.bpl
	$(BOOGIE) >$(OBJ)/Reach.v                      $(SPECS) $(AXIOMS) $(BASES) $(OBJ)/Reach_i.bpl $(OBJ)/Reach.bpl
	$(BOOGIE) >$(OBJ)/Common_i.v                   $(SPECS) $(AXIOMS) $(BASES) BitVectors_i.bpl $(OBJ)/Reach_i.bpl $(OBJ)/Common_i.bpl
	$(BOOGIE) >$(OBJ)/Common.v                     $(SPECS) $(AXIOMS) $(BASES) BitVectors_i.bpl $(OBJ)/Reach_i.bpl $(OBJ)/Common_i.bpl $(OBJ)/Common.bpl
	$(BOOGIE) >$(OBJ)/MarkSweepCollector_i.v       $(SPECS) $(AXIOMS) $(BASES) BitVectors_i.bpl $(OBJ)/Reach_i.bpl $(OBJ)/Common_i.bpl $(OBJ)/MarkSweepCollector_i.bpl
	$(BOOGIE) >$(OBJ)/MarkSweepCollector.v         $(SPECS) $(AXIOMS) $(BASES) BitVectors_i.bpl $(OBJ)/Reach_i.bpl $(OBJ)/Common_i.bpl $(OBJ)/MarkSweepCollector_i.bpl $(OBJ)/MarkSweepCollector.bpl
	$(BOOGIE) >$(OBJ)/CopyingCollector_i.v         $(SPECS) $(AXIOMS) $(BASES) BitVectors_i.bpl $(OBJ)/Reach_i.bpl $(OBJ)/Common_i.bpl $(OBJ)/CopyingCollector_i.bpl
	$(BOOGIE) >$(OBJ)/CopyingCollector.v           $(SPECS) $(AXIOMS) $(BASES) BitVectors_i.bpl $(OBJ)/Reach_i.bpl $(OBJ)/Common_i.bpl $(OBJ)/CopyingCollector_i.bpl $(OBJ)/CopyingCollector.bpl

clean:
	$(RM) $(OBJ)/*.bpl $(OBJ)/*.v

.PHONY: all build clean
