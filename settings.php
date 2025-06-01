<?php
// Site title
$app['site.title'] = 'AGENDAV_TITLE';
// Site logo (should be placed in public/img). Optional
$app['site.logo'] = 'agendav_100transp.png';
// Site footer. Optional
$app['site.footer'] = 'AGENDAV_FOOTER';
// Trusted proxy ips
$app['proxies'] = [];
// Database settings
$app['db.options'] = [
    	'path' => '/var/agendav/db.sqlite',
    	'driver' => 'pdo_sqlite',
];
// Log path
$app['log.path'] = 'AGENDAV_LOG_DIR';
// Base URL
$app['caldav.baseurl'] = 'AGENDAV_CALDAV_SERVER';
// Authentication method required by CalDAV server (basic or digest)
$app['caldav.authmethod'] = 'basic';
// Whether to show public CalDAV urls
$app['caldav.publicurls'] = true;
// Whether to show public CalDAV urls
$app['caldav.baseurl.public'] = 'AGENDAV_CALDAV_PUBLIC_URL';
// Default timezone
$app['defaults.timezone'] = 'AGENDAV_TIMEZONE';
// Default languajge
$app['defaults.language'] = 'AGENDAV_LANG';
// Default time format. Options: '12' / '24'
$app['defaults.time.format'] = '24';
/*
 * Default date format. Options:
 *
 * - ymd: YYYY-mm-dd
 * - dmy: dd-mm-YYYY
 * - mdy: mm-dd-YYYY
 */
$app['defaults.date_format'] = 'ymd';
// Default first day of week. Options: 0 (Sunday), 1 (Monday)
$app['defaults.weekstart'] = 'AGENDAV_WEEKSTART';
// Logout redirection. Optional
$app['logout.redirection'] = '';
// Calendar sharing
$app['calendar.sharing'] = true;
