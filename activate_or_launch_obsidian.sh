#!/bin/zsh

local LIST
local CUR
local APPNAME

APPNAME="Obsidian"

PATH=$PATH$:/opt/bin

LIST=$(findwnd $APPNAME)

if [ -z "$LIST" ]; then
  echo "No window found. Open new window"
  open 'obsidian://new-window'
elif [ "$LIST" = "APP-NOT-FOUND" ]; then
  echo "App not running. Launch and activate"
  osascript -e "tell application \"$APPNAME\"" -e "launch" -e "activate" -e "end tell"
else
  CUR=$(echo "$LIST" | grep "DESKTOP:CUR")
  if [ -z "$CUR" ]; then
    echo "Window found in other desktop. Activate"
  else
    echo "Window found in current desktop. Activate"
  fi
  osascript -e "tell application \"$APPNAME\"" -e "activate" -e "end tell"
fi
