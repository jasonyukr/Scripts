tell application "Obsidian"
    set appIsRunning to running
    if appIsRunning then
        try
            if (count of windows) > 0 then
                set the frontmost of the first window to true
                activate
            else
                -- Open a new vault window using the Obsidian URI scheme
                do shell script "open 'obsidian://new-window'"
                activate
            end if
        on error
            -- Open a new vault window using the Obsidian URI scheme
            do shell script "open 'obsidian://new-window'"
            activate
        end try
    else
        launch
        activate
    end if
end tell
