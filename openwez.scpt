set appName to "WezTerm"

if application appName is running then
  delay 0.1
  Do Shell Script "/Applications/WezTerm.app/Contents/MacOS/wezterm-gui"
else
  delay 0.1
  tell application appName to activate
end if
