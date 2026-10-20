FROM php:8.4-fpm-bookworm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libzip-dev \
    && docker-php-ext-install \
    intl \
    pdo_mysql \
    opcache \
    zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 \
    /usr/bin/composer \
    /usr/local/bin/composer

COPY docker/php/php.ini \
    /usr/local/etc/php/conf.d/taskflow.ini

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]