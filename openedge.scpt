set appName to "Microsoft Edge"

if application appName is running then
  tell application appName to make new window
else
  tell application appName to activate
end if
