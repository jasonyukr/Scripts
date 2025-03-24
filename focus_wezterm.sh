#!/bin/zsh

local CNT
local APPNAME
local APPID

APPNAME="WezTerm"
APPID="com.github.wez.wezterm"

PATH=$PATH$:/opt/bin

CNT=$(countwnd $APPID)

if [ -z "$CNT" ] || [ "$CNT" = "Z" ]; then
  echo "App not running. Launch and activate"
  osascript -e "tell application \"$APPNAME\"" -e "launch" -e "activate" -e "end tell"
elif [ "$CNT" = "0" ]; then
  echo "No window found unexpectedly. Activate"
  osascript -e "tell application \"$APPNAME\"" -e "activate" -e "end tell"
else
  echo "Window found. Activate"
  osascript -e "tell application \"$APPNAME\"" -e "activate" -e "end tell"
fi
