# Configuration de l'environnement cible AWS

## 1. Création du VPC

1. Accédez à la console AWS et naviguez vers le service VPC
2. Cliquez sur "Créer un VPC"
3. Choisissez "VPC et plus"
4. Configurez les paramètres suivants :
   - Nom du VPC : "Production-VPC"
   - Bloc CIDR IPv4 : 10.0.0.0/16
   - Nombre de zones de disponibilité : 2
   - Nombre de sous-réseaux publics : 2
   - Nombre de sous-réseaux privés : 2
   - Passerelles NAT : 1 par zone de disponibilité
   - Points de terminaison VPC : S3 Gateway
5. Cliquez sur "Créer un VPC"

## 2. Configuration des groupes de sécurité

### a. Groupe de sécurité pour le serveur web
1. Dans la console VPC, créez un nouveau groupe de sécurité nommé "Web-SG"
2. Ajoutez les règles entrantes suivantes :
   - HTTP (80) depuis partout
   - HTTPS (443) depuis partout
   - SSH (22) depuis votre adresse IP

### b. Groupe de sécurité pour RDS
1. Créez un nouveau groupe de sécurité nommé "RDS-SG"
2. Ajoutez une règle entrante :
   - MySQL/Aurora (3306) depuis le groupe de sécurité Web-SG

## 3. Création de l'instance RDS

1. Accédez au service RDS dans la console AWS
2. Cliquez sur "Créer une base de données"
3. Choisissez "MySQL"
4. Sélectionnez "Production" pour le modèle
5. Configurez les paramètres suivants :
   - Identifiant de l'instance : prod-wordpress-db
   - Master username : choisissez un nom d'utilisateur
   - Master password : choisissez un mot de passe fort
   - Classe d'instance : choisissez selon vos besoins (ex: db.t3.micro pour les tests)
   - Stockage : GP2, allouez selon vos besoins
   - Multi-AZ deployment : Oui
   - VPC : sélectionnez le VPC créé précédemment
   - Groupe de sous-réseau : choisissez les sous-réseaux privés
   - Groupe de sécurité : sélectionnez RDS-SG
6. Cliquez sur "Créer une base de données"

## 4. Configuration d'Elastic Load Balancer (ELB)

1. Accédez au service EC2 dans la console AWS
2. Dans la section "Équilibrage de charge", cliquez sur "Équilibreurs de charge"
3. Cliquez sur "Créer un équilibreur de charge"
4. Choisissez "Application Load Balancer"
5. Configurez les paramètres suivants :
   - Nom : Prod-Web-ALB
   - Schéma : Orienté vers l'Internet
   - Type d'adresse IP : IPv4
   - VPC : sélectionnez le VPC créé précédemment
   - Mappings : sélectionnez les deux sous-réseaux publics
   - Groupe de sécurité : créez un nouveau groupe autorisant le trafic HTTP et HTTPS
   - Listeners : configurez pour HTTP (80) et HTTPS (443)
6. Créez un groupe cible pour le listener HTTP
7. Terminez la création de l'ALB

## 5. Création du groupe Auto Scaling

1. Dans la console EC2, accédez à "Groupes Auto Scaling"
2. Cliquez sur "Créer un groupe Auto Scaling"
3. Créez un modèle de lancement avec les paramètres suivants :
   - AMI : Amazon Linux 2 ou Ubuntu Server
   - Type d'instance : t3.micro (ou selon vos besoins)
   - Paire de clés : sélectionnez ou créez une nouvelle paire
   - Réseau : choisissez le VPC créé précédemment
   - Groupe de sécurité : sélectionnez Web-SG
   - Stockage : GP2, 8 Go (ou selon vos besoins)
4. Configurez le groupe Auto Scaling :
   - Choisissez les sous-réseaux privés
   - Attachez-le à l'ALB créé précédemment
   - Définissez la capacité désirée, minimale et maximale (ex: 2, 2, 4)
5. Configurez les politiques de mise à l'échelle (par exemple, basées sur l'utilisation du CPU)

## 6. Configuration de Route 53 (optionnel)

1. Accédez au service Route 53
2. Créez ou sélectionnez une zone hébergée pour votre domaine
3. Créez un nouvel enregistrement :
   - Nom : www ou @ (pour le domaine racine)
   - Type : A - IPv4 address
   - Alias : Oui
   - Cible de l'alias : sélectionnez votre ALB

## 7. Configuration d'AWS Systems Manager (SSM)

1. Accédez au service Systems Manager
2. Dans "Gestion des nœuds", activez Session Manager
3. Configurez les autorisations IAM nécessaires pour vos instances EC2
