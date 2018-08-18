FROM ys87/ubuntu18apache20php72mssql:r1
LABEL maintainer=“ys.challenger@gmail.com”

###
### WORKING DIR
###

WORKDIR /var/www/html
COPY ./ /var/www/html/
COPY ./docker/vhost.conf /etc/apache2/sites-enabled/000-default.conf 

RUN chown www-data -R /var/www/html/*
RUN chmod 775 -R *

### IF YOU NEED ADDITIONAL PACKAGES:
#RUN apt-get update && apt-get install nano -y

RUN composer install

EXPOSE 80