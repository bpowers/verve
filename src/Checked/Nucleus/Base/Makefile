ROOT = ../../../..

include $(ROOT)/build.mk

OBJ    = $(OBJROOT)/Checked/Nucleus/Base

SPECS  = $(SPEC)/Base_i.bpl $(SPEC)/Memory_i.bpl $(SPEC)/Stacks_i.bpl $(SPEC)/Assembly_i.bpl $(SPEC)/Bartok_i.bpl $(SPEC)/Interrupts_i.bpl $(SPEC)/Io_i.bpl
AXIOMS = $(SPEC)/Base_axioms.bpl $(SPEC)/Memory_axioms.bpl $(SPEC)/Stacks_axioms.bpl $(SPEC)/Assembly_axioms.bpl $(SPEC)/Bartok_axioms.bpl

all: build

$(OBJ):
	$(MKDIR) $(OBJ)

build: $(OBJ)
	cp Util_i.bpl $(OBJ)/Util_i.bpl
	$(BEAT) >$(OBJ)/Util.bpl <Util.beat

	cp $(SPEC)/Overflow_i.bpl $(OBJ)/Overflow_i.bpl
	$(BEAT) >$(OBJ)/Overflow.bpl <Overflow.beat

	$(BEAT) >$(OBJ)/Separation_i.bpl <Separation_i.beat
	$(BEAT) >$(OBJ)/Separation.bpl   <Separation.beat -i Separation_i.beat

#	TODO: check results dumped into .v files for errors
	$(BOOGIE) >$(OBJ)/Util_i.v $(SPECS) $(AXIOMS) $(OBJ)/Util_i.bpl
	$(BOOGIE) >$(OBJ)/Util.v   $(SPECS) $(AXIOMS) $(OBJ)/Util_i.bpl $(SPEC)/Word_axioms.bpl $(OBJ)/Util.bpl
	$(BOOGIE) >$(OBJ)/Overflow_i.v $(SPECS) $(AXIOMS) $(OBJ)/Util_i.bpl $(OBJ)/Overflow_i.bpl
	$(BOOGIE) >$(OBJ)/Overflow.v   $(SPECS) $(AXIOMS) $(OBJ)/Util_i.bpl $(OBJ)/Overflow_i.bpl $(SPEC)/Word_axioms.bpl $(OBJ)/Overflow.bpl
	$(BOOGIE) >$(OBJ)/Separation_i.v $(SPECS) $(AXIOMS) $(OBJ)/Util_i.bpl $(OBJ)/Separation_i.bpl
	$(BOOGIE) >$(OBJ)/Separation.v   $(SPECS) $(AXIOMS) $(OBJ)/Util_i.bpl $(OBJ)/Separation_i.bpl $(SPEC)/Word_axioms.bpl $(OBJ)/Separation.bpl

clean:
	$(RM) $(OBJ)/*.bpl $(OBJ)/*.v

.PHONY: all build clean
