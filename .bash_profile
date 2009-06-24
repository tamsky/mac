#!/bin/bash

# from android instructions: http://source.android.com/download
ulimit -S -n 1024

# command to mount the android file image
function mountAndroid {
  hdiutil attach /Users/Shared/mtamsky/AndroidVolume.dmg  -mountpoint /Volumes/android; }

echo "This is a bash login shell $0 - on $HOSTNAME"
export PATH=${PATH}:/usr/X11R6/bin:/usr/X11/bin:/opt/local/bin:/opt/local/sbin:${HOME}/bin:~/src/android-sdk-mac_x86-1.5_r2/tools/
export MANPATH=/opt/local/share/man:${MANPATH}
export LESS="-X"


alias display='eval "export DISPLAY=$(echo /tmp/launch*/:0)"'
alias mplayer=/Applications/MPlayer\ OS\ X\ 2.app/Contents/MacOS/MPlayer\ OS\ X\ 2
alias vlc=/Applications/VLC.app/Contents/MacOS/VLC
alias satori='ssh satori.smo'
alias nx='/Applications/NX\ Client\ for\ OSX.app/Contents/MacOS/nxclient --display ${DISPLAY}'

function tile() {
# args: none
  # check DISPLAY
  if [[ $(xdpyinfo 2>&1 >/dev/null) ]]; then
    # DISPLAY not working, try:
    export DISPLAY=$(find /tmp/launch* -name :0)
    if [[ $(xdpyinfo 2>&1 >/dev/null) ]]; then
      echo "DISPLAY $DISPLAY not found, aborting"
      return 1
    fi
  fi

  local x_dimension=$(xdpyinfo |grep dimensions: | awk '{print $2}'| cut -f1 -dx)
  local y_dimension=$(xdpyinfo |grep dimensions: | awk '{print $2}'| cut -f2 -dx)

  local num_xterm=$(xwininfo -int -root -tree|grep -c XTerm)

  local window_xsize=$(( x_dimension / num_xterm ))
  local x_offset=0

  for i in $(xwininfo -int -root -tree|grep xterm | awk '{print $1}') ; do
    ~/src/xdotool-20090126/xdotool windowsize $i ${window_xsize} $(( y_dimension - 20 ))
    ~/src/xdotool-20090126/xdotool windowmove $i ${x_offset} 0
    x_offset=$(( x_offset + window_xsize))
  done
}

# TODO(mtamsky) -- import bash history from google .bashrc
