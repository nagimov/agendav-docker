ARG PHP_VERSION=8.2

FROM debian:bullseye-slim as downloader

ENV AGENDAV_VERSION 2.6.0

ADD https://github.com/agendav/agendav/releases/download/$AGENDAV_VERSION/agendav-$AGENDAV_VERSION.tar.gz /tmp/

RUN cd /tmp && \
    tar -xf agendav-$AGENDAV_VERSION.tar.gz -C /tmp && \
    mv /tmp/agendav-$AGENDAV_VERSION /tmp/agendav


FROM php:${PHP_VERSION}-apache-bullseye

MAINTAINER Ruslan Nagimov <nagimov@outlook.com>

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
ENV TERM=xterm
ENV AGENDAV_TIMEZONE=UTC
ENV PHP_INI_DIR /usr/local/etc/php

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN apt-get update && \
    apt-get install -y apt-transport-https \
        ca-certificates && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions mbstring xml pdo_sqlite && \
    rm /usr/local/bin/install-php-extensions && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=downloader --chown=www-data:www-data /tmp/agendav /var/www/agendav

COPY agendav.conf /etc/apache2/sites-available/agendav.conf
COPY settings.php /var/www/agendav/web/config/settings.php
COPY run.sh /usr/local/bin/run.sh
COPY pre-env.sh /tmp/pre-env.sh

ADD https://curl.se/ca/cacert.pem /etc/ssl/certs/

RUN chmod +x /tmp/pre-env.sh && \
    chmod 644 /etc/ssl/certs/cacert.pem && \
    chown -R www-data:www-data ${PHP_INI_DIR} && \
    chown -R www-data:www-data /var/run/apache2 && \
    chmod 755 ${APACHE_LOG_DIR} && \
    chown -R www-data:www-data ${APACHE_LOG_DIR} && \
    cp ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini && \
    echo 'date.timezone = "AGENDAV_TIMEZONE"' >> ${PHP_INI_DIR}/php.ini && \
    echo 'magic_quotes_runtime = false' >> ${PHP_INI_DIR}/php.ini && \
    echo 'openssl.cafile = "/etc/ssl/certs/cacert.pem"' >> ${PHP_INI_DIR}/php.ini && \
    echo 'curl.cainfo = "/etc/ssl/certs/cacert.pem"' >> ${PHP_INI_DIR}/php.ini && \
    /bin/bash /tmp/pre-env.sh && \
    rm /tmp/pre-env.sh && \
    cd /var/www/agendav && \
    mkdir -p /var/agendav && \
    touch /var/agendav/db.sqlite && \
    chown -R www-data:www-data /var/agendav && \
    chmod 640 /var/agendav/db.sqlite && \
    yes | php agendavcli migrations:migrate && \
    chmod +x /usr/local/bin/run.sh && \
    a2ensite agendav.conf && \
    a2dissite 000-default && \
    a2enmod rewrite && \
    echo "Listen 127.0.0.1:8080" > /etc/apache2/ports.conf && \
    service apache2 restart && \
    service apache2 stop &&  \
    echo "Listen 8080" > /etc/apache2/ports.conf

RUN ln -sf /dev/stdout ${APACHE_LOG_DIR}/access.log \
    && ln -sf /dev/stderr ${APACHE_LOG_DIR}/error.log \
    && ln -sf /dev/stderr ${APACHE_LOG_DIR}/davi-error.log

EXPOSE 8080

USER www-data

ENTRYPOINT ["/usr/local/bin/run.sh"]

CMD ["apache2"]
