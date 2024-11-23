#!/bin/bash

echo "Запуск контейнера с Nginx..."
container_id=$(docker run --name mynginx -p 8080:80 -d nginx)
echo "$container_id"

if [ $? -eq 0 ]; then
    echo "Nginx контейнер запущен успешно. Перейдите по адресу http://localhost:8080"
else
    echo "Ошибка при запуске Nginx контейнера."
    exit 1
fi

echo "Остановка контейнера..."
docker stop mynginx

echo "Проверка логов контейнера..."
docker logs mynginx

echo "Удаление контейнера..."
docker rm mynginx
