FROM php:7.0-apache

MAINTAINER Adam Zouari <adam.zouari@heig-vd.ch>
MAINTAINER Oussama Lagha <oussama.lagha@heig-vd.ch>

RUN apt-get update && \
apt-get install -y nano

COPY apache2-foreground /usr/local/bin/
COPY templates /var/apache2/templates
COPY conf/ /etc/apache2


RUN a2enmod proxy proxy_http
RUN a2ensite 000-* 001-*
