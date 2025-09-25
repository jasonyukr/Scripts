#!/bin/zsh

local APPNAME
local STATUS
local ITEM
local FULL_LIST
local LIST
local CNT
local CURR_DESKTOP

PATH=$PATH$:/opt/bin

APPNAME="kitty"

STATUS=$(appstatus $APPNAME)
if [ ! "$STATUS" = "running" ]; then
  echo "App not running. Launch and activate"
  osascript -e "tell application \"$APPNAME\"" -e "launch" -e "activate" -e "end tell"
  exit
fi

FULL_LIST=$(listwnd)
LIST=$(echo $FULL_LIST | rg "\"$APPNAME\"")
if [ -z "$LIST" ]; then
  CNT="0"
else
  CNT=$(echo $LIST | wc -l | trim)
fi
if [ "$CNT" = "0" ]; then
  echo "No window found UNEXPECTEDLY. Activate"
  osascript -e "tell application \"$APPNAME\"" -e "activate" -e "end tell"
  exit
fi

CURR_DESKTOP=$(echo $FULL_LIST | rg "^[0-9] true " | choose 0)
ITEM=$(echo $LIST | grep "^${CURR_DESKTOP} " | head -n 1)
if [ ! -z "$ITEM" ]; then
  echo "Window found in current desktop. Focus it"
  WINDOW_ID=$(echo $ITEM | choose 2)
  yabai -m window --focus $WINDOW_ID
  exit
fi
ITEM=$(echo $LIST | grep -v "^${CURR_DESKTOP} " | head -n 1)
if [ ! -z "$ITEM" ]; then
  echo "Window found in another desktop. Focus it"
  WINDOW_ID=$(echo $ITEM | choose 2)
  yabai -m window --focus $WINDOW_ID
  exit
fi
