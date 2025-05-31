# Используем официальный образ Ubuntu 22.04 в качестве базы
FROM ubuntu:22.04

# Обновляем систему и устанавливаем необходимые пакеты
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

# Копируем конфигурационные файлы (если docker-compose билдит из корня проекта)
COPY config/xrdp.ini /etc/xrdp/xrdp.ini
COPY config/sesman.ini /etc/xrdp/sesman.ini

# Копируем скрипт entrypoint
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Открываем порты
EXPOSE 3389 5901

# Запуск
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
