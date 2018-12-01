FROM ubuntu:16.04
MAINTAINER Christopher Silva <xiris@xiris.com.br>

RUN apt-get update && \
    apt-get install -y \
      apache2 \
      php7.0 \
      php7.0-dev \
      php7.0-cli \
      libapache2-mod-php7.0 \
      php7.0-gd \
      php7.0-json \
      php7.0-ldap \
      php7.0-mbstring \
      php7.0-mysql \
      #php7.0-pgsql \
      #php7.0-sqlite3 \
      php7.0-xml \
      php7.0-xsl \
      php7.0-zip \
      php7.0-soap \
      php-pear

RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/lib/php/20151012/ -name xdebug.so)" > /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.remote_enable=1"                    >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.remote_autostart=1"                 >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.remote_connect_back=0"              >> /etc/php/7.0/mods-available/xdebug.ini \
    #&& echo "xdebug.remote_host=10.254.254.254" >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.remote_port=9000"                   >> /etc/php/7.0/mods-available/xdebug.ini \
    #&& echo "xdebug.idekey=PHPSTORM"                    >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.remote_handler=dbgp"                >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.profiler_output_dir=/var/www/html"  >> /etc/php/7.0/mods-available/xdebug.ini \
    && echo "xdebug.profiler_enable=0"                  >> /etc/php/7.0/mods-available/xdebug.ini

#COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80
CMD ["/usr/local/bin/run"]