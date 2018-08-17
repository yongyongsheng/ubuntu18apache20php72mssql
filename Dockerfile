# Source: https://github.com/Microsoft/mssql-docker/blob/master/oss-drivers/msphpsql/Dockerfile (Modified for PHP7.2)
FROM ubuntu:18.04
LABEL maintainer="ys.challenger@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive

## Install apache
RUN apt-get update && apt-get install -y apache2
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
RUN mkdir -p $APACHE_RUN_DIR
RUN mkdir -p $APACHE_LOCK_DIR
RUN mkdir -p $APACHE_LOG_DIR

## Install PHP
RUN apt-get update && apt-get install -y php php-pear php7.2-dev php7.2-mbstring libapache2-mod-php7.2 --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

## Install MSSQL
RUN apt-get update && apt-get install -y curl apt-utils apt-transport-https debconf-utils gcc build-essential g++-5\
    && rm -rf /var/lib/apt/lists/*
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y unixodbc-dev msodbcsql17 mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

RUN pecl install sqlsrv pdo_sqlsrv
RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/sqlsrv.ini
RUN echo "extension=sqlsrv.so" >> /etc/php/7.2/apache2/php.ini
RUN echo "extension=pdo_sqlsrv.so" >> /etc/php/7.2/apache2/php.ini

RUN apt-get update && apt-get install -y freetds-common freetds-bin unixodbc php7.2-sybase

# Enabling Apache mod
RUN a2dismod mpm_event
RUN a2enmod php7.2
RUN a2enmod rewrite

## Install composer
RUN apt-get update && apt-get install -y openssl zip unzip git
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

EXPOSE 80
CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]