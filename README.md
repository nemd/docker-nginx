# docker-rtorrent

0. alpine
1. rtorrent stable
2. rutorrent stable
3. nginx
4. php-fpm

notes:

docker-compose.yml - edit for volumes /for downloads/
php-fpm.ini - set codepath /chdir/ to be exact same as in nginx /nginx-site.conf/
rtorrent.rc - edit for paths, ports, options etc


todo:
- add volume for config
- move php-fpm to nginx unit
- add templates for all configs (?)
