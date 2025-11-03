#!/bin/bash
echo "Starting compilation/packaging..."
# Create a dummy build directory and file
mkdir -p build
echo "App built successfully on $(date)" > build/app-output.txt
# Create the artifact that the Jenkinsfile archives
zip -r build/app-output.zip build/
echo "Build complete. Artifact created at build/app-output.zip"