#!/bin/bash
set -e
CONFIG_FILE="/var/www/agendav/config/settings.php"
sed -i -e "s/AGENDAV_TITLE/$( echo "${AGENDAV_TITLE}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/AGENDAV_FOOTER/$( echo "${AGENDAV_FOOTER}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/AGENDAV_CALDAV_SERVER/$( echo "${AGENDAV_CALDAV_SERVER}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/AGENDAV_CALDAV_PUBLIC_URL/$( echo "${AGENDAV_CALDAV_PUBLIC_URL:-$AGENDAV_CALDAV_SERVER}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/UTC/$( echo "${AGENDAV_TIMEZONE}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/AGENDAV_LANG/$( echo "${AGENDAV_LANG}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/AGENDAV_LOG_DIR/$( echo "${AGENDAV_LOG_DIR}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/AGENDAV_WEEKSTART/$( echo "${AGENDAV_WEEKSTART}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
if [ -z "$AGENDAV_CSRF_SECRET" ]; then
    AGENDAV_CSRF_SECRET=$(php -r 'echo bin2hex(random_bytes(32));')
fi
sed -i -e "s/AGENDAV_CSRF_SECRET/${AGENDAV_CSRF_SECRET}/" ${CONFIG_FILE}
CONFIG_FILE="${PHP_INI_DIR}/php.ini"
sed -i -e "s/UTC/$( echo "${AGENDAV_TIMEZONE}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}

if [ "x$1" = 'xapache2' ]; then
	echo "Start webserver"
	exec /usr/sbin/apache2ctl -D FOREGROUND
else
	exec "$@"
fi
