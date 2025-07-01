# Use PHP 8.2 with Apache
FROM php:8.2-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip zip curl libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd \
    && a2enmod rewrite

# Copy composer from official composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy all source code into container
COPY . .

# Install PHP dependencies via composer
RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist

# Expose port 80
EXPOSE 80

# Start Apache in foreground
CMD ["apache2-foreground"]
