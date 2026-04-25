#!/bin/zsh

local FOCUSED_WINDOW_ID
local FOCUSED_DESKTOP_ID
local FOCUSED_APP_NAME
local WINDOW_ID
local PREV_WINDOW_ID
local PREV_WINDOW_IDX
local DESKTOP_ID
local APP_NAME
local QLINES
local LINE
local CNT
local FOCUSED_IDX
local LIST
local REMEMBERED_WINDOW_ID
local STATE_FILE
local -A APP_NAMES
local -A DESKTOP_WINDOW_IDS
local -A REMEMBERED_WINDOW_IDS

PATH=$PATH$:/opt/bin

QLINES=$(listwnd -s | grep -v "Deskflow" | awk 'NR==FNR { ids[$1]; next } $3 in ids' <(yabai -m query --windows | jq -r '.[] | select(."has-ax-reference" == true) | .id') -)
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

STATE_FILE="${TMPDIR:-/tmp}/move_focus_to_other_window_reps_$FOCUSED_DESKTOP_ID"
if [ -f "$STATE_FILE" ]; then
  while IFS=$'\t' read -r WINDOW_ID APP_NAME; do
    if [ -n "$WINDOW_ID" ] && [ -n "$APP_NAME" ]; then
      REMEMBERED_WINDOW_IDS[$APP_NAME]=$WINDOW_ID
    fi
  done < "$STATE_FILE"
fi
REMEMBERED_WINDOW_IDS[$FOCUSED_APP_NAME]=$FOCUSED_WINDOW_ID
: > "$STATE_FILE"
for APP_NAME in "${(@k)REMEMBERED_WINDOW_IDS}"; do
  print -r -- "$REMEMBERED_WINDOW_IDS[$APP_NAME]"$'\t'"$APP_NAME" >> "$STATE_FILE"
done

echo $QLINES | while IFS= read -r LINE; do
  WINDOW_ID=$(echo $LINE | choose 2)
  DESKTOP_ID=$(echo $LINE | choose 0)
  if [ "$FOCUSED_DESKTOP_ID" = "$DESKTOP_ID" ]; then
    DESKTOP_WINDOW_IDS[$WINDOW_ID]=1
  fi
done

# Populate LIST
CNT=0
FOCUSED_IDX=""
LIST="#"
echo $QLINES | while IFS= read -r LINE; do
  WINDOW_ID=$(echo $LINE | choose 2)
  DESKTOP_ID=$(echo $LINE | choose 0)
  APP_NAME=$(echo $LINE | pickup -s 3)
  if [ "$FOCUSED_DESKTOP_ID" = "$DESKTOP_ID" ]; then
    if [ "$FOCUSED_APP_NAME" = "$APP_NAME" ]; then
      if [ "$FOCUSED_WINDOW_ID" = "$WINDOW_ID" ]; then
        ((CNT++))
        FOCUSED_IDX=$CNT
        LIST="$LIST $WINDOW_ID"
      else
        # ignore other windows for this (the same) app
        ;
      fi
    else
      if [ -z "$APP_NAMES[$APP_NAME]" ]; then
        APP_NAMES[$APP_NAME]=1
        REMEMBERED_WINDOW_ID=$REMEMBERED_WINDOW_IDS[$APP_NAME]
        if [ -n "$REMEMBERED_WINDOW_ID" ] && [ -n "$DESKTOP_WINDOW_IDS[$REMEMBERED_WINDOW_ID]" ]; then
          WINDOW_ID=$REMEMBERED_WINDOW_ID
        fi
        ((CNT++))
        LIST="$LIST $WINDOW_ID"
      fi
    fi
  fi
done
#echo $LIST

# Decide the prev window-ID to be focused
if [[ $FOCUSED_IDX -gt 1 ]]; then
  PREV_WINDOW_IDX=$((FOCUSED_IDX - 1))
elif [[ $FOCUSED_IDX -eq 1 ]]; then
  PREV_WINDOW_IDX=$CNT
else
  return
fi
PREV_WINDOW_ID=$(echo $LIST | choose $PREV_WINDOW_IDX)
#echo $PREV_WINDOW_ID

# Focus the prev window-ID
yabai -m window --focus $PREV_WINDOW_ID
