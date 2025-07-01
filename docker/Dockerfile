# Use PHP 8.2 with Apache
FROM php:8.2-apache

# Install required PHP extensions and tools
RUN apt-get update && apt-get install -y \
    git unzip zip curl libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip \
    && a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy composer from official composer image (optimization)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy application source code to container
COPY . .

# Install PHP dependencies using composer
RUN composer install --no-dev --optimize-autoloader

# Permissions (adjust if needed)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose Apache port 80
EXPOSE 80

CMD ["apache2-foreground"]
