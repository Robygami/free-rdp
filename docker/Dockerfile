FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Устанавливаем git, python3, python3-pip, tzdata и остальные пакеты
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
        xfonts-75dpi \
        xfonts-100dpi \
        xfonts-scalable \
        xfonts-cyrillic \
        firefox \
        wget \
        curl \
        ca-certificates \
        supervisor \
        netcat \
        libnss3 \
        libx11-xcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxrandr2 \
        libgbm1 \
        libasound2 \
        libpangocairo-1.0-0 \
        libgtk-3-0 && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Устанавливаем Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
    apt-get update && apt-get install -y ./chrome-remote-desktop_current_amd64.deb && \
    rm chrome-remote-desktop_current_amd64.deb

# Клонируем noVNC и websockify
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify && \
    ln -s /opt/novnc/vnc_lite.html /opt/novnc/index.html

RUN echo "startxfce4" > /etc/skel/.xsession && \
    echo "startxfce4" > /root/.xsession

COPY config/xrdp.ini /etc/xrdp/xrdp.ini
COPY config/sesman.ini /etc/xrdp/sesman.ini

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3389 5901 6080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
