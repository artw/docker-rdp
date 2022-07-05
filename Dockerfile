ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends \
  ca-certificates \
  openbox \
  tzdata \
  xfonts-base \
  xorgxrdp \
  xrdp \
  xterm \
  xinit \
  && rm -rf /var/lib/apt/lists/*

ENV TZ="Europe/Zurich" RDPUSER="leet" PUID="1337" PGID="1337" RDPPASS="password" RDPAPP="xterm"
RUN ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

COPY files/rc.xml /app/.config/openbox/rc.xml
COPY files/xinitrc /app/.xinitrc
COPY files/xserverrc /app/.xserverrc
COPY files/xrdp.ini /etc/xrdp/xrdp.ini
COPY files/init.sh /init.sh

EXPOSE 3389

CMD /init.sh
