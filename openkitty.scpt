set appName to "Kitty"

if application appName is running then
  Do Shell Script "/Applications/kitty.app/Contents/MacOS/kitty @ launch --type=os-window"
else
  tell application appName to activate
end if
