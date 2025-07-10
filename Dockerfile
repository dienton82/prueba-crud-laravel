FROM php:8.2-apache

# Instala extensiones requeridas
RUN docker-php-ext-install pdo pdo_mysql

# Instala Composer (¡esto es lo que te falta!)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Habilita mod_rewrite para Laravel
RUN a2enmod rewrite

# Copia el código de la app
COPY . /var/www/html

# Permisos para storage y cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Cambia el DocumentRoot de Apache a public/
RUN sed -i 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf

# Instala dependencias de Laravel
RUN composer install --no-interaction --prefer-dist --optimize-autoloader
