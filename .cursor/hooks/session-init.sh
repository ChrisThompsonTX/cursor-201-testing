#!/bin/bash
# Hook: Initialize session
# This hook runs when a new composer conversation starts

# Read JSON input from stdin
input=$(cat)

# Extract session ID
session_id=$(echo "$input" | grep -o '"session_id":"[^"]*' | cut -d'"' -f4)

# Log session start (optional)
# echo "Session started: $session_id" >> ~/.cursor/hooks/session.log

# Return optional environment variables and context
# You can set environment variables that will be available to all subsequent hooks
cat <<EOF
{
  "env": {
    "HOOK_SESSION_ID": "$session_id"
  },
  "additional_context": "Session initialized with hooks",
  "continue": true
}
EOF

exit 0
