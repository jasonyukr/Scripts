tell application "WezTerm"
    delay 0.2
    try
        activate
    on error
        launch
    end try
end tell
