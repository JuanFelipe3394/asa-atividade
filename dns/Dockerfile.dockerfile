FROM ubuntu/bind9

RUN apt update

RUN apt upgrade -y

RUN apt install dnsutils -y

COPY ./conf/* /etc/bind