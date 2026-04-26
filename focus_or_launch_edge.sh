#!/bin/zsh

PATH=$PATH:/opt/bin:/opt/homebrew/bin
if [[ -x /opt/homebrew/bin/hs ]]; then
    hs=/opt/homebrew/bin/hs
elif [[ -x /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs ]]; then
    hs=/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs
else
    hs=$(command -v hs)
fi
if [[ -z $hs ]]; then
    print -u2 "Hammerspoon hs binary not found. Install Hammerspoon (for example: brew install --cask hammerspoon) and enable Accessibility permissions."
    exit 1
fi

####################################################
TARGET="Microsoft Edge"

"$hs" -c "hs.application.launchOrFocus(\"$TARGET\")"
