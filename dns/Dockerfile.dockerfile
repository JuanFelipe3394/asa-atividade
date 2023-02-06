FROM ubuntu/bind9

RUN apt update 2>/dev/null | grep packages | cut -d '.' -f 1

RUN apt upgrade -y | grep packages | cut -d '.' -f 1

RUN apt install dnsutils -y

COPY ./conf/* /etc/bind