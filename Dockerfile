FROM php:8.2-apache

# Instala extensiones de PHP necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Instala Composer
RUN apt-get update \
    && apt-get install -y unzip curl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Habilita mod_rewrite para Laravel
RUN a2enmod rewrite

# Copia el código de la app
COPY . /var/www/html

# Crea carpetas y permisos para Laravel (cache, logs, etc)
RUN mkdir -p /var/www/html/storage/framework/cache \
    && mkdir -p /var/www/html/storage/framework/sessions \
    && mkdir -p /var/www/html/storage/framework/views \
    && mkdir -p /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

WORKDIR /var/www/html

# Instala dependencias de PHP con Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader
