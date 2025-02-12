#!/bin/bash

# Check if there are .c files in the current directory
if ! find . -type f -name "*.c" | grep -q .; then
    exit 1
fi

# Path to the permanently resized PNG
PNG_FILE="$HOME/.config/starship/c_icon.png"

# Check if the resized icon exists before displaying it
if [ -f "$PNG_FILE" ]; then
    kitty +kitten icat --align left "$PNG_FILE"
fi

# Print a space to avoid breaking Starship formatting
echo -n " "

