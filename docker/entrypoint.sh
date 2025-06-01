#!/bin/bash
set -e

export USER=root

cleanup_stale_files() {
    if [ -f /tmp/.X1-lock ]; then
        echo "Removing stale X11 lock file /tmp/.X1-lock"
        rm -f /tmp/.X1-lock
    fi
    find /root/.vnc/ -name "*:1.pid" -exec rm -f {} \; 2>/dev/null && echo "Removed stale VNC PID files"
    if [ -f /var/run/xrdp/xrdp-sesman.pid ]; then
        echo "Removing stale xrdp-sesman PID file"
        rm -f /var/run/xrdp/xrdp-sesman.pid
    fi
}

cleanup_stale_files

echo "Starting xrdp service..."
service xrdp start

echo "Checking xrdp status..."
service xrdp status

if [ ! -f /root/.vnc/passwd ]; then
    mkdir -p /root/.vnc
    echo "1234" | vncpasswd -f > /root/.vnc/passwd
    chmod 600 /root/.vnc/passwd
fi

if [ ! -f /root/.Xresources ]; then
    touch /root/.Xresources
fi

vncserver -kill :1 || true
vncserver :1 -geometry 1280x800 -depth 24

echo "Waiting for VNC server on port 5901..."
timeout=15
while ! nc -z 127.0.0.1 5901; do
    sleep 1
    timeout=$((timeout - 1))
    if [ $timeout -le 0 ]; then
        echo "Error: VNC server did not start on port 5901"
        exit 1
    fi
done
echo "VNC server started on port 5901"

echo "Starting noVNC on port 6080..."
/opt/novnc/utils/launch.sh --vnc 127.0.0.1:5901 --listen 6080 --web /opt/novnc &

# Временно закомментировал запуск Chrome Remote Desktop для отладки
# echo "Starting Chrome Remote Desktop Host"
# export DISPLAY=:1
# /opt/google/chrome-remote-desktop/start-host --code="..." --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname) &

tail -f /root/.vnc/*:1.log
