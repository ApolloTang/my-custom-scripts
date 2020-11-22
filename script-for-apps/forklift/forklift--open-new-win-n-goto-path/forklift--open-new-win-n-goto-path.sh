#!/bin/bash

#/ -----------------------------------------------------
#/ Open a new forklift window and goto path
#/
#/ Adapted from https://gist.github.com/McNull/9779719
#/ Adapted from https://gist.github.com/elentok/6218781
#/ Adapted from comment https://gist.github.com/elentok/6218781#comment-891115
#/ -----------------------------------------------------

set -e  #/ Exit immediately if a command exits with a non-zero status.

if [ -z "$@" ]; then
  absPath=`pwd`
else
  pushd $@ > /dev/null
  absPath=`pwd`
  echo $absPath
  popd > /dev/null
fi


(cat<<EOF

# AppleScript Start
# -------------------
(*

Author: https://github.com/ApolloTang
This script open a new forklift window and goto path

Also need to add some (or all) of the following 'Security & Privacy' setting:

  Goto:
    System Preferences -> Security & Privacy -> Accessibility
    System Preferences -> Security & Privacy -> Input Monitoring
  Add:
    /System/Applications/Utilities/Script Editor.app
    /System/Library/CoreServices/AppleScript Utility
    /System/Library/CoreServices/System Events.app
    /usr/local/bin/bash
    /Applications/Setapp/ForkLift.app

Reference:
  https://apple.stackexchange.com/questions/394275/com-automator-runner-xpc-is-not-allowed-to-send-keystrokes#
*)


if application "ForkLift" is not running then
  # This will launch Forklift if it's not running
  # (But it's not making it the frontmost/focused application)
  activate application "ForkLift"

  # We wait 1 second so that we're sure ForkLift did launch
  delay 1
end if

# Give focus to ForkLift
activate application "ForkLift"

tell application "System Events"
  tell process "ForkLift"
    # Open new window
    keystroke "n" using {command down}

    # Using ForkLift's "Go to Folder"
    keystroke "g" using {command down, shift down}

    # Enter path and press return
    keystroke "$absPath"
    keystroke return
  end tell
end tell

# ^^^^^^^^^^^^^^^^^^^
# AppleScript End

EOF
) | osascript

#/ EOF ---
