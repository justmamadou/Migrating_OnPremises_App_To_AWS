#!/bin/bash

# Script de déploiement MySQL

# Mise à jour du système
sudo apt update && sudo apt upgrade -y

# Installation de MySQL
sudo apt install mysql-server -y

# Démarrage et activation de MySQL
sudo systemctl start mysql
sudo systemctl enable mysql

# Sécurisation de l'installation MySQL
#sudo mysql_secure_installation

# Création de la base de données et de l'utilisateur pour WordPress
MYSQL_ROOT_PASSWORD="passer"
WP_DB_NAME="wordpress"
WP_DB_USER="wpuser"
WP_DB_PASSWORD="passer"

# Connexion à MySQL et exécution des commandes
sudo mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE ${WP_DB_NAME};
CREATE USER '${WP_DB_USER}'@'%' IDENTIFIED BY '${WP_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'%';
FLUSH PRIVILEGES;
EXIT
EOF

# Configuration de MySQL pour accepter les connexions distantes
sudo sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Redémarrage de MySQL pour appliquer les changements
sudo systemctl restart mysql

echo "Installation et configuration de MySQL terminées."