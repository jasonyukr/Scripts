set appName to "Finder"

if application appName is running then
  tell application "Finder"
    make new Finder window
  end tell
  tell application "Finder"
    activate
  end tell
else
  tell application "Finder"
    activate
  end tell
end if
