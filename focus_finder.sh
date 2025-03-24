#!/bin/zsh

local CNT
local APPNAME
local APPID

APPNAME="Finder"
APPID="com.apple.finder"

PATH=$PATH$:/opt/bin

CNT=$(countwnd $APPID)

if [ -z "$CNT" ] || [ "$CNT" = "Z" ]; then
  # This is impossible case !!
  echo "App not running. Launch and activate"
  osascript -e "tell application \"$APPNAME\"" -e "launch" -e "activate" -e "end tell"
elif [ "$CNT" = "0" ]; then
  echo "No window found. Make new Finder window"
  osascript -e "tell application \"$APPNAME\"" -e "make new Finder window" -e "end tell"
else
  echo "Window found. Activate"
  osascript -e "tell application \"$APPNAME\"" -e "activate" -e "end tell"
fi

# By unknown reasons, sometimes the finder window doesn't grab the focus.
# Give some sleep and activate again to workaround the focus issue.
sleep 0.1
osascript -e "tell application \"$APPNAME\"" -e "activate" -e "end tell"
sleep 0.1
osascript -e "tell application \"$APPNAME\"" -e "activate" -e "end tell"
