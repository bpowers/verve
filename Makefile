ROOT = .

include build.mk

all: project

tools:
	make -C tools/Beat beat

nucleus: tools
	make -C src/Checked/Nucleus

project: nucleus

.PHONY: all project nucleus tools
