tell application "Finder"
    if (count of Finder windows) is 0 then
        make new Finder window
    else
        activate
        delay 0.3 -- Give the app a moment to activate
        tell application "System Events"
            set frontmost of process "Finder" to true
        end tell
    end if
end tell
