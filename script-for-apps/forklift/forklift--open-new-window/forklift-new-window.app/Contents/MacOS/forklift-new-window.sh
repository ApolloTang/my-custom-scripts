#!/bin/bash
#/ Open a new forklift window

set -e  #/ Exit immediately if a command exits with a non-zero status.

(cat<<EOF

# AppleScript Start
# -------------------
(*

Author: https://github.com/ApolloTang
This script open a new forklift window

Also need to add some (or all) of the following 'Security & Privacy' setting:

  Goto:
    System Preferences -> Security & Privacy -> Accessibility
    System Preferences -> Security & Privacy -> Input Monitoring
  Add:
    /System/Applications/Utilities/Script Editor.app
    /System/Library/CoreServices/AppleScript Utility
    /System/Library/CoreServices/System Events.app
    /Applications/Setapp/ForkLift.app

Reference:
  https://apple.stackexchange.com/questions/394275/com-automator-runner-xpc-is-not-allowed-to-send-keystrokes#
*)


if application "ForkLift" is not running then
  # This will launch Forklift if it's not running
  # (But it's not making it the frontmost/focused application)
  activate application "ForkLift"
else
  activate application "ForkLift"
  tell application "System Events"
    tell process "ForkLift"
      keystroke "n" using {command down}
    end tell
  end tell
end if
# ^^^^^^^^^^^^^^^^^^^
# AppleScript End

EOF
) | osascript

#/ EOF ---
