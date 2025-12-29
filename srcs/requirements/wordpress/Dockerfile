FROM alpine:3.22

EXPOSE 9000
# Install PHP and extensions
RUN apk update && apk add --no-cache php83 php-fpm php-common php-json php-session php-mysqli php83-phar mariadb-client php83-iconv php83-mbstring curl
# Install WP-CLI, the command line interface for WordPress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
# Create www-data user, used by PHP-FPM to run processes
RUN adduser -S www-data && adduser www-data www-data

# Increase PHP memory limit for WP-CLI
RUN echo "memory_limit = 256M" >> /etc/php83/php.ini

COPY ./conf/wordpress.conf /etc/php83/php-fpm.d/www.conf
RUN mkdir -p /var/www/wordpress
COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

WORKDIR /var/www/wordpress
# Start PHP-FPM in the foreground
# the -F flag tells PHP-FPM to stay in the foreground
# the foreground is required for Docker containers to keep running
# php83-fpm installed from Alpine 3.22 uses php-fpm83 path
CMD ["/usr/sbin/php-fpm83", "-F"]