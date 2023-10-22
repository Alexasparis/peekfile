#!/bin/bash

input_file="$1"
lines_to_display="$2"

# Display the specified number of lines from the beginning
head -n "$lines_to_display" "$input_file"

# Display "..."
echo "..."

# Display the specified number of lines from the end
tail -n "$lines_to_display" "$input_file"

