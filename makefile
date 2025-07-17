bin/b4.rom: src/b4.md
	@ mkdir -p bin
	@ unutal src/b4.md | drifloon > bin/b4.rom

test: bin/b4.rom
	@ uxncli bin/b4.rom

clean:
	@ rm -rf bin

.PHONY: setup clean
