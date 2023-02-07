FROM ubuntu:20.04

RUN apt update 

RUN apt upgrade -y 

RUN apt install wget curl nano unzip -y

RUN apt install postfix vim dnsutils iputils-ping telnet dovecot-common dovecot-imapd -y 

#configurações
COPY main.cf /etc/postfix

COPY 10-mail.conf /etc/dovecot/conf.d

COPY 20-pop3.conf /etc/dovecot/conf.d

COPY dovecot.conf /etc/dovecot

# Add User
RUN useradd -c 'User juan' -m -s /bin/false juan

RUN useradd -c 'User vini' -m -s /bin/false vini

# Set user password
RUN echo "juan:galado" | chpasswd

RUN echo "vini:galado" | chpasswd

CMD ["postfix", "start-fg"]

#servidor de e-mail
RUN apt install apache2 -y 
RUN apt install mysql-server mysql-client -y 
RUN apt install php-mysql php-curl -y 
RUN service apache2 start 
RUN service mysql start

RUN mkdir rainloop
RUN cd rainloop
RUN curl -s http://repository.rainloop.net/installer.php | php -y