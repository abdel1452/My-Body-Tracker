# Définir le répertoire du projet
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
$PROJECT_mybt = Join-Path -Path $SCRIPT_DIR -ChildPath "project_mybt"

# Créer le répertoire du projet s'il n'existe pas
if (-Not (Test-Path -Path $PROJECT_mybt)) {
    New-Item -ItemType Directory -Path $PROJECT_mybt | Out-Null
}

# Naviguer vers le répertoire du projet
Set-Location -Path $PROJECT_mybt

# Écrire le Dockerfile
@"
FROM php:8.2-apache

# Installation des dépendances PHP et Git
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    && docker-php-ext-install pdo pdo_mysql mysqli


# Clonage du dépôt principal et création d'un dossier temporaire tmp/Video_game_tournament_management
RUN git clone https://github.com/Ludovic-SIO/MyBodyTracer.git /tmp/MyBodyTracer

# Copie des fichiers php
RUN cp -r /tmp/MyBodyTracer/site/* /var/www/html/

# Création des fichier nécésaire pour bind
#RUN mkdir /etc/bind
#RUN mkdir /var/lib/bind

# Copie des fichiers dns
#RUN cp -r /tmp/Video_game_tournament_management/docker/config/* /etc/bind/
#RUN cp -r /tmp/Video_game_tournament_management/docker/zones/* /var/lib/bind/

# Nettoyage
RUN rm -rf /tmp/MyBodyTracer

EXPOSE 80
"@ | Out-File -FilePath "Dockerfile" -Encoding utf8

# Écrire le fichier docker-compose.yml
@"
services:
  php:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: mybt_php
    ports:
      - 80:80
    #volumes:
      #- ./php:/var/www/html
  db:
    image: mysql:8.0
    container_name: mybt_mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: demo
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    ports:
      - "3307:3306"
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: mybt_phpmyadmin
    environment:
      PMA_HOST: db
      MYSQL_ROOT_PASSWORD: rootpassword
    ports:
      - "8080:8080"
  dns:
    image: ubuntu/bind9
    container_name: mybt_dns
    ports:
      - "5353:53/tcp"
      - "5353:53/udp"
"@ | Out-File -FilePath "docker-compose.yml" -Encoding utf8

# Démarrer les conteneurs avec Docker Compose
docker-compose up --build -d

# Ouvrir un nouveau terminal pour afficher les logs
Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$PROJECT_BIDOUILLE'; docker-compose logs -f`""

