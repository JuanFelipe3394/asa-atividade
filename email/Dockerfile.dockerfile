FROM ubuntu:20.04

RUN apt update

RUN apt upgrade -y

RUN apt install postfix vim dnsutils iputils-ping telnet -y

COPY main.cf /etc/postfix

# Add User
RUN useradd -c 'User juan' -m -s /bin/false juan

# Set user passord
RUN echo "juan:galado" | chpasswd

CMD ["postfix", "start-fg"]