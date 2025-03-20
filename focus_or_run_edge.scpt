tell application "Microsoft Edge"
    activate
    delay 0.3 -- Give Edge a moment to activate

    set currentWindow to missing value
    repeat with aWindow in windows
        if aWindow's visible then
            set currentWindow to aWindow
            exit repeat
        end if
    end repeat

    if currentWindow is not missing value then
        set index of currentWindow to 1 -- Bring it to the front
    else
        -- If no visible window is found, create a new one
        make new window
    end if

    -- Check for no windows case.
    if (count of windows) is 0 then
      make new window
    end if

end tell
