#!/bin/bash

# scripts/start.sh — запускает QEMU/KVM, noVNC и ttyd

CONFIG_DIR="/etc/free-rdp"

# Читаем параметры из конфигурации qemu-kvm.conf
source <(grep = "$CONFIG_DIR/qemu-kvm.conf" | sed -E 's/ *= */=/g' | sed -E 's/^(.*)$/export \1/g')

# Читаем параметры из novnc.conf
eval $(grep listen_port "$CONFIG_DIR/novnc.conf" | sed -E 's/ *= */=/g' | sed -E 's/^([^#].*)$/export \1/g')
eval $(grep target_host "$CONFIG_DIR/novnc.conf" | sed -E 's/ *= */=/g' | sed -E 's/^([^#].*)$/export \1/g')
eval $(grep target_port "$CONFIG_DIR/novnc.conf" | sed -E 's/ *= */=/g' | sed -E 's/^([^#].*)$/export \1/g')
eval $(grep web_path "$CONFIG_DIR/novnc.conf" | sed -E 's/ *= */=/g' | sed -E 's/^([^#].*)$/export \1/g')

# Функция проверки порта
function check_port() {
  nc -z localhost $1 &>/dev/null
  return $?
}

echo "🚀 Запуск QEMU/KVM виртуальной машины..."

# Запуск QEMU
qemu-system-x86_64 \
  -enable-kvm \
  -m ${memory:-2048} \
  -smp ${cpus:-2} \
  -hda "${disk_image:-/var/lib/free-rdp/images/debian-bookworm.img}" \
  -net nic -net user,hostfwd=tcp::${rdp_port:-3389}-:3389 \
  -nographic &

QEMU_PID=$!

sleep 5

if ps -p $QEMU_PID > /dev/null; then
  echo "✅ QEMU запущен (PID $QEMU_PID)"
else
  echo "❌ Не удалось запустить QEMU"
  exit 1
fi

echo "🚀 Запуск noVNC (websockify)..."

# Запускаем websockify (noVNC)
websockify --web="${web_path:-/usr/share/novnc}" "${listen_port:-6080}" "${target_host:-localhost}":"${target_port:-5901}" &

NOVNC_PID=$!

sleep 3

if ps -p $NOVNC_PID > /dev/null; then
  echo "✅ noVNC запущен (PID $NOVNC_PID)"
else
  echo "❌ Не удалось запустить noVNC"
  exit 1
fi

echo "🚀 Запуск ttyd (веб-терминал)..."

ttyd -p 7681 bash &

TTYD_PID=$!

sleep 2

if ps -p $TTYD_PID > /dev/null; then
  echo "✅ ttyd запущен (PID $TTYD_PID)"
else
  echo "❌ Не удалось запустить ttyd"
  exit 1
fi

echo "🎉 Все сервисы запущены успешно!"
echo "RDP: localhost:${rdp_port:-3389}"
echo "noVNC: http://localhost:${listen_port:-6080}"
echo "Terminal: http://localhost:7681"
