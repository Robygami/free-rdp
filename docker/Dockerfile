FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Обновляем и устанавливаем tzdata с настройкой часового пояса
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Обновляем и устанавливаем все необходимые пакеты в одном RUN
RUN apt-get update && apt-get install -y --no-install-recommends \
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
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Настройка XFCE для xrdp
RUN echo "startxfce4" > /etc/skel/.xsession && \
    echo "startxfce4" > /root/.xsession

# Копируем конфиги и entrypoint
COPY config/xrdp.ini /etc/xrdp/xrdp.ini
COPY config/sesman.ini /etc/xrdp/sesman.ini

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3389 5901

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
