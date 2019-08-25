FROM php:7.3.8-fpm-alpine

# install extensions
RUN docker-php-ext-install pdo pdo_mysql bcmath ctype json mbstring tokenizer
RUN apk --no-cache add libxml2-dev autoconf make g++ gcc
RUN docker-php-ext-install xml

RUN pecl install redis-4.0.1 \
    && pecl install \
    && docker-php-ext-enable redis

RUN { \
  echo 'upload_max_filesize = 100M'; \
  echo 'post_max_size = 108M'; \
  echo 'short_open_tag = On'; \
  echo 'fastcgi.logging = 1'; \
} > /usr/local/etc/php/conf.d/my.ini

# copy src files
WORKDIR /var/www/html
COPY ./app /var/www/html

## Laravel setup
# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/bin/composer

# change permissions for laravel
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 0777 storage
RUN mv .env.dev .env

# change execute user
USER www-data

# install packages
RUN composer install




