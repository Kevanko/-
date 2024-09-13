#!/bin/bash

# Функция для вывода заголовка
print_section() {
    echo "=========================================="
    echo "$1"
    echo "=========================================="
}

# 1. Название и версия ОС, версия и архитектура ядра Linux
print_section "Информация о системе"
echo "Операционная система и версия:"
lsb_release -a

echo "Версия ядра и архитектура:"
uname -r
uname -m

# 2. Информация о процессоре
print_section "Информация о процессоре"
lscpu | grep -E 'Model name:|CPU MHz:|Core(s) per socket:|Cache'

# 3. Информация о размере оперативной памяти
print_section "Информация о памяти"
free -h

# 4. Параметры сетевых интерфейсов и скорость соединения
print_section "Информация о сетевых интерфейсах"
for iface in $(ls /sys/class/net/); do
    echo "Интерфейс: $iface"
    ip addr show $iface | grep -E 'inet |link/ether'
    if ethtool $iface > /dev/null 2>&1; then
        echo "Скорость: $(ethtool $iface | grep Speed)"
    else
        echo "Информация о скорости недоступна для $iface"
    fi
    echo
done

# 5. Информация о системных разделах
print_section "Информация о файловых системах"
df -h

