tell application "System Events"
    -- Simulate ctrl-alt-shift-cmd-h
    key down control
    key down option
    key down shift
    key down command
    key down "h"
    key up "h"
    key up command
    key up shift
    key up option
    key up control

    delay 0.1

    do shell script "/bin/zsh ~/Scripts/move_focus_to_any_next_window_nosort.sh"

    delay 0.1

    -- Simulate ctrl-alt-shift-cmd-l
    key down control
    key down option
    key down shift
    key down command
    key down "l"
    key up "l"
    key up command
    key up shift
    key up option
    key up control
end tell
