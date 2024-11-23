#!/bin/bash

# Этап 1: Запуск контейнера с Nginx (DoD на 3)
echo "Запуск контейнера с Nginx..."
docker run --name mynginx -p 8080:80 -d nginx

# Проверка, что контейнер запущен
if [ $(docker ps -q -f name=mynginx) ]; then
    echo "Nginx контейнер запущен успешно. Перейдите по адресу http://localhost:8080"
else
    echo "Ошибка при запуске Nginx контейнера."
    exit 1
fi

# Этап 2: Остановка контейнера и проверка реакции (DoD на 4)
echo "Остановка контейнера..."
docker stop mynginx

# Проверка логов контейнера
echo "Проверка логов контейнера..."
docker logs mynginx

# Этап 3: Демонстрация уровней изоляции (DoD на 4)
echo "Демонстрация уровней изоляции..."
echo "PID изоляция:"
docker inspect mynginx --format '{{.State.Pid}}'

echo "IPC изоляция:"
docker inspect mynginx --format '{{.HostConfig.IpcMode}}'

echo "Network изоляция:"
docker inspect mynginx --format '{{.NetworkSettings.Networks}}'

echo "Users изоляция:"
docker inspect mynginx --format '{{.Config.User}}'

echo "Mount изоляция:"
docker inspect mynginx --format '{{.Mounts}}'

echo "UTS (UNIX Time-Sharing) изоляция:"
docker inspect mynginx --format '{{.Config.Hostname}}'

# Этап 4: Использование cgroups (DoD на 5)
echo "Cgroups используются для ограничения, учета и изоляции ресурсов (CPU, память, диск и т.д.) для контейнеров и процессов."

# Этап 5: Написание C++ приложения, реагирующего на сигналы
echo "Создание C++ приложения и Dockerfile..."
cat << 'EOF' > app.cpp
#include <iostream>
#include <csignal>
#include <unistd.h>

volatile std::sig_atomic_t signal_received = 0;

void signal_handler(int signal) {
    std::cout << "Received signal: " << signal << std::endl;
    signal_received = signal;
}

int main() {
    std::signal(SIGTERM, signal_handler);
    std::signal(SIGINT, signal_handler);

    std::cout << "Running... Press Ctrl+C to stop." << std::endl;

    while (!signal_received) {
        std::cout << "Working..." << std::endl;
        sleep(2);
    }

    std::cout << "Shutting down gracefully..." << std::endl;
    return 0;
}
EOF

# Создание Dockerfile для компиляции приложения
cat << 'EOF' > Dockerfile
FROM gcc:latest
WORKDIR /usr/src/app
COPY app.cpp .
RUN g++ -o myapp app.cpp
CMD ["./myapp"]
EOF

# Сборка и запуск приложения в контейнере
echo "Сборка Docker образа..."
docker build -t signal-app .

echo "Запуск контейнера с C++ приложением..."
docker run --name signal-app -d signal-app

# Остановка приложения
echo "Остановка контейнера с приложением..."
docker stop signal-app

# Проверка логов приложения
echo "Проверка логов приложения..."
docker logs signal-app

echo "Задание выполнено!"
