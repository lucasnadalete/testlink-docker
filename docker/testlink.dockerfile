FROM php:7.2.0-apache

LABEL maintainer="lucas.tux@gmail.com"

ENV TESTLINK_DISTRO_VERSION 1.9
ENV TESTLINNK_VERSION $TESTLINK_DISTRO_VERSION.19
ENV ROOT_HTTPD /var/www/html
ENV TESTLINK_DIR_TMP /var/testlink

RUN apt-get update
RUN apt-get install -y --force-yes wget libmcrypt-dev libpq-dev zlib1g-dev libzip-dev
RUN apt-get install -y --force-yes libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libfreetype6-dev
RUN apt-get install -y --force-yes libicu-dev g++
RUN apt-get install -y --force-yes curl libcurl3 libcurl3-dev

RUN pecl install mcrypt-1.0.2
RUN docker-php-ext-enable mcrypt

RUN docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir \
    --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir \
    --enable-gd-native-ttf
RUN docker-php-ext-install gd

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pdo pgsql pdo_pgsql mbstring zip intl iconv

RUN docker-php-ext-install mysqli curl

RUN mkdir -p $ROOT_HTTPD/testlink
RUN wget -q --tries=3 https://sourceforge.net/projects/testlink/files/TestLink%20$TESTLINK_DISTRO_VERSION/TestLink%20$TESTLINNK_VERSION/testlink-$TESTLINNK_VERSION.tar.gz/download
RUN mv download $TESTLINNK_VERSION.tar.gz
RUN tar zxvf $TESTLINNK_VERSION.tar.gz -C $ROOT_HTTPD/testlink --strip-components=2
RUN rm -f $TESTLINNK_VERSION.tar.gz
RUN mkdir -p $TESTLINK_DIR_TMP/upload_area
RUN mkdir -p $TESTLINK_DIR_TMP/logs
RUN chmod 777 -R $ROOT_HTTPD/testlink
RUN chmod 777 -R $TESTLINK_DIR_TMP/upload_area
RUN chmod 777 -R $TESTLINK_DIR_TMP/logs
RUN chown -R www-data:www-data $TESTLINK_DIR_TMP
RUN chown -R www-data:www-data $ROOT_HTTPD
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY ./docker/php.ini-production $PHP_INI_DIR/php.ini

COPY ./docker/config_db.inc.php $ROOT_HTTPD/testlink
COPY ./docker/custom_config.inc.php $ROOT_HTTPD/testlink

# BUGFIX - Files copied to fix some specific bug
COPY ./docker/bugfix/tlUser.class.php /var/www/html/testlink/lib/functions

ENTRYPOINT ["apache2ctl"]

CMD ["-D", "FOREGROUND"]

VOLUME [ "$ROOT_HTTPD/testlink" ]

EXPOSE 80
EXPOSE 443