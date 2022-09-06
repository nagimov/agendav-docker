# agendav-docker

Docker image for [AgenDAV - CalDAV web client](https://github.com/agendav/agendav). AgenDAV requires a CalDAV server running alongside (Baïkal, DAViCal, etc.). The address of CalDAV server must be specified in `AGENDAV_CALDAV_SERVER` env, e.g. `AGENDAV_CALDAV_SERVER=https://baikal.server.com/cal.php`

**Note regarding use of Baïkal back-end**: `WebDAV authentication type` must be set to `Basic` during Baïkal initialization.

Since this image only carries a front-end for CalDAV, there's no provision for persistency. Running agendav statelessly has no drawbacks since agendav itself is not customizable.

Standard `debian` base image is used. The build is not optimized for size or compilation time.

## Supported tags

See [packages](https://ghcr.io/nagimov/agendav-docker)

## Environment Variables

Note: **all environment variables are mandatory** and must be set via [`docker-compose.yml`](https://github.com/nagimov/agendav-docker/blob/master/docker-compose.yml) or via `-e` option of `docker run ...`

| Environment Variable        | Example                               |
| --------------------------- | ------------------------------------- |
| `AGENDAV_SERVER_NAME`       | `127.0.0.1`                           |
| `AGENDAV_TITLE`             | `"Welcome to Example Agendav Server"` |
| `AGENDAV_FOOTER`            | `"Hosted by Example Company"`         |
| `AGENDAV_ENC_KEY`           | `my_encrypt10n_k3y`                   |
| `AGENDAV_CALDAV_SERVER`     | `https://baikal.example.com/cal.php`  |
| `AGENDAV_CALDAV_PUBLIC_URL` | `https://baikal.example.com`          |
| `AGENDAV_TIMEZONE`          | `UTC`, `UTC+1`, `Europe/Berlin`       |
| `AGENDAV_LANG`              | `en`                                  |
| `AGENDAV_LOG_DIR`           | `/tmp/`                               |

## Deployment

- use provided [`docker-compose.yml`](https://github.com/nagimov/agendav-docker/blob/master/docker-compose.yml) and deploy via `docker-compose up`
- or deploy via `docker run`:
```
docker pull ghcr.io/nagimov/agendav-docker:latest
docker run -d --name=agendav \
    -p 80:80 \
    -e AGENDAV_SERVER_NAME=127.0.0.1 \
    -e AGENDAV_TITLE="Welcome to Example Agendav Server" \
    -e AGENDAV_FOOTER="Hosted by Example Company" \
    -e AGENDAV_ENC_KEY=my_encrypt10n_k3y \
    -e AGENDAV_CALDAV_SERVER=https://baikal.example.com/cal.php \
    -e AGENDAV_CALDAV_PUBLIC_URL=https://baikal.example.com \
    -e AGENDAV_TIMEZONE=UTC \
    -e AGENDAV_LANG=en \
    -e AGENDAV_LOG_DIR=/tmp/ \
    ghcr.io/nagimov/agendav-docker:latest
```
