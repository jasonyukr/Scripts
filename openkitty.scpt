set appName to "kitty"

if application appName is running then
  Do Shell Script "/Applications/kitty.app/Contents/MacOS/kitty"
else
  tell application appName to activate
end if
