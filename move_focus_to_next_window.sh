#!/bin/zsh

local FOCUSED_WINDOW_ID
local FOCUSED_DESKTOP_ID
local FOCUSED_APP_NAME
local WINDOW_ID
local NEXT_WINDOW_ID
local NEXT_WINDOW_IDX
local DESKTOP_ID
local APP_NAME
local QLINES
local LINE
local CNT
local FOCUSED_IDX
local LIST

PATH=$PATH$:/opt/bin

QLINES=$(listwnd -s)
if [ -z "$QLINES" ]; then
  exit
fi

# Get the currently focused desktop-ID, window-ID and app-ID as well
LINE=$(echo $QLINES | rg "^[0-9] true ")
FOCUSED_DESKTOP_ID=$(echo $LINE | choose 0)
FOCUSED_WINDOW_ID=$(echo $LINE | choose 2)
FOCUSED_APP_NAME=$(echo $LINE | pickup -s 3)
if [ -z "$FOCUSED_DESKTOP_ID" ] || [ -z "$FOCUSED_WINDOW_ID" ] || [ -z "$FOCUSED_APP_NAME" ]; then
  return
fi

# Populate LIST
CNT=0
FOCUSED_IDX=""
LIST="#"
echo $QLINES | while IFS= read -r LINE; do
  WINDOW_ID=$(echo $LINE | choose 2)
  DESKTOP_ID=$(echo $LINE | choose 0)
  APP_NAME=$(echo $LINE | pickup -s 3)
  if [ "$FOCUSED_DESKTOP_ID" = "$DESKTOP_ID" ] && [ "$FOCUSED_APP_NAME" = "$APP_NAME" ]; then
    ((CNT++))
    if [ "$FOCUSED_WINDOW_ID" = "$WINDOW_ID" ]; then
      FOCUSED_IDX=$CNT
    fi
    LIST="$LIST $WINDOW_ID"
  fi
done
#echo $LIST

# Decide the next window-ID to be focused
if [[ $FOCUSED_IDX -lt $CNT ]]; then
  NEXT_WINDOW_IDX=$((FOCUSED_IDX + 1))
elif [[ $FOCUSED_IDX -eq $CNT ]]; then
  NEXT_WINDOW_IDX=1
else
  return
fi
NEXT_WINDOW_ID=$(echo $LIST | choose $NEXT_WINDOW_IDX)
#echo $NEXT_WINDOW_ID

# Focus the next window-ID
yabai -m window --focus $NEXT_WINDOW_ID
