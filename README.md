# docker-rtorrent

## components
- alpine
- rtorrent stable
- rutorrent stable
- nginx
- php-fpm
- runit to serve them all


## run:
- docker-compose.yml - edit for volumes /for downloads/
- php-fpm.ini - set codepath /chdir/ to be exact same as in nginx /nginx-site.conf/
- rtorrent.rc - edit for paths, ports, options etc


## todo:
- add volume for config
- move php-fpm to nginx unit
- add templates for all configs (?)
- add .htaccess for nginx
- add tls
- replace runit with s6-overlay /to test it mostly/
