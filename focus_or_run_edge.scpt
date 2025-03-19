tell application "Microsoft Edge"
    delay 0.1
    if it is running then
        activate
    else
        launch
    end if
end tell
