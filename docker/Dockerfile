FROM php:8.2-apache

# Installation des dépendances PHP et Git
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    && docker-php-ext-install pdo pdo_mysql mysqli

# Clonage du dépôt MyBodyTracker (public)
RUN git clone https://github.com/Ludovic-SIO/MyBodyTracker.git /tmp/MyBodyTracker

# Copie des fichiers PHP dans Apache
RUN cp -r /tmp/MyBodyTracker/site/* /var/www/html/

# Nettoyage du dépôt temporaire
RUN rm -rf /tmp/MyBodyTracker

EXPOSE 80


