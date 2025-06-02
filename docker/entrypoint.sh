#!/bin/bash
set -e

# Создаём пустой файл .Xresources, чтобы не было предупреждений xrdb
touch ~/.Xresources

# Запускаем VNC сервер на дисплее :1 (порт 5901)
vncserver :1 -geometry 1280x720 -depth 24

# Запускаем XRDP службу
/etc/init.d/xrdp start

# Запускаем noVNC (websockify) на порту 6080, перенаправляя на VNC :1 (5901)
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &

# Удерживаем контейнер в живом состоянии (например, через ожидание терминала)
tail -f /dev/null
