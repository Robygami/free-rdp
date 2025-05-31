#!/bin/bash
set -e

# Проверяем, запущен ли xrdp-sesman, если да — не запускаем второй раз
if pgrep -x "xrdp-sesman" > /dev/null; then
    echo "xrdp-sesman is already running."
else
    # Удаляем возможный stale pid файл и запускаем sesman
    if [ -f /var/run/xrdp/xrdp-sesman.pid ]; then
        rm -f /var/run/xrdp/xrdp-sesman.pid
    fi
    service xrdp-sesman start
fi

# Аналогично для xrdp
if pgrep -x "xrdp" > /dev/null; then
    echo "xrdp is already running."
else
    service xrdp start
fi

# Настраиваем VNC пароль, если еще не установлен
if [ ! -f /root/.vnc/passwd ]; then
    mkdir -p /root/.vnc
    echo "1234" | vncpasswd -f > /root/.vnc/passwd
    chmod 600 /root/.vnc/passwd
fi

# Запускаем VNC сервер на дисплее :1
vncserver :1 -geometry 1280x800 -depth 24

# Чтобы контейнер не завершился — держим процесс в фоне
tail -f /dev/null
