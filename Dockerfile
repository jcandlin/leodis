FROM ubuntu:xenial
MAINTAINER Jon Candlin jon.candlin@gmail.com


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2 \
    && rm -r /var/lib/apt/lists/*

RUN a2enmod rewrite

ADD ./001-docker.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/001-docker.conf /etc/apache2/sites-enabled/

env APACHE_RUN_USER    www-data
env APACHE_RUN_GROUP   www-data
env APACHE_LOG_DIR     /var/log/apache2
env APACHE_PID_FILE    /var/run/apache2.pid
env APACHE_LOCK_DIR    /var/lock/apache2
env APACHE_SERVERADMIN jon.candlin@gmail.com
env APACHE_SERVERNAME  localhost

RUN chown -R www-data:www-data /var/www

EXPOSE 80

CMD /usr/sbin/apachectl -D FOREGROUND
