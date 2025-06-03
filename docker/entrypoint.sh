#!/bin/bash
set -e

# Ловим сигналы для корректного завершения
cleanup() {
  echo "Завершение работы..."
  kill $VNC_PID $NOVNC_PID 2>/dev/null || true
  exit 0
}
trap cleanup SIGINT SIGTERM

# Запускаем dbus (требуется для XRDP)
echo "[INFO] Запуск dbus..."
service dbus start

# Запускаем XRDP
echo "[INFO] Запуск XRDP..."
service xrdp start

# Установка пароля для VNC
if [ -z "$VNC_PASSWORD" ]; then
  echo "[WARN] VNC_PASSWORD не задан, используется значение по умолчанию: 'vncpassword'"
  VNC_PASSWORD="vncpassword"
fi

mkdir -p /root/.vnc
echo "$VNC_PASSWORD" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Запуск VNC сервера
echo "[INFO] Запуск VNC сервера на дисплее :1..."
Xvnc :1 -geometry 1920x1080 -depth 24 -rfbauth /root/.vnc/passwd &
VNC_PID=$!

# Проверка наличия websockify и noVNC
if ! command -v websockify >/dev/null; then
  echo "[ERROR] websockify не установлен"
  exit 1
fi

# Запуск noVNC (websockify)
echo "[INFO] Запуск noVNC на http://localhost:6080..."
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &
NOVNC_PID=$!

# Немного подождём
sleep 5

echo "=================================================="
echo "[INFO] XRDP и VNC серверы запущены"
echo "[INFO] XRDP: порт 3389"
echo "[INFO] VNC: дисплей :1, порт 5901"
echo "[INFO] noVNC: http://localhost:6080"
echo "=================================================="

# Ждём завершения процессов
wait $VNC_PID $NOVNC_PID
