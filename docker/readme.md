#   LARAVEL WITH DOCKER 

#### REQUIRED FILES:
    - Laravel base project
    - Main dockerfile configuration (./Dockerfile & ./docker/vhost.conf & prod.env)
    - Development docker configuration (./docker-compose.yml & ./docker/dev.dockerfile)

### DEVELOPMENT MODE:

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

### PRODUCTION MODE:

This mode will build the docker image with the site files in the image as one package.
This will be the final build (as what going to be build in the server).

1. Build the docker image: docker build -t dproject .
2. Run container with the image: docker run -p 8181:80 dproject
