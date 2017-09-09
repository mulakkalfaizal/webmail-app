#!/bin/bash

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini

    mysql -h mysql -uroot -pmy-secret-pw -e "DROP DATABASE IF EXISTS afterlogic"
    mysql -h mysql -uroot -pmy-secret-pw -e "CREATE DATABASE afterlogic"

    echo "Database created!"

    php /var/www/html/afterlogic.php

exec supervisord -n
