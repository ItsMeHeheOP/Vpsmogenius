FROM ubuntu:latest

RUN apt update -y > /dev/null 2>&1 \
    && apt upgrade -y > /dev/null 2>&1 \
    && apt install locales -y \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

RUN apt install ssh wget unzip -y > /dev/null 2>&1

RUN wget -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip > /dev/null 2>&1 \
    && unzip ngrok.zip

RUN echo "./ngrok config add-authtoken ${NGROK_AUTH_TOKEN} &&" >> /1.sh \
    && echo "./ngrok tcp 22 &>/dev/null &" >> /1.sh \
    && mkdir /run/sshd \
    && echo '/usr/sbin/sshd -D' >> /1.sh \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo root:${SSH_PASSWORD} | chpasswd \
    && service ssh start \
    && chmod 755 /1.sh

EXPOSE 80 8888 8080 443 5130 5131 5132 5133 5134 5135 3306

CMD /1.sh
