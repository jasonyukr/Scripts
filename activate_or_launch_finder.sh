#!/bin/zsh

local LIST
local CUR
local APPNAME

APPNAME="Finder"

PATH=$PATH$:/opt/bin

LIST=$(findwnd $APPNAME)

if [ -z "$LIST" ]; then
  echo "No window found. Make new Finder window"
  osascript -e "tell application \"$APPNAME\"" -e "make new Finder window" -e "end tell"
elif [ "$LIST" = "APP-NOT-FOUND" ]; then
  # This is impossible case !!
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

# By unknown reasons, sometimes the finder window doesn't grab the focus.
# Give some sleep and activate again to workaround the focus issue.
sleep 0.2
osascript -e "tell application \"$APPNAME\"" -e "activate" -e "end tell"
