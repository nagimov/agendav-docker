[![](https://images.microbadger.com/badges/image/nagimov/agendav-docker.svg)](https://hub.docker.com/r/nagimov/agendav-docker)
[![](https://img.shields.io/docker/pulls/nagimov/agendav-docker.svg)](https://hub.docker.com/r/nagimov/agendav-docker)

# agendav-docker
Docker image for AgenDAV - CalDAV web client ([project github](https://github.com/agendav/agendav)). AgenDAV requires a CalDAV server running alongside (Baïkal, DAViCal, etc.). Address to CaLDAV server must be specified in `AGENDAV_CALDAV_SERVER` env, e.g. `AGENDAV_CALDAV_SERVER=https://baikal.server.com/cal.php`

Since this image only carries a front-end for CalDAV, there's no provision for persistency. Running agendav statelessly has no drawbacks since agendav itself is not very customizable.

Image is not optimized for size or compilation time. Standard `debian` base image is used. Final image size is few hundred megabytes (I know it's terrible and I don't care).

## Supported tags

* [`latest`, `2.2.0`, `2.2.0-stretch`](https://github.com/nagimov/agendav-docker/commit/5a8bf42e954ea512fc23abf1f00b82319d996a6b)
* [`2.2.0-wheezy`](https://github.com/nagimov/agendav-docker/commit/97e11ebb437d586d656f740603be7d4f55a4b283)

## ENVs (self-explanatory)

- `AGENDAV_SERVER_NAME`
- `AGENDAV_TITLE`
- `AGENDAV_FOOTER`
- `AGENDAV_ENC_KEY`
- `AGENDAV_CALDAV_SERVER`
- `AGENDAV_TIMEZONE`
- `AGENDAV_LANG`
- `AGENDAV_LOG_DIR`
