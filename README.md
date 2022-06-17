[![](https://images.microbadger.com/badges/image/nagimov/agendav-docker.svg)](https://hub.docker.com/r/nagimov/agendav-docker)
[![](https://img.shields.io/docker/pulls/nagimov/agendav-docker.svg)](https://hub.docker.com/r/nagimov/agendav-docker)

# agendav-docker

Docker image for [AgenDAV - CalDAV web client](https://github.com/agendav/agendav). AgenDAV requires a CalDAV server running alongside (Baïkal, DAViCal, etc.). The address of CalDAV server must be specified in `AGENDAV_CALDAV_SERVER` env, e.g. `AGENDAV_CALDAV_SERVER=https://baikal.server.com/cal.php`

**Note regarding use of Baïkal back-end**: `WebDAV authentication type` must be set to `Basic` during Baïkal initialization.

Since this image only carries a front-end for CalDAV, there's no provision for persistency. Running agendav statelessly has no drawbacks since agendav itself is not customizable.

Standard `debian` base image is used. The build is not optimized for size or compilation time.

## Supported tags

* [`latest`, `2.2.0`, `2.2.0-bullseye`](https://github.com/nagimov/agendav-docker/commit/d938b77607f6978375f311e2650d8109c2168b63)
* [`2.2.0-buster`](https://github.com/nagimov/agendav-docker/commit/ed083623e14218b6bf9a801aa38c47968cbec1e0)
* [`2.2.0-stretch`](https://github.com/nagimov/agendav-docker/commit/5a8bf42e954ea512fc23abf1f00b82319d996a6b)
* [`2.2.0-wheezy`](https://github.com/nagimov/agendav-docker/commit/97e11ebb437d586d656f740603be7d4f55a4b283)

## Environment Variables

Note: **all environment variables are mandatory** and must be set via [`docker-compose.yml`](https://github.com/nagimov/agendav-docker/blob/master/docker-compose.yml) or via `-e` option of `docker run ...`

| Environment Variable    | Example                               |
| ----------------------- | ------------------------------------- |
| `AGENDAV_SERVER_NAME`   | `127.0.0.1`                           |
| `AGENDAV_TITLE`         | `"Welcome to Example Agendav Server"` |
| `AGENDAV_FOOTER`        | `"Hosted by Example Company"`         |
| `AGENDAV_ENC_KEY`       | `my_encrypt10n_k3y`                   |
| `AGENDAV_CALDAV_SERVER` | `https://baikal.example.com/cal.php`  |
| `AGENDAV_TIMEZONE`      | `UTC`, `UTC+1`, `Europe/Berlin`       |
| `AGENDAV_LANG`          | `en`                                  |
| `AGENDAV_LOG_DIR`       | `/tmp/`                               |

## Deployment

- use provided [`docker-compose.yml`](https://github.com/nagimov/agendav-docker/blob/master/docker-compose.yml) and deploy via `docker-compose up`
- or deploy via `docker run`:
```
docker run -d --name=agendav \
    -p 80:80 \
    -e AGENDAV_SERVER_NAME=127.0.0.1 \
    -e AGENDAV_TITLE="Welcome to Example Agendav Server" \
    -e AGENDAV_FOOTER="Hosted by Example Company" \
    -e AGENDAV_ENC_KEY=my_encrypt10n_k3y \
    -e AGENDAV_CALDAV_SERVER=https://baikal.example.com/cal.php \
    -e AGENDAV_TIMEZONE=UTC \
    -e AGENDAV_LANG=en \
    -e AGENDAV_LOG_DIR=/tmp/ \
    nagimov/agendav-docker:latest
```
