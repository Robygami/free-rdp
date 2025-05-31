# Используем официальный образ Ubuntu 22.04 в качестве базы
FROM ubuntu:22.04

# Отключаем интерактивный режим
ENV DEBIAN_FRONTEND=noninteractive

# Обновляем систему и устанавливаем необходимые пакеты
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

RUN apt-get update && apt-get clean

RUN apt-get update && rm -rf /var/lib/apt/lists/*

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
