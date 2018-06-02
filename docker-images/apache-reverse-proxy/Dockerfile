FROM php:7.0-apache

MAINTAINER Adam Zouari <adam.zouari@heig-vd.ch>
MAINTAINER Oussama Lagha <oussama.lagha@heig-vd.ch>

COPY conf/ /etc/apache2

RUN a2enmod proxy proxy_http
RUN a2ensite 000-* 001-*
