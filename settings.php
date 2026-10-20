<?php
/**
 * AgenDAV instance configuration.
 *
 * Placeholders (AGENDAV_*) are substituted at container start from
 * environment variables; see pre-env.sh and run.sh.
 */

return [
    // Site
    'site.title' => 'AGENDAV_TITLE',
    // Site logo (should be placed in public/assets). Optional
    'site.logo' => 'agendav_100transp.png',
    // Site footer. Optional
    'site.footer' => 'AGENDAV_FOOTER',
    // Trusted proxy ips
    'proxies' => [],
    // Database settings
    'db.options' => [
        'driver' => 'pdo_sqlite',
        'path' => '/var/agendav/db.sqlite',
    ],
    // Security - generated per container if left as placeholder
    'csrf.secret' => 'AGENDAV_CSRF_SECRET',
    // PHP file sessions (SQLite does not support the DB-backed pdo handler)
    'session.handler' => 'native',
    // Log path
    'log.path' => 'AGENDAV_LOG_DIR',
    // Base URL
    'caldav.baseurl' => 'AGENDAV_CALDAV_SERVER',
    // Authentication method required by CalDAV server (basic or digest)
    'caldav.authmethod' => 'basic',
    // Whether to show public CalDAV urls
    'caldav.publicurls' => true,
    // Public URL shown to users (may differ from the internal one)
    'caldav.baseurl.public' => 'AGENDAV_CALDAV_PUBLIC_URL',
    // Default timezone
    'defaults.timezone' => 'AGENDAV_TIMEZONE',
    // Default language
    'defaults.language' => 'AGENDAV_LANG',
    // Default time format. Options: '12' / '24'
    'defaults.time_format' => '24',
    // Default date format. Options: 'ymd', 'dmy', 'mdy'
    'defaults.date_format' => 'ymd',
    // Default first day of week. Options: 0 (Sunday), 1 (Monday)
    'defaults.weekstart' => (int) 'AGENDAV_WEEKSTART',
    // Logout redirection. Optional
    'logout.redirection' => '',
    // Calendar sharing (deprecated - only works with DAViCal)
    'calendar.sharing' => false,
];
