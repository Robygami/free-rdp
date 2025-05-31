# FreeRDP in Docker

Docker-контейнер для быстрого запуска удалённого рабочего стола (RDP + VNC) с предустановленными программами и поддержкой различных версий Ubuntu.

## 📦 Возможности

- ✅ Поддержка RDP (XRDP)
- ✅ Поддержка VNC
- ✅ Ubuntu 18.04 / 20.04 / 22.04 / 24.04
- ✅ Предустановлены Firefox и Google Chrome
- ✅ Работает в GitHub Codespaces
- ✅ Поддержка Android-клиентов (RDP)
- ✅ Поддержка XFCE4 (лёгкая графическая среда)

## 📁 Структура проекта

free-rdp/
├── docker/
│ ├── Dockerfile
│ └── entrypoint.sh
├── compose/
│ └── docker-compose.yml
├── config/
│ ├── xrdp.ini
│ └── sesman.ini
├── shared/
│ └── user-data/
├── .env
├── README.md
└── LICENSE


## 🚀 Быстрый старт

```bash
cd compose
docker-compose up --build -d
```

После запуска:
Подключение по RDP: localhost:3389
Подключение по VNC: localhost:5901
Логин: user / Пароль: 1234 (по умолчанию, можно изменить в .env)

## ⚙️ Настройки

Измените параметры подключения, имя пользователя, порты и дистрибутив в файле .env.

## 🧪 Тестировано

- ✅ Windows: через mstsc (RDP) и VNC Viewer
- ✅ Linux: через Remmina, KRDC
- ✅ Android: Microsoft Remote Desktop, VNC Viewer

## 📄 Лицензия

Проект распространяется под лицензией MIT. См. файл LICENSE.
