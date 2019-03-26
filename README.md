![](https://images.microbadger.com/badges/image/nagimov/agendav-docker.svg)
![](https://img.shields.io/docker/pulls/nagimov/agendav-docker.svg)

# agendav-docker
Docker image for AgenDAV - CalDAV web client ([project github](https://github.com/agendav/agendav)). AgenDAV requires a CalDAV server running alongside (Baïkal, DAViCal, etc.)

Since this image only carries a front-end for CalDAV, there's no provision for persistency. Running agendav statelessly has no drawbacks since agendav itself is not very customizable.

Image is not optimized for size or compilation time. Standard `debian` base image is used. Final image size is few hundred megabytes (I know it's terrible and I don't care).

## ENVs (self-explanatory)

- `AGENDAV_SERVER_NAME`
- `AGENDAV_TITLE`
- `AGENDAV_FOOTER`
- `AGENDAV_ENC_KEY`
- `AGENDAV_CALDAV_SERVER`
- `AGENDAV_TIMEZONE`
- `AGENDAV_LANG`
- `AGENDAV_LOG_DIR`
