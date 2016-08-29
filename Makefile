ROOT = .

include build.mk

all: project

tools:
	make -C tools/Beat beat
	make -C tools/BoogieAsm boogieasm

nucleus: tools
	make -C src/Trusted/Spec build-cp
	make -C src/Checked/Nucleus build-cp

project:
	./build.sh

bin/safeos_cp.iso: project

run:
	qemu-system-x86_64 -boot d -cdrom bin/safeos_cp.iso -m 512

.PHONY: all project nucleus tools
