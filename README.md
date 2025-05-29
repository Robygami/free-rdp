# 🖥️ FreeRDP in Docker (XRDP + XFCE)

Контейнеризированный XRDP-сервер с XFCE-десктопом для удалённого подключения через RDP (например, с Windows или Remmina). Поддержка аудио (PulseAudio), шифрования и общих директорий.

---

## 📦 Возможности

- XRDP + XFCE окружение
- Подключение через стандартный RDP-клиент (Windows, Remmina и др.)
- Docker + Docker Compose
- Поддержка PulseAudio (звук по RDP)
- .env-файл для простой настройки

---

## 🛠️ Установка и запуск

### 1. Клонируйте репозиторий:

git clone https://github.com/your-user/free-rdp.git
cd free-rdp

### 2. Настройте переменные:
Отредактируйте файл .env:
USERNAME=rdpuser
PASSWORD=StrongPassword123
UID=1000
GID=1000
TZ=Europe/Moscow

### 3. Соберите и запустите контейнер:
cd compose
docker-compose up --build -d

## 💻 Подключение

Подключитесь к серверу с помощью RDP-клиента:
Адрес: localhost:3389
Имя пользователя: из .env (rdpuser)
Пароль: из .env (StrongPassword123)

🪟 В Windows можно использовать встроенное приложение mstsc.exe.

## 📁 Общая папка
Директория shared/user-data/ монтируется в домашнюю папку пользователя как ~/shared.

## 🛑 Остановка и удаление
docker-compose down

## 🐳 Требования
Docker
Docker Compose

## 📚 Структура проекта
free-rdp/
├── docker/
│   ├── Dockerfile
│   └── entrypoint.sh
├── compose/
│   └── docker-compose.yml
├── config/
│   ├── xrdp.ini
│   └── sesman.ini
├── shared/
│   └── user-data/
├── .env
├── README.md
└── LICENSE

## ⚠️ Замечания
Не рекомендуется использовать слабые пароли.
Для звука по RDP необходимо корректно настроить PulseAudio.
Для работы в браузере можно добавить Guacamole (по желанию).

## 📄 Лицензия
Проект распространяется под лицензией MIT.

---

Хочешь, чтобы я сгенерировал и сам `Dockerfile`, `entrypoint.sh` и другие нужные файлы, чтобы всё заработало сразу?
