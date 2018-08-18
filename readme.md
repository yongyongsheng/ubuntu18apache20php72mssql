# DOCKER BEGINNER IMAGE

### What’s included

This docker image is compiled with:
- Ubuntu 18.04
- Apache 2
- PHP 7.2

Main utilities included: MSSQL, Git, Composer.
Please refer to the Docker Hub repository for details.

### Beginner's Guide

1. Git clone this repository
2. Start Docker on your machine
3. Run: docker build -t dproject . to build this project
4. Run: docker run -p 8181:80 dproject to start this project container
5. Your container is ready on http://localhost:8181

-------------

##### REQUIRED FILES:
    - Main dockerfile configuration (./Dockerfile & ./docker/vhost.conf & prod.env)
    - Development docker configuration (./docker-compose.yml & ./docker/dev.dockerfile)

##### How it works

1. Pull the pre-compiled image from Docker Hub.
2. Continue building container according to content in Dockerfile.

This project was build for Laravel connecting to MSSQL DB. The base image is provided here.
This project was prepared with development mode with docker-compose. Any changes to Dockerfile should be applied to docker/dev.dockerfile or vice-versa.

##### DEVELOPMENT MODE:

This mode will allow you to run the docker container but reference the working directory to path on your computer.
Any file changes will appear immediately in the test url.

After you’ve cloned the project from Github with the required files:
1. Run following command to simulate composer to path
     docker run --rm -v $(pwd):/app composer install
2. Run following command to spin new container. Site will be available on http://localhost:8080/phpinfo.php
     docker-compose up

You may need to run some of the Laravel php commands. To run them in the container, use following:
(Execute the command ‘php artisan key:generate’ inside the container used by the service ‘devsvr’)
     docker-compose exec -it [container_id] bash  #enter cmd mode
     docker-compose exec [container_id] tail -100 /var/log/httpd/error_log
     docker-compose exec [container_id] php artisan optimize

##### PRODUCTION MODE:

This mode will build the docker image with the site files in the image as one package.
This will be the final build (as what going to be build in the server).

1. Build the docker image: docker build -t dproject .
2. Run container with the image: docker run -p 8181:80 dproject

