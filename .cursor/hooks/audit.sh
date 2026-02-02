#!/bin/bash
# Hook: Audit shell commands before execution
# This hook runs before any shell command is executed

# Read JSON input from stdin
input=$(cat)

# Extract command from the input
command=$(echo "$input" | grep -o '"command":"[^"]*' | cut -d'"' -f4)

if [ -z "$command" ]; then
  # No command found, allow by default
  echo '{"permission":"allow"}'
  exit 0
fi

# Example: Block dangerous commands
case "$command" in
  *"rm -rf /"*|*"rm -rf ~"*|*"format"*)
    echo "{\"permission\":\"deny\",\"user_message\":\"Dangerous command blocked\",\"agent_message\":\"This command is blocked for safety reasons\"}"
    exit 0
    ;;
  *)
    # Allow other commands
    echo '{"permission":"allow"}'
    exit 0
    ;;
esac
