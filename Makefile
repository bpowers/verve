ROOT = .

include build.mk

all: project

tools:
	make -C tools/Beat beat
	make -C tools/BoogieAsm boogieasm

nucleus: tools
	make -C src/Trusted/Spec build-cp
	make -C src/Checked/Nucleus build-cp

project: nucleus
	./build.sh

.PHONY: all project nucleus tools
