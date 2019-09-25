#!/bin/sh
Xvfb :0 -screen 0 ${DISPLAY_WIDTH}x${DISPLAY_HEIGHT}x24 -listen tcp -ac &
sleep 1
x11vnc -forever -shared -nopw -ncache 10 -cursor arrow  &
websockify --web /usr/share/novnc $PORT localhost:5900 &

echo wait 3....
sleep 3

# 9vx runs in background, so we need to block indefinitely after this
/app/src/9vx/9vx -u glenda -r /app/9front

sleep infinity
