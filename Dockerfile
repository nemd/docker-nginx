FROM alpine:3.6

RUN apk add --update-cache nginx nginx-mod-stream bash wget unzip runit php7-fpm php7-json curl rtorrent php7 php7-curl ffmpeg unrar

ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx-site.conf /etc/nginx/conf.d/default.conf

COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY php.ini /etc/php7/conf.d/50-setting.ini

RUN mkdir /root/session &&\
	mkdir -p /config/rutorrent/profiles/torrents

ADD rtorrent.rc /root/.rtorrent.rc

RUN mkdir -p /etc/sv/php &&\
	mkdir -p /etc/sv/nginx &&\
	mkdir -p /etc/sv/rtorrent

ADD runit_php /etc/sv/php/run
ADD runit_nginx /etc/sv/nginx/run
ADD runit_rtorrent /etc/sv/rtorrent/run
RUN chmod +x /etc/sv/*/run

RUN ln -s /etc/sv/php /etc/service/php &&\
	ln -s /etc/sv/nginx /etc/service/nginx &&\
	ln -s /etc/sv/rtorrent /etc/service/rtorrent

WORKDIR /tmp

RUN mkdir -p /var/www && \
	wget --no-check-certificate https://bintray.com/artifact/download/novik65/generic/ruTorrent-3.7.zip && \
    unzip ruTorrent-3.7.zip && \
    mv ruTorrent-master /var/www/rutorrent && \
    rm ruTorrent-3.7.zip &&\
    chown -R nginx /var/www/rutorrent &&\
    chown -R nginx /config/rutorrent

RUN sed -i '/profilePath/ s@\.\.\/share@\/config\/rutorrent\/profiles@' /var/www/rutorrent/conf/config.php

# RUN sed -i '/scgi_host/s/127.0.0.1/rtorrent/' /var/www/rutorrent/conf/config.php

EXPOSE 80 49264 6881 5000

VOLUME /downloads /config

ENTRYPOINT ["/sbin/runsvdir", "/etc/service"]