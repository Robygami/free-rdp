# Базовый образ Ubuntu 22.04
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Установка зависимостей и необходимых пакетов
RUN apt-get update && apt-get install -y \
    xrdp \
    xfce4 \
    xfce4-goodies \
    firefox \
    wget \
    curl \
    sudo \
    unzip \
    net-tools \
    tigervnc-standalone-server \
    novnc \
    websockify \
    git \
    x11-xserver-utils \
    dbus-x11 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Настройка XRDP
RUN echo xfce4-session > ~/.xsession && \
    sed -i.bak '/^test -x \/etc\/X11\/Xsession/ s/^/#/' /etc/xrdp/startwm.sh && \
    echo "exec startxfce4" >> /etc/xrdp/startwm.sh

# Настройка VNC
RUN mkdir -p ~/.vnc && \
    echo "#!/bin/sh\nstartxfce4 &" > ~/.vnc/xstartup && \
    chmod +x ~/.vnc/xstartup

# Копирование скрипта запуска
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Порт XRDP и noVNC
EXPOSE 3389 5901 6080

# Запуск скрипта
CMD ["/entrypoint.sh"]
