tell application "WezTerm"
    delay 0.1
    try
        activate
    on error
        launch
    end try
end tell
