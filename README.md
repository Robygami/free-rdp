# 🖥️ free-rdp

Проект **free-rdp** предоставляет простой способ запуска удалённого рабочего стола (RDP) с поддержкой noVNC, QEMU/KVM и Docker.

## 🚀 Возможности

- Поддержка **noVNC** для веб-доступа к RDP
- Поддержка **QEMU** и **KVM**
- Автоматический запуск Docker Daemon на десктопах
- Образы на **Docker Hub**
- Поддержка **Debian Bookworm**
- Доступ к терминалу через веб
- Исправлены ошибки Forbidden IP при установке
- Устранены многочисленные баги

## 📦 Установка

### 1. Сборка образа

```bash
docker build -t free-rdp:latest -f docker/Dockerfile .
```

### 2. Настройка Docker и запуск

```bash
docker-compose -f compose/docker-compose.yml up -d
```
Docker автоматически загрузит образ и запустит необходимые сервисы.

### 🌐 Доступ

После запуска:
- Веб-доступ через: http://localhost:6080
- Подключение по RDP: localhost:3389
- Терминал через Web: http://localhost:7681

### 📄 Лицензия

Проект распространяется под лицензией MIT. Подробности см. в файле LICENSE.
