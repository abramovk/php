FROM --platform=linux/amd64 abramovk/php:8.1.10-fpm

LABEL Maintainer="Kirill Abramov <i@abramovk.ru>" \
      "GitHub Link"="https://github.com/abramovk/php" \
      "PHP Version"="8.1.10" \
      "Alpine Linux Version"="3.16" \
      "Composer Version"="2.4.1" \
      "System"="AUTH"
LABEL Description="PHP-FPM v8.1.10 with extensions on Alpine Linux."

RUN apk add --no-cache \
    gcompat \
    geoip \
    libaio \
    libc6-compat \
    libnsl \
    libstdc++

RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    cmake \
    coreutils \
    gcc \
    geoip-dev \
    libc-dev \
    musl-dev \
    pkgconf

# oracle client
RUN cd /tmp && \
    curl -o instantclient-basiclite.zip https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip -SL && \
    curl -o instantclient-sdk.zip https://download.oracle.com/otn_software/linux/instantclient/instantclient-sdk-linuxx64.zip -SL && \
    unzip instantclient-basiclite.zip && \
    unzip instantclient-sdk.zip && \
    mv instantclient*/ /usr/lib/instantclient && \
    rm instantclient-basiclite.zip && \
    ln -s /usr/lib/instantclient/libclntsh.so.21.1 /usr/lib/libclntsh.so && \
    ln -s /usr/lib/instantclient/libocci.so.21.1 /usr/lib/libocci.so && \
    ln -s /usr/lib/instantclient/libociicus.so /usr/lib/libociicus.so && \
    ln -s /usr/lib/instantclient/libnnz21.so /usr/lib/libnnz21.so && \
    ln -s /usr/lib/libnsl.so.2 /usr/lib/libnsl.so.1 && \
    ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2 && \
    ln -s /lib64/ld-linux-x86-64.so.2 /usr/lib/ld-linux-x86-64.so.2

ENV ORACLE_BASE /usr/lib/instantclient
ENV LD_LIBRARY_PATH /usr/lib/instantclient
ENV TNS_ADMIN /usr/lib/instantclient
ENV ORACLE_HOME /usr/lib/instantclient

# TODO: добавить криптопро
# TODO: добавить openjre 11

# geoip
RUN set -eux \
    && cd /tmp \
    && curl -o geoip.zip https://github.com/php/pecl-networking-geoip/archive/refs/heads/master.zip -SL \
    && unzip geoip.zip \
    && rm -f geoip.zip \
    && cd pecl-networking-geoip-master \
    && phpize \
    && ./configure --enable-geoip \
    && make -j$(nproc) \
    && make install \
    && rm -rf /tmp/pecl-networking-geoip-master \
    && true

# mongodb
RUN set -eux \
    && pecl install mongodb-1.14.0 \
    && docker-php-ext-enable mongodb \
    && true

# oci8
RUN set -eux \
    && docker-php-ext-configure oci8 --with-oci8=instantclient,$ORACLE_HOME \
    && docker-php-ext-install -j$(nproc) oci8 \
    && true

# pdo_oci
RUN set -eux \
    && docker-php-ext-configure pdo_oci --with-pdo-oci=instantclient,$ORACLE_HOME \
    && docker-php-ext-install -j$(nproc) pdo_oci \
    && true

# clean
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

ENTRYPOINT ["docker-php-entrypoint"]

STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]