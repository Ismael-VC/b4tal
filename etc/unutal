#!/usr/bin/env python3

import sys

def main():
    args = sys.argv[1:]

    if not args:
        print("Usage: unutal <file> [--release]")
        sys.exit(1)

    f = args[0]
    release = "--release" in args
    in_block = False
    first_block = True

    with open(f, "r") as source:
        for line in source:
            stripped = line.rstrip()
            
            if stripped.startswith("```uxntal"):
                if not first_block:
                    print()
                    
                in_block = True
                first_block = False
                
                if not release:
                    print()
                    
            elif stripped.startswith("```") and in_block:
                in_block = False
                
                if not release:
                    print()
                    
            elif in_block:
                print(stripped)
                
            elif not release:
                print()

if __name__ == "__main__":
    main()
