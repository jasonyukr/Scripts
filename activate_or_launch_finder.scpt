tell application "Finder"
    if (count of Finder windows) is 0 then
        make new Finder window
    else
        activate
        delay 0.1 -- Give the app a moment to activate

        set currentWindow to missing value
        repeat with aWindow in windows
            if aWindow's visible then
                set currentWindow to aWindow
                exit repeat
            end if
        end repeat

        if currentWindow is not missing value then
            set index of currentWindow to 1 -- Bring it to the front
        end if
    end if
end tell
