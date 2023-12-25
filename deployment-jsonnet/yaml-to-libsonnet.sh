#!/bin/bash

# Check if both directory paths were provided as arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Please provide both the input directory and output directory paths as arguments."
    exit 1
fi

# Store the provided directory paths
input_directory="$1"
output_directory="$2"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Iterate through each YAML file in the input directory
for file in "$input_directory"/*.yaml; do
    # Extract the base filename without the extension
    base_filename="${file##*/}"  # Use ##*/ to remove everything up to the last slash
    base_filename="${base_filename%.*}"  # Remove extensione

    # Convert the YAML file to JSON and save it in the output directory
    yq -o json "$file" > "$output_directory/${base_filename}.libsonnet"
done
