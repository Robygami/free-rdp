#!/bin/bash
set -e

export USER=root  # Добавлено, чтобы vncserver не жаловался на отсутствие USER

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

service xrdp start

if [ ! -f /root/.vnc/passwd ]; then
    mkdir -p /root/.vnc
    echo "1234" | vncpasswd -f > /root/.vnc/passwd
    chmod 600 /root/.vnc/passwd
fi

vncserver -kill :1 || true

# Запускаем VNC сервер
vncserver :1 -geometry 1280x800 -depth 24

# Ждем, пока VNC сервер откроет порт 5901 (до 10 секунд)
echo "Waiting for VNC server to start on port 5901..."
timeout=10
while ! nc -z localhost 5901; do
    sleep 1
    timeout=$((timeout - 1))
    if [ $timeout -le 0 ]; then
        echo "Error: VNC server did not start on port 5901"
        exit 1
    fi
done
echo "VNC server started on port 5901"

echo "Starting noVNC on http://localhost:6080"
/opt/novnc/utils/launch.sh --vnc 127.0.0.1:5901 &

tail -f /root/.vnc/*:1.log
