SYMBOLS {
	__STACKSIZE__: type = export, value = $FF;
		__STACK__: type = export, value = $100;
}
MEMORY {
    ZP:			file = "", define = yes, start = $0002, size = $00FE;
	RAM:		file = "", define = yes, start = $0300, size = $0500;
	STACK:		file = "", define = yes, start = __STACK__, size = __STACKSIZE__;
	BASIC:		file = %O, define = yes, start = $C000, size = $2000, fill = yes;
	MAIN:		file = %O, define = yes, start = $E000, size = $2000, fill = yes;
}

SEGMENTS {
    ZEROPAGE: 	load = ZP,		type = zp;
	DATA:     	load = MAIN,	type = rw, run = RAM, define = yes;
	BSS:      	load = RAM,		type = bss, define = yes;
	INIT:		load = MAIN,	type = rw;
	STARTUP:	load = MAIN,	type = ro;
    ONCE:		load = MAIN,	type = ro;
    CODE:     	load = MAIN,	type = ro;
    RODATA:   	load = MAIN,	type = ro, optional = yes;
	CHARSET:	load = MAIN,	type = ro, offset = $1000;
	SCREEN:		load = MAIN,	type = ro, offset = $1800;
	VECTORS:	load = MAIN,	type = ro, offset = $1FFA;
}

FEATURES {
    CONDES: type    = constructor,
            label   = __CONSTRUCTOR_TABLE__,
            count   = __CONSTRUCTOR_COUNT__,
            segment = ONCE;
    CONDES: type    = destructor,
            label   = __DESTRUCTOR_TABLE__,
            count   = __DESTRUCTOR_COUNT__,
            segment = RODATA;
}
