set appName to "WezTerm"

if application appName is running then
  delay 0.2
  Do Shell Script "/Applications/WezTerm.app/Contents/MacOS/wezterm-gui"
else
  delay 0.2
  tell application appName to activate
end if
