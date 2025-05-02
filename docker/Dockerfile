FROM php:8.2-apache

# Installation des dépendances PHP et Git
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    && docker-php-ext-install pdo pdo_mysql mysqli


# Clonage du dépôt principal et création d'un dossier temporaire tmp/Video_game_tournament_management
RUN git clone https://github.com/Ludovic-SIO/MyBodyTracker.git /tmp/MyBodyTracker

# Copie des fichiers php
RUN cp -r /tmp/MyBodyTracker/site/* /var/www/html/

# Création des fichier nécésaire pour bind
#RUN mkdir /etc/bind
#RUN mkdir /var/lib/bind

# Copie des fichiers dns
#RUN cp -r /tmp/Video_game_tournament_management/docker/config/* /etc/bind/
#RUN cp -r /tmp/Video_game_tournament_management/docker/zones/* /var/lib/bind/

# Nettoyage
RUN rm -rf /tmp/MyBodyTracker

EXPOSE 80

