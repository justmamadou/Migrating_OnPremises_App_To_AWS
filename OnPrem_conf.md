# Configuration de l'environnement source (simulation on-premises)

## 1. Création des instances EC2

### a. Instance pour le serveur web (WordPress + WooCommerce)
1. Lancez une instance EC2 (par exemple, t2.micro pour un environnement de test)
2. Choisissez une AMI Amazon Linux 2 ou Ubuntu Server
3. Configurez les groupes de sécurité pour autoriser les ports 22 (SSH) et 80 (HTTP)

### b. Instance pour la base de données MySQL
1. Lancez une autre instance EC2 (par exemple, t2.micro)
2. Choisissez la même AMI que pour le serveur web
3. Configurez les groupes de sécurité pour autoriser le port 22 (SSH) et 3306 (MySQL)

## 2. Installation et configuration du serveur web

1. Connectez-vous à l'instance du serveur web via SSH
2. Mettez à jour le système : `sudo yum update -y` (Amazon Linux) ou `sudo apt update && sudo apt upgrade -y` (Ubuntu)
3. Installez Apache, PHP et les extensions nécessaires :
   ```
   sudo yum install httpd php php-mysql -y  # Amazon Linux
   # ou
   sudo apt install apache2 php php-mysql libapache2-mod-php -y  # Ubuntu
   ```
4. Démarrez et activez Apache :
   ```
   sudo systemctl start httpd && sudo systemctl enable httpd  # Amazon Linux
   # ou
   sudo systemctl start apache2 && sudo systemctl enable apache2  # Ubuntu
   ```
5. Téléchargez et installez WordPress :
   ```
   cd /var/www/html
   sudo wget https://wordpress.org/latest.tar.gz
   sudo tar -xzf latest.tar.gz
   sudo mv wordpress/* .
   sudo chown -R apache:apache .  # Amazon Linux
   # ou
   sudo chown -R www-data:www-data .  # Ubuntu
   ```
6. Installez WooCommerce (après avoir configuré WordPress)

## 3. Installation et configuration de MySQL

1. Connectez-vous à l'instance de base de données via SSH
2. Installez MySQL :
   ```
   sudo yum install mysql-server -y  # Amazon Linux
   # ou
   sudo apt install mysql-server -y  # Ubuntu
   ```
3. Démarrez et activez MySQL :
   ```
   sudo systemctl start mysqld && sudo systemctl enable mysqld  # Amazon Linux
   # ou
   sudo systemctl start mysql && sudo systemctl enable mysql  # Ubuntu
   ```
4. Sécurisez l'installation MySQL :
   ```
   sudo mysql_secure_installation
   ```
5. Créez une base de données et un utilisateur pour WordPress :
   ```
   sudo mysql -u root -p
   CREATE DATABASE wordpress;
   CREATE USER 'wpuser'@'%' IDENTIFIED BY 'password';
   GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
   FLUSH PRIVILEGES;
   EXIT;
   ```
6. Configurez MySQL pour accepter les connexions distantes :
   - Modifiez le fichier de configuration MySQL (`/etc/my.cnf` ou `/etc/mysql/mysql.conf.d/mysqld.cnf`)
   - Changez la ligne `bind-address = 127.0.0.1` en `bind-address = 0.0.0.0`
   - Redémarrez MySQL : `sudo systemctl restart mysqld` ou `sudo systemctl restart mysql`

## 4. Configuration de WordPress

1. Retournez sur l'instance du serveur web
2. Copiez le fichier de configuration WordPress :
   ```
   cd /var/www/html
   sudo cp wp-config-sample.php wp-config.php
   ```
3. Modifiez wp-config.php avec les informations de la base de données :
   ```
   sudo nano wp-config.php
   ```
   Mettez à jour les lignes suivantes :
   ```
   define('DB_NAME', 'wordpress');
   define('DB_USER', 'wpuser');
   define('DB_PASSWORD', 'password');
   define('DB_HOST', 'private_ip_of_db_instance');
   ```
4. Terminez l'installation de WordPress via l'interface web

## 5. Configuration finale

1. Assurez-vous que les groupes de sécurité permettent la communication entre les instances
2. Testez l'accès à WordPress depuis l'adresse IP publique du serveur web
3. Installez et configurez WooCommerce via l'interface d'administration WordPress

N'oubliez pas de documenter toutes les configurations, y compris les adresses IP, les noms d'utilisateur et les mots de passe, car ces informations seront nécessaires lors de la migration.
