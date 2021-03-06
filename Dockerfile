FROM ubuntu:trusty
MAINTAINER Mohammed Faizal <izalmul@gmail.com>

# installing packages and dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install wget unzip supervisor apache2 mysql-client libapache2-mod-php5 php5 php5-common php5-curl php5-fpm php5-cli php5-mysqlnd php5-mcrypt
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# adding configuration files and scripts
ADD start-apache2.sh /start-apache2.sh
ADD run.sh /run.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
RUN chmod 755 /*.sh

# setting up default apache config
ADD apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# downloading and setting up webmail
RUN rm -rf /tmp/alwm
RUN mkdir -p /tmp/alwm
RUN wget -P /tmp/alwm http://www.afterlogic.com/download/webmail_php.zip
RUN unzip -q /tmp/alwm/webmail_php.zip -d /tmp/alwm/
RUN rm -rf /var/www/html
RUN mkdir -p /var/www/html
RUN cp -r /tmp/alwm/webmail/* /var/www/html
RUN rm -rf /var/www/html/install
RUN chown www-data.www-data -R /var/www/html
RUN chmod 0777 -R /var/www/html/data
RUN rm -f /var/www/html/afterlogic.php
COPY afterlogic.php /var/www/html/afterlogic.php
RUN rm -rf /tmp/alwm

# setting php configuration values
ENV PHP_UPLOAD_MAX_FILESIZE 64M
ENV PHP_POST_MAX_SIZE 128M

EXPOSE 80 
CMD ["/run.sh"]
