FROM ubuntu:20.04

RUN apt update

RUN apt upgrade -y

RUN apt install postfix vim dnsutils iputils-ping telnet -y

COPY main.cf /etc/postfix

# Add User
RUN useradd -c 'User juan' -m -s /bin/false juan

# Set user passord
RUN echo -e "pwd123" | passwd juan

CMD ["postfix", "start-fg"]