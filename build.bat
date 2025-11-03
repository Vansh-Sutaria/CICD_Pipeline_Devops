@REM #!/bin/bash
@REM echo "Starting compilation/packaging..."
@REM # Create a dummy build directory and file
@REM mkdir -p build
@REM echo "App built successfully on $(date)" > build/app-output.txt
@REM # Create the artifact that the Jenkinsfile archives
@REM zip -r build/app-output.zip build/
@REM echo "Build complete. Artifact created at build/app-output.zip"

@echo off
echo Starting compilation/packaging...

REM Create a dummy build directory
if not exist "build" mkdir build

REM Create the dummy application output file (Artifact)
echo App built successfully on %date% %time% > build\app-output.txt

echo Build complete. Artifact created at build\app-output.txt
exit /b 0