# Makefile configuration
COMMON_OBJECTS  = 
CPU             = msp430g2553
CFLAGS          = -mmcu=${CPU} -I. -Os -g
LDFLAGS         = -L/opt/ti/msp430_gcc/include

# Switch the compiler (for the internal make rules)
CC              = msp430-elf-gcc
AS              = msp430-elf-as

all: toy.elf 

# Additional rules for files
toy.elf: ${COMMON_OBJECTS} main.o toy.o asm_next_state.o
	${CC} ${CFLAGS} ${LDFLAGS} -o $@ $^

load: toy.elf
	msp430loader.sh toy.elf

clean:
	rm -f *.o *.elf

main.o: main.c toy.h
	${CC} ${CFLAGS} -c main.c

toy.o: toy.c toy.h
	${CC} ${CFLAGS} -c toy.c

asm_next_state.o: asm_next_state.S
	${CC} ${CFLAGS} -DNUM_STATES=5 -c -o $@ $<

