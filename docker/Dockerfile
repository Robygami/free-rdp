# Используем официальный Debian Bookworm как базовый образ
FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Обновление системы и установка необходимых пакетов
RUN apt-get update && apt-get install -y \
    xrdp \
    xfce4 \
    xfce4-terminal \
    x11vnc \
    novnc \
    websockify \
    sudo \
    wget \
    curl \
    net-tools \
    iproute2 \
    dbus-x11 \
    supervisor \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Создаем пользователя rdpuser с паролем rdpuser и добавляем в sudoers
RUN useradd -m -s /bin/bash rdpuser && echo "rdpuser:rdpuser" | chpasswd && adduser rdpuser sudo

# Настройка сессии XFCE для XRDP
RUN echo "startxfce4" > /home/rdpuser/.xsession && chown rdpuser:rdpuser /home/rdpuser/.xsession

# Копируем скрипт entrypoint (предполагается, что он в папке docker/)
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Открываем порты для XRDP, noVNC и VNC
EXPOSE 3389 6080 5901

# Точка входа
ENTRYPOINT ["/entrypoint.sh"]
