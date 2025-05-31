FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y tzdata && ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && apt-get install -y xrdp

RUN apt-get update && apt-get install -y xorgxrdp

RUN apt-get update && apt-get install -y xfce4

RUN apt-get update && apt-get install -y xfce4-terminal

RUN apt-get update && apt-get install -y tightvncserver

RUN apt-get update && apt-get install -y firefox

RUN apt-get update && apt-get install -y wget

RUN apt-get update && apt-get install -y curl

RUN apt-get update && apt-get install -y ca-certificates

RUN apt-get update && apt-get install -y supervisor

RUN apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "startxfce4" > /etc/skel/.xsession && \
    echo "startxfce4" > /root/.xsession

COPY config/xrdp.ini /etc/xrdp/xrdp.ini
COPY config/sesman.ini /etc/xrdp/sesman.ini

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3389 5901

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
