# MSP430 Blinky-Buzzy Toy

A state machine-based toy for the MSP430G2553 microcontroller featuring LED patterns, sound generation, and button controls.

## Description

This toy implements a state machine with 5 states:
- **IDLE**: Both LEDs off, waiting for input
- **PLAY_TUNE**: Plays a melody (C-E-G-C)
- **FLASH_FAST**: Fast red LED flashing
- **FLASH_SLOW**: Slow red LED flashing
- **FREERUN**: Random LED and sound effects

## Hardware Requirements

- MSP430G2553 LaunchPad
- Expansion board with 4 buttons (P2.0-P2.3)
- Red LED on P1.0
- Green LED on P1.6 (PWM controlled)
- Speaker/buzzer on P2.6 (optional)

## Button Controls

- **Button 0 (P2.0)**: Advance to next state (assembly function)
- **Button 1 (P2.1)**: Go to previous state
- **Button 2 (P2.2)**: Manually play melody
- **Button 3 (P2.3)**: Jump to FREERUN state

## Prerequisites

1. **MSP430 GCC Toolchain**: Install the MSP430 GCC compiler
   - On Linux: `sudo apt-get install gcc-msp430`
   - On Windows: Download from [TI's website](https://www.ti.com/tool/MSP430-GCC-OPENSOURCE)
   - On macOS: `brew install msp430-gcc`

2. **MSP430 Flasher**: Install a tool to load the program
   - `mspdebug` (Linux/macOS): `sudo apt-get install mspdebug` or `brew install mspdebug`
   - `msp430flasher` (Windows/Linux): Download from TI
   - Or use `msp430loader.sh` if available in your environment

## Building the Project

1. Navigate to the source directory:
   ```bash
   cd project/src
   ```

2. Build the project:
   ```bash
   make
   ```

   This will create `toy.elf` - the executable file for the MSP430.

3. Clean build artifacts:
   ```bash
   make clean
   ```

## Loading to MSP430

### Option 1: Using mspdebug (Linux/macOS)

```bash
mspdebug rf2500 "prog toy.elf"
```

### Option 2: Using msp430flasher (Windows/Linux)

```bash
msp430flasher -n MSP430G2553 -w toy.elf -v -z [VCC,RESET]
```

### Option 3: Using msp430loader.sh (if available)

```bash
make load
```

### Option 4: Using Code Composer Studio (CCS)

1. Import the project into CCS
2. Build the project
3. Use the debug/run button to load and run

## Project Structure

```
project/
├── README.md
└── src/
    ├── main.c            # Main program entry point
    ├── toy.c             # Hardware init and state machine
    ├── toy.h             # Header file with definitions
    ├── asm_next_state.S  # Assembly state transition function
    └── Makefile          # Build configuration
```

## How to Use

1. Load the program to your MSP430 board
2. Press Button 0 to cycle through states
3. Press Button 1 to go backwards through states
4. Press Button 2 to play the melody at any time
5. Press Button 3 to enter FREERUN mode

## Troubleshooting

- **Compilation errors**: Ensure MSP430 GCC toolchain is installed and in PATH
- **Upload errors**: Check USB connection and that the board is in programming mode
- **No response**: Verify button connections and that interrupts are enabled
- **No sound**: Check speaker/buzzer connection to P2.6

