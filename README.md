# b4 VM in Uxntal

## Project Structure

### Directories

* `bin`: output folder.
* `etc`:
  - `drifloon.rom`: Uxntal assembler.
  - `unutal.py`: Unutal preprocessor.
  - `uxncli`: Uxn console emulator for Linux (x86_64) added for convenience, 
              replace as needed if using a different architecture.

### Files

* `makefile` targets:
  - `make`: Build `bin/b4.rom`.
  - `test`: Test `bin/b4.rom`.
  - `clean`: Delete `bin`.
* `README.md`: Source and documentation in Unutal (Markdown with Uxntal). 

```bash
$ tree
.
├── bin
│   └── b4.rom
├── etc
│   ├── drifloon.rom
│   ├── unutal.py
│   └── uxncli
├── LICENSE
├── makefile
└── README.md
```

## Macros

```uxntal
%\0 { 00 }
%\n { 0a }
%\s { 20 }
```

## Varvara Devices

* System

```uxntal
|00 @System/vector $2 &expansion $2 &wst $1 &rst $1 &metadata $2 &r $2 &g $2 
	&b $2 &debug $1 &state $1
	
|10 @Console/vector $2 &read $5 &type $1 &write $1 &error $1
```

## Zero Page

* ip: short = Instution pointer.
* vw: byte  = Value with in bytes.
* mz: short = RAM size.

```uxntal
|0000
@ip $2
@vw $1
@mz $2
```

## Entry Point

* setup: Initialize Zero Page variables.
* test:  Test implementation.

```uxntal
|100 @on-reset ( -> )
	( setup )
	#0100 .ip STZ2
	#02   .vw STZ
	#0400 .mz STZ2

	( test )
	.OpV/EX .OpV/VB .OpV/DB #010e DEO
	BRK
```

## Routines

* pop: POP2 with stack underflow check.
* tos: 

```uxntal
@todo ( str* -- ) 
	;/todo pstr 
	( str* ) pstr
	JMP2r
	
	&todo "TODO: \s \0

@pstr ( str* -- )
	LDAk .Console/write DEO
	INC2 LDAk ?pstr
	POP2
	JMP2r
```

## Opcodes

The opcodes "dictionary" (str => int) is implemented using as keys an array of
strings and an enum for the values. 

* OpK: Opcodes string keys.
* OpV: Opcodes integer values.

```uxntal
@OpK [
	&EX "EX $1 
	&AD "AD $1  &SB "SB $1  &ML "ML $1  &DV "DV $1  &MD "MD $1  &SH "SH $1 
	&AN "AN $1  &OR "OR $1  &XR "XR $1  &NT "NT $1  &EQ "EQ $1  &LT "LT $1 
	&DU "DU $1  &SW "SW $1  &OV "OV $1  &ZP "ZP $1  &DC "DC $1  &CD "CD $1 
	&RV "RV $1  &WV "WV $1  &LB "LB $1  &LI "LI $1 
	&JM "JM $1  &HP "HP $1  &H0 "H0 $1  &CL "CL $1  &RT "RT $1  &NX "NX $1 
	&VB "VB $1  &VI "VI $1 
	&DB "DB $1  &HL "HL $1 ]

@OpV [
	|7f &EX $1 
	&AD $1  &SB $1  &ML $1  &DV $1  &MD $1  &SH $1 
	&AN $1  &OR $1  &XR $1  &NT $1  &EQ $1  &LT $1 
	&DU $1  &SW $1  &OV $1  &ZP $1  &DC $1  &CD $1 
	&RV $1  &WV $1  &LB $1  &LI $1 
	&JM $1  &HP $1  &H0 $1  &CL $1  &RT $1  &NX $1 
	|c0 &VB $1  &VI $1 
	|fe &DB $1  &HL $1 
] |OpV
```

# Buffers 

```uxntal
@ram $400 &end
```
