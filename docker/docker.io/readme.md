# DOCKER BASE FILE

This base docker image is available on:
- 923763705594.dkr.ecr.ap-southeast-1.amazonaws.com/basedocker:latest

### Dependancies:
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

#### Pushed to ECR
1. $(aws ecr get-login --no-include-email --region ap-southeast-1)
2. docker build -t basedocker .
3. docker tag basedocker:latest 923763705594.dkr.ecr.ap-southeast-1.amazonaws.com/basedocker:latest
4. docker push 923763705594.dkr.ecr.ap-southeast-1.amazonaws.com/basedocker:latest

