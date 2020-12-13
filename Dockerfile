FROM alpine:3.11

ARG SAMBA_VERSION=4.11.16-r0

RUN apk add "samba=${SAMBA_VERSION}"

EXPOSE 445/tcp
EXPOSE 445/udp

EXPOSE 139/tcp
EXPOSE 139/udp

EXPOSE 138/tcp
EXPOSE 138/udp

EXPOSE 137/tcp
EXPOSE 137/udp

CMD smbd --foreground --log-stdout --no-process-group --debuglevel=1

