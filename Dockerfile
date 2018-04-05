FROM debian:wheezy

MAINTAINER Ruslan Nagimov <nagimov@outlook.com>

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

RUN apt-get update && \
    apt-get install -y wget && \ 
    wget http://www.dotdeb.org/dotdeb.gpg && \
    apt-key add dotdeb.gpg && \
    echo 'deb http://packages.dotdeb.org wheezy-php56 all' >> /etc/apt/sources.list && \
    echo 'deb-src http://packages.dotdeb.org wheezy-php56 all' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get -q -y install mysql-server && \
    apt-get -y install \
        apache2 \
        php5 \
        php5-mysql && \
    apt-get update && \
    apt-get install nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN service mysql restart && \
    mysql -e "CREATE DATABASE $AGENDAV_DB_NAME;" && \
    mysql -e "CREATE USER '$AGENDAV_DB_USER'@'localhost' IDENTIFIED BY '$AGENDAV_DB_PASSWORD';" && \
    mysql -e "GRANT ALL PRIVILEGES ON $AGENDAV_DB_NAME.* TO '$AGENDAV_DB_USER'@'localhost' IDENTIFIED BY '$AGENDAV_DB_PASSWORD';"

RUN cd /tmp && \
    wget --no-check-certificate https://github.com/agendav/agendav/releases/download/2.2.0/agendav-2.2.0.tar.gz && \
    tar -xf agendav-2.2.0.tar.gz -C /tmp && \
    mv /tmp/agendav-2.2.0 /var/www/agendav && \
    chown -R www-data:www-data /var/www/agendav/web/var

COPY agendav.conf /etc/apache2/sites-available/agendav.conf
COPY settings.php /var/www/agendav/web/config/settings.php
COPY run.sh /usr/local/bin/run.sh
COPY pre-env.sh /tmp/pre-env.sh

RUN chmod +x /tmp/pre-env.sh && \
    echo 'date.timezone = "AGENDAV_TIMEZONE"' >> /etc/php5/cli/php.ini && \
    echo 'date.timezone = "AGENDAV_TIMEZONE"' >> /etc/php5/apache2/php.ini && \
    echo 'magic_quotes_runtime = false' >> /etc/php5/cli/php.ini && \
    echo 'magic_quotes_runtime = false' >> /etc/php5/apache2/php.ini && \
    /tmp/pre-env.sh && \
    cd /var/www/agendav && \
    service mysql restart && \
    yes | php agendavcli migrations:migrate && \
    chmod +x /usr/local/bin/run.sh && \
    a2ensite agendav.conf && \
    a2dissite 000-default && \
    a2enmod rewrite && \
    a2enmod php5 && \
    service apache2 restart && \
    service apache2 stop

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/run.sh"]

CMD ["apache2"]
