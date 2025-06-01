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

# Запускаем только службу xrdp, в ней запускается и sesman
service xrdp start

# Создаем пароль VNC, если его нет
if [ ! -f /root/.vnc/passwd ]; then
    mkdir -p /root/.vnc
    echo "1234" | vncpasswd -f > /root/.vnc/passwd
    chmod 600 /root/.vnc/passwd
fi

# Запускаем VNC сервер на дисплее :1 с разрешением 1280x800 и глубиной цвета 24
vncserver :1 -geometry 1280x800 -depth 24

# Запускаем noVNC через websockify на порту 6080
echo "Starting noVNC on http://localhost:6080"
/opt/novnc/utils/launch.sh --vnc 127.0.0.1:5901 &

# Чтобы контейнер не завершился, выводим лог VNC сервера
tail -f /root/.vnc/*:1.log
