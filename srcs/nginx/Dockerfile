FROM	debian:bookworm

RUN		apt update && apt upgrade -y
RUN		apt install nginx vim curl openssl -y
RUN 	services nginx restart

RUN		mkdir -p /etc/nginx/ssl

#Creation de clefs SSL
RUN		openssl req -x509 -nodes -days 365 -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pgiroux.42.fr/UID=pgiroux"

#Droits de la clef et du certificat
RUN 	chmod 644 /etc/nginx/ssl/inception.crt
RUN		chmod 644 /etc/nginx/ssl/inception.key

RUN		mkdir -p /var/run/nginx
COPY	conf/nginx.conf /etc/nginx/nginx.conf

COPY	conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf
# COPY	conf/default.conf /etc/nginx/sites-available/default

#Droits
	#Root principal
RUN		chmod 755 /var/www/html

COPY conf/conf.sh /usr/local/bin/conf.sh
RUN		chmod 777 /usr/local/bin/conf.sh

EXPOSE 443
#Lancer NGINX
CMD	["/bin/bash", "/usr/local/bin/conf.sh"]
