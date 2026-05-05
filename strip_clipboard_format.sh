#!/bin/zsh
set -e

if command -v pbpaste >/dev/null && command -v pbcopy >/dev/null; then
  pbpaste | pbcopy
else
  exit 1
fi

command -v osascript >/dev/null && osascript -e 'display notification "Clipboard formatting stripped"' || true
