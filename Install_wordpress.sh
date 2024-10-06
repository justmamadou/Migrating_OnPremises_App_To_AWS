#!/bin/bash

# Script de déploiement WordPress

# Mise à jour du système
sudo apt update && sudo apt upgrade -y

# Installation d'Apache, PHP et des extensions nécessaires
sudo apt install apache2 php php-mysql libapache2-mod-php php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y

# Démarrage et activation d'Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Téléchargement et installation de WordPress
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
sudo mv wordpress/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Configuration de WordPress
cd /var/www/html
sudo cp wp-config-sample.php wp-config.php
sudo sed -i "s/database_name_here/wordpress/" wp-config.php
sudo sed -i "s/username_here/wpuser/" wp-config.php
sudo sed -i "s/password_here/passer/" wp-config.php

# Génération des clés de sécurité
SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
sudo sed -i "/#@-/,/#@+/c $SALT" wp-config.php

# Installation de WP-CLI
sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo php wp-cli.phar --info
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Vérification que WP-CLI fonctionne correctement
wp --info


# Installation de WooCommerce (optionnel)
sudo -u www-data wp plugin install woocommerce --activate

# Redémarrage d'Apache
sudo systemctl restart apache2

echo "Installation et configuration de WordPress terminées."
echo "Accédez à http://votre_adresse_ip pour terminer la configuration de WordPress."