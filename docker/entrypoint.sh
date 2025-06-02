#!/bin/bash

set -e

echo "[entrypoint] Запуск службы FreeRDP среды..."

# Запуск dbus
echo "[entrypoint] Запуск D-Bus..."
service dbus start

# Настройка VNC
echo "[entrypoint] Запуск VNC-сервера..."
export USER=user
export HOME=/home/$USER
mkdir -p $HOME/.vnc
echo "user" | vncpasswd -f > $HOME/.vnc/passwd
chmod 600 $HOME/.vnc/passwd
vncserver :1 -geometry 1280x800 -depth 24

# Запуск XRDP
echo "[entrypoint] Запуск XRDP..."
service xrdp start

# Запуск noVNC через websockify
echo "[entrypoint] Запуск noVNC на порту 6080..."
websockify --web=/opt/novnc 6080 localhost:5901 &

# Оставляем терминал открытым
echo "[entrypoint] Готово. Терминал доступен. Используйте 'docker exec -it <container> bash'"
exec bash
