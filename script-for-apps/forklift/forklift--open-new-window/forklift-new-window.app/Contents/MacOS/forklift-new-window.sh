#!/bin/bash
#/ Open a new forklift window

set -e  #/ Exit immediately if a command exits with a non-zero status.

(cat<<EOF

# AppleScript Start
# -------------------
(*

Author: https://github.com/ApolloTang
This script open a new forklift window

Make sure you endable "Script Editor.app" in Accesibility

Goto:
  System Preferences -> Security & Privacy -> Accessibility
  System Preferences -> Security & Privacy -> Input Monitoring
Add:
  /System/Applications/Utilities/Script Editor.app

*)


if application "ForkLift" is not running then
  # This will launch Forklift if it's not running
  # (But it's not making it the frontmost/focused application)
  activate application "ForkLift"
else
  tell application "ForkLift"
    activate
    tell application "System Events"
      keystroke "n" using {command down}
    end tell
  end tell
end if
# ^^^^^^^^^^^^^^^^^^^
# AppleScript End

EOF
) | osascript

#/ EOF ---
