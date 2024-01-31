#!/bin/bash

# Define the target directory
TARGET_DIR="/tmp/results/default"

# Find and delete .safetensors files in the target directory and its subdirectories
find "$TARGET_DIR" -type f -name "*.safetensors" -exec rm -f {} \;

echo "All .safetensors files in $TARGET_DIR have been deleted."

