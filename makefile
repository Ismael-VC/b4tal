bin/b4.rom: src/b4.md | setup
	@ unutal src/b4.md | drifloon > bin/b4.rom

test: bin/b4.rom
	@ uxncli bin/b4.rom

setup:
	@ mkdir -p bin

clean:
	@ rm -rf bin

.PHONY: setup clean
