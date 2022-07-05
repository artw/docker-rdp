#!/bin/sh

groupadd -g ${PGID} ${RDPUSER}
useradd -u ${PUID} -g ${PGID} ${RDPUSER} -d /app -s /bin/bash
echo ${RDPUSER}:${RDPPASS} | /usr/sbin/chpasswd

sed -i "s/{RDPPASS}/${RDPPASS}/" /etc/xrdp/xrdp.ini
sed -i "s/{RDPUSER}/${RDPUSER}/" /etc/xrdp/xrdp.ini
sed -i "s/{RDPAPP}/${RDPAPP}/" /etc/xrdp/xrdp.ini

mkdir -p /var/run/xrdp
chown root:xrdp /var/run/xrdp
chmod 2775 /var/run/xrdp

mkdir -p /var/run/xrdp/sockdir
chown root:xrdp /var/run/xrdp/sockdir
chmod 3777 /var/run/xrdp/sockdir

(sleep 5 && DISPLAY=:1 xrdp --nodaemon) &

echo "${RDPAPP}" >> /app/.xinitrc

chown -R ${RDPUSER} /app

su ${RDPUSER} -c "xinit -- :1"
