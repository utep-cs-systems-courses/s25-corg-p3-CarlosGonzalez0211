all: libTimer.a

CPU             = msp430g2553
CFLAGS          = -mmcu=${CPU} -I"C:\ti\msp430-gcc\include" 

#switch the compiler (for the internal make rules)
CC              = msp430-elf-gcc
AS              = msp430-elf-as
AR              = msp430-elf-ar

libTimer.a: clocksTimer.o sr.o
	$(AR) crs $@ $^

install: libTimer.a
	powershell -Command "if (-not (Test-Path '../h')) { New-Item -ItemType Directory -Path '../h' | Out-Null }"
	powershell -Command "if (-not (Test-Path '../lib')) { New-Item -ItemType Directory -Path '../lib' | Out-Null }"
	powershell -Command "Move-Item -Force libTimer.a '../lib/'"
	powershell -Command "Copy-Item *.h '../h/'"

clean:
	powershell -Command "Remove-Item libTimer.a,*.o -ErrorAction SilentlyContinue"

