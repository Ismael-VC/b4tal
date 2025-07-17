bin/b4.rom: README.md | setup
	@ etc/unutal.py README.md | etc/uxncli etc/drifloon.rom > bin/b4.rom

test: bin/b4.rom
	@ etc/uxncli bin/b4.rom

setup:
	@ mkdir -p bin

clean:
	@ rm -rf bin

.PHONY: setup clean
