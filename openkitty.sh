#!/bin/zsh

local APPNAME
local STATUS
local KITTY_SOCKET

APPNAME="kitty"
STATUS=$(appstatus $APPNAME)
if [ ! "$STATUS" = "running" ]; then
  echo "App not running. Launch and activate"
  osascript -e "tell application \"$APPNAME\"" -e "launch" -e "activate" -e "end tell"
  exit
fi

KITTY_SOCKET=$(ls -t /tmp/kitty* | head -n 1)
/Applications/kitty.app/Contents/MacOS/kitty @ --to unix:"$KITTY_SOCKET" launch --type=os-window
