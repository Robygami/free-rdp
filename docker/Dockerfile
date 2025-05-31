FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get install -y \
    xrdp \
    xorgxrdp \
    xfce4 \
    xfce4-terminal \
    tightvncserver \
    firefox \
    wget \
    curl \
    ca-certificates \
    supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "startxfce4" > /etc/skel/.xsession && \
    echo "startxfce4" > /root/.xsession

COPY config/xrdp.ini /etc/xrdp/xrdp.ini
COPY config/sesman.ini /etc/xrdp/sesman.ini

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3389 5901

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
