## DOCKER STARTER IMAGE
This starter image is pre-compiled most commonly use stack and utilities required for web development.

### What's included
- Ubuntu 18.04
- Apache 2
- PHP 7.2
- MSSQL ODBC & Tools
- Composer

##### Dependencies and sequence of installation:
- ubuntu:18.04
- apache2
- php php-pear php7.2-dev php7.2-mbstring libapache2-mod-php7.2
- locales
- curl apt-utils apt-transport-https debconf-utils gcc build-essential g++-5
- unixodbc-dev msodbcsql17 mssql-tools
- (pecl) sqlsrv pdo_sqlsrv
- freetds-common freetds-bin unixodbc php7.2-sybase
- openssl zip unzip git
- (curl) composer
