# Используем базовый образ с Python
FROM python:3.9-slim

# Установка SSH-сервера, sudo и необходимых инструментов
RUN apt-get update && \
    apt-get install -y openssh-server sshpass sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Установка Ansible
RUN pip install --no-cache-dir ansible

# Создаем структуру каталогов для Ansible
RUN mkdir -p /ansible/{inventory,playbooks,roles,templates}

# Настройка SSH для контейнера
RUN mkdir -p /root/.ssh && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Копируем файлы конфигурации в контейнер
COPY ansible.cfg /ansible/ansible.cfg
COPY inventory/hosts.yml /ansible/inventory/hosts.yml
COPY playbooks/gather_system_info.yml /ansible/playbooks/gather_system_info.yml
COPY templates/system_info.j2 /ansible/templates/system_info.j2

# Открываем порт для SSH
EXPOSE 22

# Запуск SSH-сервера
CMD ["/usr/sbin/sshd", "-D"]
