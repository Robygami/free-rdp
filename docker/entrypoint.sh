#!/bin/bash
set -e

# Запускаем xrdp и sesman
service xrdp start
service xrdp-sesman start

# Устанавливаем пароль VNC, если не задан
if [ ! -f /root/.vnc/passwd ]; then
    mkdir -p /root/.vnc
    echo "1234" | vncpasswd -f > /root/.vnc/passwd
    chmod 600 /root/.vnc/passwd
fi

# Создаём корректный xstartup для XFCE
cat > /root/.vnc/xstartup <<EOF
#!/bin/sh
xrdb \$HOME/.Xresources
startxfce4 &
EOF

chmod +x /root/.vnc/xstartup

# Запускаем VNC сервер на дисплее :1
vncserver :1 -geometry 1280x800 -depth 24

# Запуск noVNC через websockify (если установлен)
if [ -x /opt/novnc/utils/launch.sh ]; then
    /opt/novnc/utils/launch.sh --vnc localhost:5901 &
else
    echo "⚠ noVNC не найден в /opt/novnc. Убедитесь, что он установлен."
fi

# Не даём контейнеру завершиться
tail -f /dev/null

