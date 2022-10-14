FROM --platform=linux/amd64 php:8.2.0RC3-fpm-alpine3.16

LABEL Maintainer="Kirill Abramov <i@abramovk.ru>" \
      "GitHub Link"="https://github.com/abramovk/php" \
      "PHP Version"="8.1.10" \
      "Alpine Linux Version"="3.16" \
      "Composer Version"="2.4.1"
LABEL Description="PHP-FPM v8.1.10 with extensions on Alpine Linux."

ARG COMPOSER_VERSION="2.4.1"
ARG COMPOSER_SUM="ea8cf6308ec76ff9645c3818841a7588096b9dc2767345fbd4bd492dd8a6dca6"

RUN apk add --no-cache \
    c-client \
    ca-certificates \
    freetype \
    gettext \
    git \
    icu-libs \
    icu-data-full \
    imagemagick \
    libintl \
    libjpeg-turbo \
    libpng \
    libpq \
    libmcrypt \
    libtool \
    libxslt \
    libzip \
    make \
    tidyhtml \
    tzdata \
    yaml

RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    bzip2-dev \
    cmake \
    coreutils \
    freetype-dev \
    gcc \
    gettext-dev \
    icu-dev \
    imagemagick-dev \
    libc-dev \
    libjpeg-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    musl-dev \
    openssl-dev \
    pcre-dev \
    pkgconf \
    postgresql-dev \
    tidyhtml-dev \
    yaml-dev \
    zlib-dev

RUN ln -snf /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo Europe/Moscow > /etc/timezone

# bcmath
RUN set -eux \
    && docker-php-ext-install -j$(nproc) bcmath \
    && true

# bz2
RUN set -eux \
    && docker-php-ext-install -j$(nproc) bz2 \
    && true

# calendar
RUN set -eux \
    && docker-php-ext-install -j$(nproc) calendar \
    && true

# exif
RUN set -eux \
    && docker-php-ext-install -j$(nproc) exif \
    && true

# gd
RUN set -eux \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) gd \
    && true

# igbinary
RUN set -eux \
    && pecl install igbinary-3.2.7 \
    && docker-php-ext-enable igbinary \
    && true

# imagick
RUN set -eux \
    && pecl install imagick-3.7.0 \
    && docker-php-ext-enable imagick \
    && true

# intl
RUN set -eux \
    && docker-php-ext-install -j$(nproc) intl \
    && true

# mcrypt
RUN set -eux \
    && pecl install mcrypt-1.0.5 \
    && docker-php-ext-enable mcrypt \
    && true

# msgpack
RUN set -eux \
    && pecl install msgpack-2.1.2 \
    && docker-php-ext-enable msgpack \
    && true

# opcache
RUN set -eux \
    && docker-php-ext-install -j$(nproc) opcache \
    && true

# pcntl
RUN set -eux \
    && docker-php-ext-install -j$(nproc) pcntl \
    && true

# pcov
RUN set -eux \
    && pecl install pcov-1.0.11 \
    && docker-php-ext-enable pcov \
    && true

# pdo_pgsql
RUN set -eux \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && true

# pgsql
RUN set -eux \
    && docker-php-ext-install -j$(nproc) pgsql \
    && true

# phar
RUN set -eux \
    && docker-php-ext-install -j$(nproc) phar \
    && true

# psr
RUN set -eux \
    && pecl install psr-1.2.0 \
    && docker-php-ext-enable psr \
    && true

# redis
RUN set -eux \
    && pecl install redis-5.3.7 \
    && docker-php-ext-enable redis \
    && true

# sockets, sysvmsg, sysvsem, sysvshm
RUN set -eux \
    && CFLAGS="${CFLAGS:=} -D_GNU_SOURCE" docker-php-ext-install -j$(nproc) sockets sysvmsg sysvsem sysvshm \
    && docker-php-source extract \
    && true

# tidy
RUN set -eux \
    && docker-php-ext-install -j$(nproc) tidy \
    && true

# xdebug
RUN set -eux \
    && pecl install xdebug-3.1.5 \
    && docker-php-ext-enable xdebug \
    && true

# xsl
RUN set -eux \
    && docker-php-ext-install -j$(nproc) xsl \
    && true

# yaml
RUN set -eux \
    && pecl install yaml-2.2.2 \
    && docker-php-ext-enable yaml \
    && true

# zip
RUN set -eux \
    && docker-php-ext-configure zip --with-zip \
    && docker-php-ext-install -j$(nproc) zip \
    && true

# Clean
RUN set -eux \
    && docker-php-source delete \
    && apk del .build-deps \
    && true

RUN set -eux \
    && chmod +x "$(php -r 'echo ini_get("extension_dir");')"/* \
    && (find /usr/local/bin -type f -print0 | xargs -n1 -0 strip --strip-all -p 2>/dev/null || true) \
    && (find /usr/local/lib -type f -print0 | xargs -n1 -0 strip --strip-all -p 2>/dev/null || true) \
    && (find /usr/local/sbin -type f -print0 | xargs -n1 -0 strip --strip-all -p 2>/dev/null || true) \
    && true

# composer
RUN set -eux \
    && curl -LO "https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar" \
    && echo "${COMPOSER_SUM}  composer.phar" | sha256sum -c - \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && ln -s /usr/local/bin/composer /usr/bin/composer \
    && composer --version \
    && true

# remove default configs
RUN set -eux \
    && rm -rf /usr/local/etc/php/php.ini-development \
    && rm -rf /usr/local/etc/php/php.ini-production \
    && rm -rf /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && rm -rf /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && rm -rf /usr/local/etc/php/php.ini-production \
    && rm -rf /usr/local/etc/php-fpm.d/zz-docker.conf \
    && rm -rf /usr/local/etc/php-fpm.d/docker.conf

# copy configs
COPY configs/php.ini /usr/local/etc/php/php.ini
COPY configs/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY configs/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY configs/docker-php-ext-opcache.ini /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
COPY configs/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

ENTRYPOINT ["docker-php-entrypoint"]

STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]