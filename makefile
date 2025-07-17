bin/b4.rom: README.md | setup
	@ unutal README.md | drifloon > bin/b4.rom

test: bin/b4.rom
	@ uxncli bin/b4.rom

setup:
	@ mkdir -p bin

clean:
	@ rm -rf bin

.PHONY: setup clean
