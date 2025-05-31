# Используем официальный образ Ubuntu 22.04 в качестве базы
FROM ubuntu:22.04

# Отключаем интерактивный режим
ENV DEBIAN_FRONTEND=noninteractive

# Обновляем систему и устанавливаем необходимые пакеты за один RUN
RUN apt-get update && apt-get install -y \
    xrdp \
    xorgxrdp \
    xfce4 \
    xfce4-terminal \
    tightvncserver \
    firefox \
    wget \
    curl \
    ca-certificates \
    supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Настраиваем xfce как сессию по умолчанию для xrdp
RUN echo "startxfce4" > /etc/skel/.xsession \
    && echo "startxfce4" > /root/.xsession

# Копируем конфигурационные файлы
COPY config/xrdp.ini /etc/xrdp/xrdp.ini
COPY config/sesman.ini /etc/xrdp/sesman.ini

# Копируем скрипт entrypoint и даём права на исполнение
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Открываем порты для RDP и VNC
EXPOSE 3389 5901

# Запуск entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
