# opl-samba

This repo contains a docker image with samba server set up to share Playstation 2 games with [Open Playstation Loader](https://github.com/ps2homebrew/Open-PS2-Loader) over LAN.

# How to start

Make sure you have `git`, `docker`, and `docker-compose` installed.

1. Pull this repo with `git clone https://github.com/prk3/opl-samba.git`.
1. Go to the repo folder with `cd opl-samba`.
1. Adjust OPL folder path in `docker-compose.yml`.
1. Build and run the container with `docker-compose up`.

# Troubleshooting

## OPL can't connect to the server (error 300)

Make sure your firewall does not block traffic on port 445. Ports 137-139 must be opened if OPL uses discovery protocols (see the note in `docker-compose.yml`).

## Black screen when starting games

Make sure you're connected to your local network with a LAN cable. Sharing games over WiFi does not work reliably.

