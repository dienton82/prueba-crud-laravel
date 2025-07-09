# Usa una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias para Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Copia tu proyecto al directorio del servidor web
COPY . /var/www/html

# Da permisos a la carpeta de almacenamiento y bootstrap
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Habilita mod_rewrite para Laravel
RUN a2enmod rewrite

# Usa el archivo .htaccess incluido en Laravel
