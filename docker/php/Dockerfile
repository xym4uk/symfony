FROM php:7.4-fpm

ARG user
ARG uid
ARG XDEBUG
ARG XDEBUG_PORT

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    wget \
    libicu-dev

# Enable Xdebug
RUN if [ ${XDEBUG} ] ; then \
      yes | pecl install xdebug && \
      echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
      && echo "xdebug.client_port = ${XDEBUG_PORT}" >> /usr/local/etc/php/conf.d/php-ext-xdebug.ini \
      && echo "xdebug.mode = debug" >> /usr/local/etc/php/conf.d/php-ext-xdebug.ini \
      && echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/php-ext-xdebug.ini \
      && echo "xdebug.client_host = host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini \
    else \
      echo "Skip xdebug support"; \
    fi

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install mbstring tokenizer mysqli pdo pdo_pgsql pgsql zip
RUN docker-php-ext-install intl

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Clean
RUN rm -rf /var/cache/apk/* && docker-php-source delete

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

WORKDIR /var/www/

RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv ${HOME}/.symfony/bin/symfony /usr/local/bin/symfony

USER $user
