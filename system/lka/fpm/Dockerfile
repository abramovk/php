FROM --platform=linux/amd64 abramovk/php:8.1.10-fpm

LABEL Maintainer="Kirill Abramov <i@abramovk.ru>" \
      "GitHub Link"="https://github.com/abramovk/php" \
      "PHP Version"="8.1.10" \
      "Alpine Linux Version"="3.16" \
      "Composer Version"="2.4.1" \
      "System"="LKA"
LABEL Description="PHP-FPM v8.1.10 with extensions on Alpine Linux."

ENTRYPOINT ["docker-php-entrypoint"]

STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]