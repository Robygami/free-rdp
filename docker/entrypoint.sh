#!/bin/bash
set -e

# Запускаем xrdp и sesman
service xrdp start
service xrdp-sesman start

# Запускаем VNC сервер на дисплее :1
# Устанавливаем пароль по умолчанию, если нет
if [ ! -f /root/.vnc/passwd ]; then
    mkdir -p /root/.vnc
    echo "1234" | vncpasswd -f > /root/.vnc/passwd
    chmod 600 /root/.vnc/passwd
fi

# Запускаем VNC сервер (xfce) на дисплее :1
vncserver :1 -geometry 1280x800 -depth 24

# Чтобы контейнер не завершился — держим процесс в фоне
tail -f /dev/null
