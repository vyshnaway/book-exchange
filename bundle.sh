#!/bin/bash

# Define the output zip file name
OUTPUT_FILE="project_bundle.zip"

# Remove existing bundle if it exists
if [ -f "$OUTPUT_FILE" ]; then
    rm "$OUTPUT_FILE"
fi

# Create the zip file excluding specific files/folders
# -r: recurse into directories
# -x: exclude the following names
zip -r "$OUTPUT_FILE" . \
    -x "*.git*" \
    -x "bundle.sh" \
    -x "*__pycache__*" \
    -x "*node_modules*" \
    -x "*.DS_Store" \
    -x "*.venv*" \
    -x "*.vscode*" \
    -x "*.idea*" \
    -x "*.pyc" \
    -x "*.zip"

echo "Project bundled into $OUTPUT_FILE"
