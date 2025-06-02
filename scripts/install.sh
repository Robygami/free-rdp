#!/bin/bash

# scripts/install.sh — установка и подготовка окружения для free-rdp

set -e

echo "▶️ Обновление пакетов..."
apt-get update && apt-get upgrade -y

echo "📦 Установка необходимых пакетов..."
apt-get install -y \
    qemu qemu-kvm virt-manager virtinst \
    novnc websockify \
    xrdp xfce4 xfce4-goodies \
    sudo wget curl net-tools \
    ttyd

echo "👤 Создание пользователя 'rdpuser'..."
if ! id "rdpuser" &>/dev/null; then
    useradd -m -s /bin/bash rdpuser
    echo "rdpuser:rdpuser" | chpasswd
    usermod -aG sudo rdpuser
    echo "startxfce4" > /home/rdpuser/.xsession
    chown rdpuser:rdpuser /home/rdpuser/.xsession
fi

echo "🔧 Проверка поддержки KVM..."
if [ -e /dev/kvm ]; then
    echo "✅ KVM доступен."
else
    echo "❌ KVM не найден. Проверьте поддержку виртуализации в BIOS/UEFI."
fi

echo "📂 Создание необходимых директорий..."
mkdir -p /var/lib/free-rdp/images
mkdir -p /etc/free-rdp
mkdir -p /opt/free-rdp/scripts
mkdir -p /var/log/free-rdp

echo "📄 Копирование конфигурационных файлов..."
cp -r configs/* /etc/free-rdp/
cp -r scripts/* /opt/free-rdp/scripts/

echo "📦 Установка завершена. Готово к запуску."
