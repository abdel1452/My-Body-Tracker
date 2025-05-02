FROM php:8.2-apache

# Installation des dépendances PHP et Git
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    && docker-php-ext-install pdo pdo_mysql mysqli

# Clonage du dépôt MyBodyTracker
RUN git clone https://github.com/Ludovic-SIO/MyBodyTracker.git /tmp/MyBodyTracker

# Copie des fichiers PHP dans Apache
RUN cp -r /tmp/MyBodyTracker/site/* /var/www/html/

# Préparation des dossiers nécessaires pour BIND
#RUN mkdir -p /etc/bind
#RUN mkdir -p /var/lib/bind

# Copie des fichiers de configuration DNS (Bind9)
#RUN cp -r /tmp/MyBodyTracker/docker/config/* /etc/bind/
#RUN cp -r /tmp/MyBodyTracker/docker/zones/* /var/lib/bind/

# Nettoyage du dépôt temporaire
RUN rm -rf /tmp/MyBodyTracker

# Expose le port 80 (Apache)
EXPOSE 80

