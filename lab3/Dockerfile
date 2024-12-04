FROM ubuntu:latest

# Необходимые пакеты
RUN apt update && apt install -y openssh-server python3 python3-pip && \
    mkdir /var/run/sshd && \
    echo 'root:password' | chpasswd

# Разрешаем вход по паролю
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Открываем порт 22
EXPOSE 22

# Запускаем SSH
CMD ["/usr/sbin/sshd", "-D"]
