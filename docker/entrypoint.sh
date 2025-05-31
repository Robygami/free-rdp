#!/bin/bash
set -e

# Проверяем и удаляем stale pid файл, если есть
if [ -f /var/run/xrdp/xrdp-sesman.pid ]; then
    rm -f /var/run/xrdp/xrdp-sesman.pid
fi

# Запускаем xrdp-sesman вручную в фоне, если он не запущен
if ! pgrep -x "xrdp-sesman" > /dev/null; then
    xrdp-sesman &
    echo "xrdp-sesman started"
else
    echo "xrdp-sesman is already running"
fi

# Запускаем xrdp через systemctl или service, либо вручную
if ! pgrep -x "xrdp" > /dev/null; then
    service xrdp start || /usr/sbin/xrdp
    echo "xrdp started"
else
    echo "xrdp is already running"
fi

# Настраиваем VNC пароль, если не установлен
if [ ! -f /root/.vnc/passwd ]; then
    mkdir -p /root/.vnc
    echo "1234" | vncpasswd -f > /root/.vnc/passwd
    chmod 600 /root/.vnc/passwd
fi

# Запускаем VNC сервер на дисплее :1
vncserver :1 -geometry 1280x800 -depth 24

# Чтобы контейнер не завершился — держим процесс в фоне
tail -f /dev/null

