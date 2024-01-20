#!/bin/sh
docker build --pull --target realmd -t realmd:base-vmangos -f Dockerfile ..
docker build --pull --target mangosd -t mangosd:base-vmangos -f Dockerfile ..
docker build --pull --target realmd-ptero -t realmd:pterodactyl-vmangos -f Dockerfile ..
docker build --pull --target mangosd-ptero -t mangosd:pterodactyl-vmangos -f Dockerfile ..
sleep 10