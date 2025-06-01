# agendav-docker

Docker image for [AgenDAV - CalDAV web client](https://github.com/agendav/agendav). AgenDAV requires a CalDAV server running alongside (Baïkal, DAViCal, etc.). The address of CalDAV server must be specified in `AGENDAV_CALDAV_SERVER` env, e.g. `AGENDAV_CALDAV_SERVER=https://baikal.server.com/cal.php` or `AGENDAV_CALDAV_SERVER=https://radicale.server.svc.com:5232/%u`

**Note regarding use of Baïkal back-end**: `WebDAV authentication type` must be set to `Basic` during Baïkal initialization.

Since this image only carries a front-end for CalDAV, there's no provision for persistency. Running agendav statelessly has no drawbacks since agendav itself is not customizable.

Standard `php:apache` base image is used. The build is not optimized for size or compilation time.

## Supported tags

See [packages](https://ghcr.io/nagimov/agendav-docker)

## Environment Variables

Note: **all environment variables are mandatory** and must be set via [`docker-compose.yml`](https://github.com/nagimov/agendav-docker/blob/master/docker-compose.yml) or via `-e` option of `docker run ...`

| Environment Variable        | Example                               |
| --------------------------- | ------------------------------------- |
| `AGENDAV_SERVER_NAME`       | `127.0.0.1`                           |
| `AGENDAV_TITLE`             | `"Welcome to Example Agendav Server"` |
| `AGENDAV_FOOTER`            | `"Hosted by Example Company"`         |
| `AGENDAV_CALDAV_SERVER`     | `https://baikal.example.com/cal.php`  |
| `AGENDAV_CALDAV_PUBLIC_URL` | `https://baikal.example.com`          |
| [`AGENDAV_TIMEZONE`][phptz] | `America/Denver`, `Europe/Berlin`     |
| `AGENDAV_WEEKSTART`         | `0` (Sunday) or `1` (Monday)          |
| `AGENDAV_LANG`              | `en`                                  |
| `AGENDAV_LOG_DIR`           | `/tmp/`                               |

## Deployment

- use provided [`docker-compose.yml`](https://github.com/nagimov/agendav-docker/blob/master/docker-compose.yml) and deploy via `docker-compose up`
- or deploy via `docker run`:
```
docker pull ghcr.io/nagimov/agendav-docker:latest
docker run -d --name=agendav \
    -p 80:8080 \
    -e AGENDAV_SERVER_NAME=127.0.0.1 \
    -e AGENDAV_TITLE="Welcome to Example Agendav Server" \
    -e AGENDAV_FOOTER="Hosted by Example Company" \
    -e AGENDAV_CALDAV_SERVER=https://baikal.example.com/cal.php \
    -e AGENDAV_CALDAV_PUBLIC_URL=https://baikal.example.com \
    -e AGENDAV_TIMEZONE=UTC \
    -e AGENDAV_LANG=en \
    -e AGENDAV_LOG_DIR=/tmp/ \
    ghcr.io/nagimov/agendav-docker:latest
```

[phptz]: https://www.php.net/manual/en/timezones.php
