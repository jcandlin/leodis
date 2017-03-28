FROM ubuntu:xenial
MAINTAINER Jon Candlin jon.candlin@gmail.com

#Install Apache
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2 \ 
    && rm -r /var/lib/apt/lists/* 
    
#Add required Apache mods
RUN a2enmod rewrite
RUN a2enmod proxy_http
RUN a2enmod proxy_balancer

#Ensure default Apache configuration is not enabled
RUN unlink /etc/apache2/sites-enabled/000-default.conf

#Copy vhost config into place and enable it
ADD  httpd-vhosts.conf /etc/apache2/sites-enabled

#Set Apache environment variables
env APACHE_RUN_USER    www-data
env APACHE_RUN_GROUP   www-data
env APACHE_LOG_DIR     /var/log/apache2
env APACHE_PID_FILE    /var/run/apache2.pid
env APACHE_LOCK_DIR    /var/lock/apache2
env APACHE_SERVERADMIN webmasters@leodis.ac.uk
env APACHE_SERVERNAME www.leodis.ac.uk

EXPOSE 80

#Start Apache
CMD /usr/sbin/apachectl -D FOREGROUND
