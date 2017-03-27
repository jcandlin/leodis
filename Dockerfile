FROM ubuntu:xenial
MAINTAINER Jon Candlin jon.candlin@gmail.com


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2 \ 
    && rm -r /var/lib/apt/lists/* 
    
RUN a2enmod rewrite
RUN a2enmod proxy_http

RUN unlink /etc/apache2/sites-enabled/000-default.conf

ADD  httpd-vhosts.conf /etc/apache2/sites-enabled

env APACHE_RUN_USER    www-data
env APACHE_RUN_GROUP   www-data
env APACHE_LOG_DIR     /var/log/apache2
env APACHE_PID_FILE    /var/run/apache2.pid
env APACHE_LOCK_DIR    /var/lock/apache2
env APACHE_SERVERADMIN jon.candlin@gmail.com
env APACHE_SERVERNAME www.leodis.ac.uk

RUN chown -R www-data:www-data /var/log/apache2

EXPOSE 80

CMD /usr/sbin/apachectl -D FOREGROUND
