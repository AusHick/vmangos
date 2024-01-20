#
#	Production Base
#

FROM debian:bookworm-slim AS prod
RUN apt-get -q -y update \
	&& apt-get -q -y --no-install-recommends install libace-7.0.8 libmariadb3 libtbb12\
	&& apt-get -q -y autoremove \
	&& apt-get -q -y clean
WORKDIR /build

#
#	Pterodactyl Base
#

FROM prod as ptero
USER container
ENV HOME=/home/container
WORKDIR /home/container
COPY ./docker/entrypoint.sh .

#
#	VMaNGOS
#

FROM prod AS mangos
ARG cachebust

RUN apt-get -q -y update \
	&& apt-get -q -y install git g++ cmake libace-dev libtbb-dev default-libmysqlclient-dev libreadline-dev

WORKDIR /src
COPY . .
# RUN git clone --recursive -b main https://github.com/AusHick/vmangos.git .

WORKDIR /build
RUN cmake /src -B /build -DDEBUG=0 -DSUPPORTED_CLIENT_BUILD=5875 -DUSE_EXTRACTORS=0 -DCMAKE_INSTALL_PREFIX=/build/
RUN make -j$(nproc)
RUN make install

#
#	mangosd
#

FROM prod AS mangosd

EXPOSE 8085

COPY --from=mangos /build/bin/mangosd bin/mangosd
COPY --from=mangos /build/bin/lua_scripts bin/lua_scripts
COPY --from=mangos /build/bin/lua52_compiler bin/lua52_compiler
COPY --from=mangos /build/bin/lua52_interpreter bin/lua52_interpreter
COPY --from=mangos /build/lib/liblua52.so lib/liblua52.so
COPY --from=mangos /build/etc/mangosd.conf.dist etc/mangosd.conf.dist
# COPY ./docker/data/5875 gamedata/5875
# COPY ./docker/data/maps gamedata/maps
# COPY ./docker/data/mmaps gamedata/mmaps
# COPY ./docker/data/vmaps gamedata/vmaps

CMD [ "bin/mangosd" ]

#
#	realmd
#

FROM prod AS realmd

EXPOSE 3724

COPY --from=mangos /build/bin/realmd bin/realmd
COPY --from=mangos /build/etc/realmd.conf.dist etc/realmd.conf.dist

CMD [ "bin/realmd" ]

#
#	mangosd for Pterodactyl
#

FROM ptero as mangosd-ptero

COPY --from=mangos /build/bin/mangosd bin/mangosd
COPY --from=mangos /build/bin/lua_scripts bin/lua_scripts
COPY --from=mangos /build/bin/lua52_compiler bin/lua52_compiler
COPY --from=mangos /build/bin/lua52_interpreter bin/lua52_interpreter
COPY --from=mangos /build/lib/liblua52.so /build/lib/liblua52.so
COPY --from=mangos /build/etc/mangosd.conf.dist etc/mangosd.conf.dist
# COPY ./docker/data/5875 gamedata/5875
# COPY ./docker/data/maps gamedata/maps
# COPY ./docker/data/mmaps gamedata/mmaps
# COPY ./docker/data/vmaps gamedata/vmaps

CMD [ "/bin/sh", "entrypoint.sh" ]

#
#	realmd for Pterodactyl
#

FROM ptero as realmd-ptero

COPY --from=mangos /build/bin/realmd bin/realmd
COPY --from=mangos /build/etc/realmd.conf.dist etc/realmd.conf.dist

CMD [ "/bin/sh", "entrypoint.sh" ]