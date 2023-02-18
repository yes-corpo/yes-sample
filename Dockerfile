FROM php:8.1-apache

RUN groupmod -g 1000 www-data \
  && usermod -u 1000 -g 1000 www-data

RUN mkdir \
    /var/www/html/vendor \
    /var/www/html/var \
    /var/www/html/node_modules
RUN chown -R www-data:www-data /var/www

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update 
RUN apt-get install -y gnupg2 gnupg gnupg1
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get install -y \
    nodejs \
    yarn \
    libicu-dev \
    libzip-dev \
    zip

RUN docker-php-ext-configure \
    intl

RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    opcache \
    intl \
    zip

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN a2enmod rewrite \
    && service apache2 restart

WORKDIR /var/www