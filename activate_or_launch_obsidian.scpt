set appName to "Obsidian"

if application appName is running then
  delay 0.1
  tell application appName to activate
else
  delay 0.1
  tell application appName to launch
end if
