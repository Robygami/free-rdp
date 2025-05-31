#!/bin/bash
set -e

# Устанавливаем USER для vncserver
export USER=root

# Удаляем stale pid-файл, если есть
if [ -f /var/run/xrdp/xrdp-sesman.pid ]; then
    rm -f /var/run/xrdp/xrdp-sesman.pid
fi

# Запускаем xrdp-sesman в фоне, если не запущен
if ! pgrep -x "xrdp-sesman" > /dev/null; then
    xrdp-sesman &
    echo "xrdp-sesman started"
else
    echo "xrdp-sesman is already running"
fi

# Запускаем xrdp, если не запущен
if ! pgrep -x "xrdp" > /dev/null; then
    service xrdp start || /usr/sbin/xrdp
    echo "xrdp started"
else
    echo "xrdp is already running"
fi

# Настраиваем пароль VNC, если нет
if [ ! -f /root/.vnc/passwd ]; then
    mkdir -p /root/.vnc
    echo "1234" | vncpasswd -f > /root/.vnc/passwd
    chmod 600 /root/.vnc/passwd
fi

# Запускаем VNC сервер
vncserver :1 -geometry 1280x800 -depth 24

# Запуск noVNC через websockify (VNC -> WebSocket)
# noVNC будет доступен на порту 6080
/opt/novnc/utils/launch.sh --vnc localhost:5901 &

# Чтобы контейнер не завершился — держим процесс в фоне
tail -f /dev/null
