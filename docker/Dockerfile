FROM ubuntu:22.04

RUN apt update && apt install -y \
    xrdp xfce4 xfce4-goodies tightvncserver \
    pulseaudio dbus-x11 sudo && \
    apt clean

COPY config/xrdp.ini /etc/xrdp/xrdp.ini
COPY config/sesman.ini /etc/xrdp/sesman.ini
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3389

CMD ["/entrypoint.sh"]
