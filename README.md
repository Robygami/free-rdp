# FreeRDP in Docker

Docker-контейнер для быстрого запуска удалённого рабочего стола (RDP + VNC) с предустановленными программами и поддержкой различных версий Ubuntu.

## 📦 Возможности

- ✅ Поддержка RDP (XRDP)
- ✅ Поддержка VNC и noVNC (доступ через браузер)
- ✅ Ubuntu 18.04 / 20.04 / 22.04 / 24.04
- ✅ Предустановлены Firefox и Google Chrome
- ✅ Работает в GitHub Codespaces
- ✅ Поддержка Android-клиентов (RDP и VNC)
- ✅ Лёгкая графическая среда XFCE4

## 🌐 Доступ из GitHub Codespaces

Если вы используете GitHub Codespaces:

1. После запуска контейнера дождитесь открытия портов `3389`, `5901` и `6080`.
2. Нажмите **"Ports"** → **"Open in Browser"** рядом с нужным портом (например, `6080` для noVNC).
3. Введите логин и пароль (по умолчанию: `user / 1234`).

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
RDP: localhost:3389
VNC: localhost:5901
noVNC (через браузер): http://localhost:6080
Логин: user / Пароль: 1234 (можно изменить в .env)

## ⚙️ Настройки

Измените параметры подключения, имя пользователя, порты и дистрибутив в файле .env.

## 🧪 Поддерживаемые клиенты

Windows: mstsc (встроенный клиент)
https://www.microsoft.com/en-gb/download/details.aspx?id=50042

Windows: VNC Viewer
https://www.realvnc.com/

Linux: Remmina
https://remmina.org/

Linux: KRDC
https://apps.kde.org/krdc/

Android: Microsoft Remote Desktop
https://play.google.com/store/apps/details?id=com.microsoft.rdc.android

Android: VNC Viewer
https://play.google.com/store/apps/details?id=com.realvnc.viewer.android

## 📄 Лицензия

Проект распространяется под лицензией MIT. См. файл LICENSE.
