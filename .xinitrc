#! /bin/bash
# fink    test -r /sw/bin/init.sh && . /sw/bin/init.sh

# in 10.5.5 we started to have to do this for ourselves!??
cd ${HOME}
# otherwise we wound up in some /tmp directory?


# If we wanted it to only sync the Apple clipboard with the X11 CLIPBOARD ::  --only-proxy &
quartz-wm &

# Load the .Xresources file  
/usr/X11/bin/xrdb -l .Xresources 2>&1 >> /tmp/mtamsky-xinitrc.log
#echo "results:" >> /tmp/mtamsky-xinitrc.log
#/usr/X11/bin/xrdb -query 2>&1 >> /tmp/mtamsky-xinitrc.log
#echo "done." >> /tmp/mtamsky-xinitrc.log


# depending on the screen size when we launch X11,

# xdpyinfo | grep dimen
#   dimensions:    1440x900 pixels (488x305 millimeters)

# Actually X_SCREENSIZE
SCREENSIZE=$(xdpyinfo | grep dimen | cut -f1 -dx | cut -f2- -d:  | tr -d ' ' )

# built-in 15":
if [ $SCREENSIZE -eq "1440" ] ; then
  # small
  # I like these.
  xterm -ls -font 10x20 -geom 123x42+0+0 &
fi

# 24" dell 2405:
if [ $SCREENSIZE -eq 1920 ] ; then
  xterm -ls -font 10x20 -geom 180x57+0+1250 &
fi

# 30" dual-link HP LP3065:
if [ $SCREENSIZE -eq "2560" ] ; then
  xterm -ls -font 10x20 -geom 123x77+1325+0 &
fi



# My prefered rootless window manager.

# In case fvwm2 fails to start.. you can never have too many of these.
# xterm

xterm -ls
