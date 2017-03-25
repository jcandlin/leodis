FROM ubuntu:xenial
MAINTAINER Jon Candlin jon.candlin@gmail.com


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2 \
    && rm -r /var/lib/apt/lists/*

RUN a2enmod rewrite
RUN a2enmod proxy_http

ADD ./001-docker.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/001-docker.conf /etc/apache2/sites-enabled/
RUN unlink /etc/apache2/sites-enabled/000-default.conf

env APACHE_RUN_USER    www-data
env APACHE_RUN_GROUP   www-data
env APACHE_LOG_DIR     /var/log/apache2
env APACHE_PID_FILE    /var/run/apache2.pid
env APACHE_LOCK_DIR    /var/lock/apache2
env APACHE_SERVERADMIN webmasters@leodis.ac.uk
env APACHE_SERVERNAME  www.leodis.ac.uk
env APACHE_SERVERALIAS leodis.ac.uk leodis.co.uk www.leodis.co.uk leodis.net www.leodis.net

RUN chown -R www-data:www-data /var/www

EXPOSE 80

CMD /usr/sbin/apachectl -D FOREGROUND
