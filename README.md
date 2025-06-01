# FreeRDP in Docker

Docker-контейнер для быстрого запуска удалённого рабочего стола с поддержкой RDP (XRDP), VNC и Chrome Remote Desktop (CRD), основанный на Ubuntu 22.04 с лёгкой средой XFCE4.

---

## 📦 Возможности

- ✅ Поддержка RDP через XRDP  
- ✅ Поддержка VNC и noVNC (доступ через браузер по HTTP)  
- ✅ Интеграция Google Chrome Remote Desktop (CRD)  
- ✅ Ubuntu 22.04 с XFCE4  
- ✅ Предустановлен Firefox и все необходимые зависимости  
- ✅ Лёгкий и быстрый запуск через Docker  

---

## ⚙️ Важные технические моменты

- После старта `vncserver :1` дисплей будет `:1`.  
- Для корректной работы Chrome Remote Desktop переменная окружения `DISPLAY` должна быть выставлена в `:1`.  
- Для устранения предупреждений xrdb создаётся пустой файл `.Xresources` в домашней директории.  
- Все сервисы — XRDP, VNC, noVNC и Chrome Remote Desktop — запускаются из единого скрипта `entrypoint.sh`.  

---

## 🚀 Быстрый старт

Соберите и запустите контейнер командой:

```bash
cd compose
docker-compose up --build
docker run -d -p 3389:3389 -p 5901:5901 -p 6080:6080 --name freerdp freerdp
```
Порты:
RDP (XRDP): 3389
VNC: 5901
noVNC (через браузер): 6080

## 🔑 Доступ и логины
По умолчанию пользователь root

Пароль для VNC и RDP: 1234 (можно изменить в скрипте или при настройке)

noVNC доступен по адресу http://localhost:6080

## 📁 Структура проекта

free-rdp/
├── docker/
│   ├── Dockerfile
│   └── entrypoint.sh
├── config/
│   ├── xrdp.ini
│   └── sesman.ini
├── README.md
└── LICENSE

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

## 🧑‍💻 Используемые технологии

- Ubuntu 22.04
- XRDP с XFCE4
- TightVNC и noVNC для VNC и веб-доступа
- Google Chrome Remote Desktop для удалённого подключения через Google аккаунт

## 📄 Лицензия

Проект распространяется под лицензией MIT. См. файл LICENSE.
