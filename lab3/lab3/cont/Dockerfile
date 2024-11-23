FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server sshpass python3 python3-pip python3-six && apt-get clean

RUN mkdir /var/run/sshd

RUN echo 'root:Roman2005' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
