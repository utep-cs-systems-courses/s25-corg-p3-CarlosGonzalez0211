# Windows PowerShell version of msp430loader.sh
# This allows Makefiles to work on Windows by providing a compatible loader

param(
    [Parameter(Mandatory=$true)]
    [string]$ElfFile
)

Write-Host "Loading $ElfFile to MSP430..." -ForegroundColor Green

# Check if file exists
if (-not (Test-Path $ElfFile)) {
    Write-Host "ERROR: $ElfFile not found!" -ForegroundColor Red
    exit 1
}

# Try mspdebug first (works with .elf directly)
$mspdebug = Get-Command mspdebug -ErrorAction SilentlyContinue
if ($mspdebug) {
    Write-Host "Using mspdebug..." -ForegroundColor Cyan
    & mspdebug rf2500 "prog $ElfFile"
    if ($LASTEXITCODE -eq 0) {
        exit 0
    }
    # Try tilib if rf2500 fails
    & mspdebug tilib "prog $ElfFile"
    if ($LASTEXITCODE -eq 0) {
        exit 0
    }
}

# Fall back to MSP430Flasher
$flasherPath = "C:\TI\MSPFlasher_1.3.20\MSP430Flasher.exe"
if (-not (Test-Path $flasherPath)) {
    $found = Get-ChildItem -Path "C:\TI", "C:\Program Files*" -Filter "MSP430Flasher.exe" -Recurse -ErrorAction SilentlyContinue -File | Select-Object -First 1
    if ($found) {
        $flasherPath = $found.FullName
    }
}

if (Test-Path $flasherPath) {
    Write-Host "Using MSP430Flasher..." -ForegroundColor Cyan
    
    # Convert to HEX
    $hexFile = $ElfFile -replace '\.elf$', '.hex'
    & msp430-elf-objcopy -O ihex $ElfFile $hexFile
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to convert to HEX" -ForegroundColor Red
        exit 1
    }
    
    # Load
    & $flasherPath -n MSP430G2553 -w $hexFile -v -g -z [VCC,RESET]
    exit $LASTEXITCODE
} else {
    Write-Host "ERROR: Neither mspdebug nor MSP430Flasher found!" -ForegroundColor Red
    exit 1
}

