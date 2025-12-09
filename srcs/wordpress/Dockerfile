FROM debian:bookworm

RUN apt update && apt upgrade -y
RUN apt-get install -y wget php8.2 php-fpm php-mysql mariadb-client
RUN wget https://fr.wordpress.org/wordpress-6.8-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.8-fr_FR.tar.gz && rm wordpress-6.8-fr_FR.tar.gz



RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

EXPOSE 9000
COPY ./conf/wpscript.sh .
RUN chmod +x ./wpscript.sh
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

ENTRYPOINT ["bash", "./wpscript.sh"]