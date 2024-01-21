#!/bin/sh
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`

docker build --pull --target realmd -t realmd:${CURRENT_BRANCH} -f Dockerfile ..
docker build --pull --target mangosd -t mangosd:${CURRENT_BRANCH} -f Dockerfile ..
docker build --pull --target realmd-ptero -t realmd:${CURRENT_BRANCH}-pterodactyl -f Dockerfile ..
docker build --pull --target mangosd-ptero -t mangosd:${CURRENT_BRANCH}-pterodactyl -f Dockerfile ..