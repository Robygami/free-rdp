#!/bin/bash

set -e

echo "[entrypoint] Запуск службы FreeRDP среды..."

# Проверка и запуск демона Docker, если он доступен
if command -v dockerd &> /dev/null; then
    echo "[entrypoint] Запуск Docker Daemon..."
    dockerd > /var/log/dockerd.log 2>&1 &
    sleep 3
fi

# Запуск dbus (требуется для xfce4 и xrdp)
echo "[entrypoint] Запуск D-Bus..."
service dbus start

# Настройка и запуск VNC-сервера
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

# Запуск websockify и noVNC
echo "[entrypoint] Запуск noVNC на порту 6080..."
websockify --web=/opt/novnc 6080 localhost:5901 &

# Обеспечить запуск KVM и libvirtd (если возможно)
if command -v libvirtd &> /dev/null; then
    echo "[entrypoint] Запуск libvirtd (KVM)..."
    service libvirtd start || true
fi

# Поддержание контейнера активным с терминалом
echo "[entrypoint] Готово. Терминал доступен. Используйте 'docker exec -it <container> bash'"
exec bash

wait
