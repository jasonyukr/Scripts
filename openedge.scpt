set appName to "Microsoft Edge"

if application appName is running then
  delay 0.2
  tell application appName to make new window
else
  delay 0.2
  tell application appName to activate
end if
