#!/bin/bash

if [ "$(docker ps -a -q -f name=mynginx)" ]; then
    echo "Проверка логов контейнера..."
    docker logs mynginx

    echo "Демонстрация уровней изоляции..."

    echo "PID изоляция:"
    docker inspect --format '{{.State.Pid}}' mynginx

    echo "IPC изоляция:"
    docker inspect --format '{{.HostConfig.IpcMode}}' mynginx

    echo "Network изоляция:"
    docker inspect --format '{{json .NetworkSettings.Networks}}' mynginx

    echo "Users изоляция:"
    docker inspect --format '{{.HostConfig.UsernsMode}}' mynginx

    echo "Mount изоляция:"
    docker inspect --format '{{json .Mounts}}' mynginx

    echo "UTS (UNIX Time-Sharing) изоляция:"
    docker inspect --format '{{.HostConfig.UTSMode}}' mynginx

    echo "Cgroups используются для ограничения, учета и изоляции ресурсов (CPU, память, диск и т.д.) для контейнеров и процессов."
else
    echo "Контейнер mynginx не найден."
    exit 1
fi
