tell application "Finder"
    if it is running then
        if (count of Finder windows) is 0 then
            make new Finder window
        else
            activate
        end if
    else
        activate
    end if
end tell
