ARG PHP_VERSION=7.4

FROM php:${PHP_VERSION}-apache-bullseye

MAINTAINER Ruslan Nagimov <nagimov@outlook.com>

ENV AGENDAV_VERSION 2.6.0

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_PID_FILE=/var/run/apache2.pid
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm
ENV AGENDAV_DB_NAME=agendav_database
ENV AGENDAV_DB_USER=agendav_db_user
ENV AGENDAV_DB_PASSWORD=agendav_db_password
ENV AGENDAV_TIMEZONE=UTC
ENV PHP_INI_DIR /usr/local/etc/php

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN apt-get update && \
    apt-get install -y apt-transport-https \
        apache2 \
        ca-certificates \
        gnupg \
        wget && \
    apt-get -q -y install mariadb-server && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions mbstring xml pdo_mysql && \
    rm /usr/local/bin/install-php-extensions && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN find /var/lib/mysql/mysql -exec touch -c -a {} + && \
    service mariadb restart && \
    mysql -e "CREATE DATABASE $AGENDAV_DB_NAME;" && \
    mysql -e "CREATE USER '$AGENDAV_DB_USER'@'localhost' IDENTIFIED BY '$AGENDAV_DB_PASSWORD';" && \
    mysql -e "GRANT ALL PRIVILEGES ON $AGENDAV_DB_NAME.* TO '$AGENDAV_DB_USER'@'localhost' IDENTIFIED BY '$AGENDAV_DB_PASSWORD';"

RUN cd /tmp && \
    wget https://github.com/agendav/agendav/releases/download/$AGENDAV_VERSION/agendav-$AGENDAV_VERSION.tar.gz && \
    tar -xf agendav-$AGENDAV_VERSION.tar.gz -C /tmp && \
    mv /tmp/agendav-$AGENDAV_VERSION /var/www/agendav && \
    chown -R www-data:www-data /var/www/agendav/web/var

COPY agendav.conf /etc/apache2/sites-available/agendav.conf
COPY settings.php /var/www/agendav/web/config/settings.php
COPY run.sh /usr/local/bin/run.sh
COPY pre-env.sh /tmp/pre-env.sh

RUN chmod +x /tmp/pre-env.sh && \
    cp ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini && \
    echo 'date.timezone = "AGENDAV_TIMEZONE"' >> ${PHP_INI_DIR}/php.ini && \
    echo 'magic_quotes_runtime = false' >> ${PHP_INI_DIR}/php.ini && \
    cd /etc/ssl/certs/ && \
    wget https://curl.se/ca/cacert.pem && \
    echo 'openssl.cafile = "/etc/ssl/certs/cacert.pem"' >> ${PHP_INI_DIR}/php.ini && \
    echo 'curl.cainfo = "/etc/ssl/certs/cacert.pem"' >> ${PHP_INI_DIR}/php.ini && \
    /bin/bash /tmp/pre-env.sh && \
    cd /var/www/agendav && \
    find /var/lib/mysql/mysql -exec touch -c -a {} + && \
    service mariadb restart && \
    yes | php agendavcli migrations:migrate && \
    chmod +x /usr/local/bin/run.sh && \
    a2ensite agendav.conf && \
    a2dissite 000-default && \
    a2enmod rewrite && \
    service apache2 restart && \
    service apache2 stop

RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log \
    && ln -sf /dev/stderr /var/log/apache2/davi-error.log

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/run.sh"]

CMD ["apache2"]
