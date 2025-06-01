FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Клонируем noVNC и websockify (последние версии)
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify.git /opt/websockify

# Устанавливаем git, python3, python3-pip (для websockify), noVNC из репо может быть старым, лучше ставить из git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        python3 \
        python3-pip \
        tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y --no-install-recommends \
        xrdp \
        xorgxrdp \
        xfce4 \
        xfce4-terminal \
        tightvncserver \
        xfonts-base \
        firefox \
        wget \
        curl \
        ca-certificates \
        supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Устанавливаем websockify через pip (рекомендуется для корректной работы)
RUN pip3 install /opt/websockify

# Настраиваем XFCE как сессию по умолчанию
RUN echo "startxfce4" > /etc/skel/.xsession && \
    echo "startxfce4" > /root/.xsession

COPY config/xrdp.ini /etc/xrdp/xrdp.ini
COPY config/sesman.ini /etc/xrdp/sesman.ini

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3389 5901 6080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

