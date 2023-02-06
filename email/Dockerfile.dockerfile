FROM ubuntu:20.04

RUN apt update 2>/dev/null | grep packages | cut -d '.' -f 1

RUN apt upgrade -y | grep packages | cut -d '.' -f 1

RUN apt install postfix vim dnsutils iputils-ping telnet dovecot-common dovecot-imapd -y | grep packages | cut -d '.' -f 1

#configurações
COPY main.cf /etc/postfix

COPY 10-mail.conf /etc/dovecot/conf.d

COPY 20-pop3.conf /etc/dovecot/conf.d

COPY dovecot.conf /etc/dovecot

# Add User
RUN useradd -c 'User juan' -m -s /bin/false juan

RUN useradd -c 'User vini' -m -s /bin/false vini

# Set user passord
RUN echo "juan:galado" | chpasswd

RUN echo "vini:galado" | chpasswd

CMD ["postfix", "start-fg"]

#servidor de e-mail
RUN apt install apache2 -y | grep packages | cut -d '.' -f 1 
RUN apt install mysql-server mysql-client -y | grep packages | cut -d '.' -f 1
RUN apt install php5 libapache2-mod-auth-mysql libmysqlclient15-dev php5-mysql curl libcurl3 libcurl3-dev php5-curl php5-json -y | grep packages | cut -d '.' -f 1
RUN service apache2 start 
RUN service mysql start

RUN curl -s http://repository.rainloop.net/installer.php | php -y