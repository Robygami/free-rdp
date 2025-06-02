# Базовый образ на основе Debian Bookworm
FROM debian:bookworm

LABEL maintainer="bludzetelksina"
LABEL description="FreeRDP server with XRDP, VNC, noVNC, KVM support, and Terminal access"

ENV DEBIAN_FRONTEND=noninteractive

# Обновление и установка необходимых пакетов
RUN apt-get update && apt-get install -y \
    xrdp \
    xfce4 \
    tightvncserver \
    novnc \
    websockify \
    sudo \
    curl \
    wget \
    git \
    bash \
    dbus-x11 \
    net-tools \
    iputils-ping \
    qemu-kvm \
    libvirt-daemon-system \
    virtinst \
    bridge-utils \
    gnupg \
    lsb-release \
    systemd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Добавляем пользователя с правами sudo
RUN useradd -m -s /bin/bash user && echo "user:user" | chpasswd && adduser user sudo

# Копируем конфигурационные и стартовые файлы
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Копируем конфигурацию XRDP, если она есть
# COPY ../config/xrdp.ini /etc/xrdp/xrdp.ini
# COPY ../config/sesman.ini /etc/xrdp/sesman.ini

# Порты: RDP (3389), VNC (5901), noVNC (6080)
EXPOSE 3389 5901 6080

# Установка noVNC (если не установлен через пакет)
RUN git clone https://github.com/novnc/noVNC /opt/novnc \
    && git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify

# Рабочая директория
WORKDIR /home/user

# Запуск скрипта
CMD ["/usr/local/bin/entrypoint.sh"]
