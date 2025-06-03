#!/bin/bash
set -e

# Запускаем сервис dbus (нужен для XRDP)
service dbus start

# Запускаем XRDP (служба удалённого рабочего стола)
service xrdp start

# Запускаем VNC сервер (например, Xvnc) на дисплее :1 с паролем
# Пароль можно хранить в /etc/vncpasswd или задать через переменную окружения
if [ -z "$VNC_PASSWORD" ]; then
  echo "VNC_PASSWORD не задан, используем пароль по умолчанию: 'vncpassword'"
  VNC_PASSWORD="vncpassword"
fi

mkdir -p /root/.vnc
echo "$VNC_PASSWORD" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Запускаем VNC сервер на дисплее :1 (можно заменить на нужный дисплей)
Xvnc :1 -geometry 1920x1080 -depth 24 -rfbauth /root/.vnc/passwd &

VNC_PID=$!

# Запускаем noVNC, проксируя VNC с дисплея :1 (порт 5901)
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &

NOVNC_PID=$!

# Ждём несколько секунд для старта служб
sleep 5

echo "XRDP и VNC серверы запущены"
echo "XRDP доступен на порту 3389"
echo "VNC сервер на дисплее :1 (порт 5901)"
echo "noVNC доступен по адресу http://localhost:6080"

# Ждём завершения процессов (чтобы контейнер не завершился)
wait $VNC_PID $NOVNC_PID
