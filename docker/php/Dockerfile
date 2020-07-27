FROM php:7.4-fpm

RUN apt-get update \
 && apt-get install vim -y \
 && docker-php-ext-install mysqli pdo pdo_mysql  \
 && apt-get install netcat -y
 
CMD ["php-fpm"]