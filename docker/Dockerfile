# image from docker hub
FROM php:8.4-apache
LABEL maintainer="Zdeněk Papučík <zdenek.papucik@gmail.com>"

# build-time customization
ARG DEBIAN_FRONTEND=noninteractive

# run commands; GD (with JPEG and WebP) resizes uploaded images, e.g. the cover images of project-blog
RUN apt-get update \
    && apt-get upgrade -y \
    && a2enmod rewrite \
    && apt-get install -y --no-install-recommends libjpeg62-turbo-dev libpng-dev libwebp-dev \
    && docker-php-ext-configure gd --with-jpeg --with-webp \
    && docker-php-ext-install gd \
    && rm -rf /var/lib/apt/lists/*

# RUN a2enmod ssl

# php configuration
COPY conf/php.ini /usr/local/etc/php/conf.d
COPY conf/000-default.conf /etc/apache2/sites-available/

# the ports
EXPOSE 80
