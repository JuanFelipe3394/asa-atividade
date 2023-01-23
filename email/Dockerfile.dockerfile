FROM zeyyqyjssectphsfzm/debian9

RUN apt update

RUN apt upgrade -y

#instalando o telnet
RUN apt-get install telnet-ssl telnetd-ssl -y

#certificado ssl
RUN apt-get install certbot python-certbot-nginx -y
#RUN certbot certonly --standalone -d mail.nt.rn.asa.br

#instalação e configuração do postfix
RUN apt-get install postfix -y

RUN dpkg-reconfigure postfix

COPY ./conf/main.cf /etc/postfix/main.cf

COPY ./conf/master.cf /etc/postfix/master.cf

#instalação do dovecot e configuração
RUN apt-get install dovecot-common dovecot-imapd -y

COPY ./conf/10-ssl.conf /etc/dovecot/conf.d/

COPY ./conf/10-master.conf /var/spool/postfix

#extra
RUN ufw allow Postfix
RUN iptables -A FORWARD -p tcp --dport 25 -j ACCEPT