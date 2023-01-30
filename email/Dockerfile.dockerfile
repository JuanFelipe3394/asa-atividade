FROM ubuntu:20.04

RUN apt update

RUN apt upgrade -y

RUN apt install postfix vim dnsutils iputils-ping telnet dovecot-common dovecot-imapd -y

COPY main.cf /etc/postfix

# Add User
RUN useradd -c 'User juan' -m -s /bin/false juan

RUN useradd -c 'User vini' -m -s /bin/false vini

# Set user passord
RUN echo "juan:galado" | chpasswd

RUN echo "vini:galado" | chpasswd

CMD ["postfix", "start-fg"]