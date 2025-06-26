#!/bin/bash
set -e
CONFIG_FILE="/var/www/agendav/web/config/settings.php"
sed -i -e "s/AGENDAV_DB_NAME/$( echo "${AGENDAV_DB_NAME}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/AGENDAV_DB_USER/$( echo "${AGENDAV_DB_USER}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/AGENDAV_DB_PASSWORD/$( echo "${AGENDAV_DB_PASSWORD}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
sed -i -e "s/AGENDAV_TIMEZONE/$( echo "${AGENDAV_TIMEZONE}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
CONFIG_FILE="${PHP_INI_DIR}/php.ini"
sed -i -e "s/AGENDAV_TIMEZONE/$( echo "${AGENDAV_TIMEZONE}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
