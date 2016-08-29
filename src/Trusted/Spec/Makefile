ROOT = ../../..

include $(ROOT)/build.mk

OBJ    = $(OBJROOT)/Trusted/Spec

all: build

$(OBJ):
	$(MKDIR) $(OBJ)

build-cp: $(OBJ)
	./preprocess.sh -cp NucleusInvCopying_i.bpl Gc_i.bpl >$(OBJ)/CollectorCP_i.bpl
	./preprocess.sh -cp Entry_i.bpl >$(OBJ)/EntryCP_i.bpl

build-ms: $(OBJ)
	./preprocess.sh -ms NucleusInvMarkSweep_i.bpl Gc_i.bpl >$(OBJ)/CollectorMS_i.bpl
	./preprocess.sh -ms Entry_i.bpl >$(OBJ)/EntryMS_i.bpl

build: build-cp

clean:
	$(RM) $(OBJ)/*.bpl $(OBJ)/*.v

.PHONY: all build build-cp build-ms clean
