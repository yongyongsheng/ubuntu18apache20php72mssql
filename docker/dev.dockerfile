FROM ys87/ubuntu18apache20php72mssql:r1
LABEL maintainer=“ys.challenger@gmail.com”

WORKDIR /var/www/html
COPY ./docker/vhost.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /var/www

