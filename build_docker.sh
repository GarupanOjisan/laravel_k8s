#!/bin/bash

version=$1

docker build -t test/nginx:$version -f ./docker/nginx/Dockerfile .
docker tag test/nginx:$version localhost:5000/test/nginx:$version
docker push localhost:5000/test/nginx:$version

docker build -t test/php-fpm:$version -f ./docker/php-fpm/Dockerfile .
docker tag test/php-fpm:$version localhost:5000/test/php-fpm:$version
docker push localhost:5000/test/php-fpm:$version
