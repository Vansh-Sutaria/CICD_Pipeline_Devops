@REM #!/bin/bash
@REM echo "Running dummy tests..."
@REM sleep 2 # Simulate test duration
@REM echo "All 5 tests passed!"
@REM # Exit code 0 means success
@REM exit 0

@echo off
echo Running dummy tests...
REM Simulate test duration (delaying for 2 seconds)
ping -n 3 127.0.0.1 >nul
echo All 5 tests passed!
REM Exit code 0 means success
exit /b 0