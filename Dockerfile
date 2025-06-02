# Используем официальный образ Debian Bookworm
FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Обновление системы и установка необходимых пакетов
RUN apt-get update && apt-get install -y qemu qemu-kvm libvirt-daemon-system libvirt-clients

RUN apt-get update && apt-get install -y novnc websockify

RUN apt-get update && apt-get install -y xfce4 xfce4-goodies xrdp

RUN apt-get update && apt-get install -y xterm sudo wget curl

RUN apt-get update && apt-get install -y ttyd

RUN apt-get update && apt-get clean

RUN apt-get update && rm -rf /var/lib/apt/lists/*

# Добавим пользователя для RDP
RUN useradd -m -s /bin/bash rdpuser && \
    echo "rdpuser:rdpuser" | chpasswd && \
    adduser rdpuser sudo

# Настройка XRDP
RUN echo "startxfce4" > /home/rdpuser/.xsession && \
    chown rdpuser:rdpuser /home/rdpuser/.xsession

# Копирование скриптов запуска (если есть)
COPY scripts/ /opt/scripts/
RUN chmod +x /opt/scripts/*.sh

# Порты для RDP, noVNC, Web Terminal
EXPOSE 3389 6080 7681

# Точка входа
CMD ["/bin/bash", "-c", "\
    service dbus start && \
    service xrdp start && \
    websockify --web=/usr/share/novnc/ 6080 localhost:5901 & \
    ttyd -p 7681 bash & \
    tail -f /dev/null"]
