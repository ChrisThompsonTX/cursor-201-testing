#!/bin/bash
# Hook: Format files after Agent edits
# This hook runs after the Agent edits a file

# Read JSON input from stdin
input=$(cat)

# Extract file path from the input
file_path=$(echo "$input" | grep -o '"file_path":"[^"]*' | cut -d'"' -f4)

if [ -z "$file_path" ]; then
  # No file path found, exit successfully
  exit 0
fi

# Check if file exists
if [ ! -f "$file_path" ]; then
  exit 0
fi

# Example: Auto-format based on file type
case "$file_path" in
  *.js|*.jsx|*.ts|*.tsx|*.json)
    # Format JavaScript/TypeScript files with prettier if available
    if command -v prettier &> /dev/null; then
      prettier --write "$file_path" 2>/dev/null || true
    fi
    ;;
  *.py)
    # Format Python files with black if available
    if command -v black &> /dev/null; then
      black "$file_path" 2>/dev/null || true
    fi
    ;;
  *)
    # No formatter for this file type
    ;;
esac

# Exit successfully
exit 0
