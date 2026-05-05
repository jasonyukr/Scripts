#!/bin/zsh
set -euo pipefail

pbpaste | pbcopy
sleep 0.2
osascript -e 'tell application "System Events" to keystroke "v" using command down'
