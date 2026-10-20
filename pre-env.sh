#!/bin/bash
set -e
CONFIG_FILE="/var/www/agendav/config/settings.php"
sed -i -e "s/AGENDAV_TIMEZONE/$( echo "${AGENDAV_TIMEZONE}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
CONFIG_FILE="${PHP_INI_DIR}/php.ini"
sed -i -e "s/AGENDAV_TIMEZONE/$( echo "${AGENDAV_TIMEZONE}" | sed -e 's/[\/}]/\\&/g')/" ${CONFIG_FILE}
