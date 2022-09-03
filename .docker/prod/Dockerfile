FROM php:8.1-apache

RUN groupmod -g 1000 www-data \
  && usermod -u 1000 -g 1000 www-data

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update 

RUN apt-get install -qq -y zip libicu-dev cron libzip-dev zip

RUN docker-php-ext-configure intl

RUN docker-php-ext-install pdo pdo_mysql opcache intl zip > /dev/null

RUN a2enmod rewrite && service apache2 restart

COPY cron.d/yes-sample-cron /etc/cron.d/yes-sample-cron

RUN chmod 0644 /etc/cron.d/yes-sample-cron

RUN crontab /etc/cron.d/yes-sample-cron

COPY . /var/www

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www

RUN sed -i 's/^exec /service cron start\n\nexec /' /usr/local/bin/apache2-foreground
