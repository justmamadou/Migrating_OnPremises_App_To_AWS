# Projet de migration d'application vers AWS

## Vue d'ensemble

Ce projet consiste en la migration d'une application WordPress avec WooCommerce depuis un environnement simulé on-premises vers une infrastructure AWS bien architecturée. L'objectif est de démontrer les avantages de la modernisation et de l'utilisation des services cloud AWS en termes de haute disponibilité, d'évolutivité et de gestion simplifiée.

## Architecture

### Environnement source (simulé on-premises)

- **Serveur web** : Instance EC2 unique exécutant Apache, PHP, WordPress et WooCommerce
- **Base de données** : Instance EC2 unique exécutant MySQL
- **Réseau** : Configuration réseau de base sans redondance

### Environnement cible (AWS)

- **Réseau** : VPC multi-AZ avec sous-réseaux publics et privés
- **Serveur web** : 
  - Groupe Auto Scaling d'instances EC2 dans des sous-réseaux privés
  - Application Load Balancer (ALB) dans des sous-réseaux publics
- **Base de données** : Amazon RDS for MySQL en configuration Multi-AZ
- **Sécurité** : 
  - Groupes de sécurité pour contrôler l'accès
  - Passerelles NAT pour l'accès Internet sortant des instances privées
- **Gestion** : AWS Systems Manager pour la gestion sécurisée des instances

## Processus de migration

1. **Découverte** : Utilisation d'AWS Application Discovery Service (ADS) pour collecter les métadonnées et les données de performance de l'environnement source.
2. **Planification** : Utilisation d'AWS Migration Hub pour planifier et suivre le processus de migration.
3. **Migration de la base de données** : Utilisation d'AWS Database Migration Service (DMS) pour migrer la base de données MySQL vers Amazon RDS, avec réplication continue pour minimiser les temps d'arrêt.
4. **Migration du serveur web** : Utilisation d'AWS Application Migration Service (MGN) pour effectuer une migration de type "lift-and-shift" du serveur web.
5. **Optimisation** : Ajustement de la configuration pour tirer parti des services AWS, y compris la mise en place de l'Auto Scaling et de l'équilibrage de charge.
6. **Basculement** : Réalisation du basculement final avec un minimum de temps d'arrêt.

## Avantages de la migration

- **Haute disponibilité** : Utilisation de multiples zones de disponibilité et de services gérés comme RDS et ALB.
- **Évolutivité** : Auto Scaling pour adapter automatiquement la capacité à la demande.
- **Sécurité améliorée** : Séparation des couches dans des sous-réseaux publics et privés, utilisation de groupes de sécurité.
- **Gestion simplifiée** : Utilisation de services gérés AWS pour réduire la charge opérationnelle.
- **Performance** : Possibilité d'optimiser les performances en utilisant des services AWS supplémentaires.

## Diagramme d'architecture

Pour visualiser l'architecture, nous recommandons de créer un diagramme utilisant un outil comme draw.io, Lucidchart, ou AWS Architecture Icons. Le diagramme devrait illustrer :

1. L'environnement source avec ses composants on-premises.
2. L'environnement cible AWS avec tous les services mentionnés ci-dessus.
3. Les flux de migration des données et des applications.

[Migration.png]
## Prochaines étapes

1. Configurer l'environnement source selon les instructions fournies.
2. Mettre en place l'infrastructure AWS cible.
3. Configurer et exécuter les services de migration AWS.
4. Effectuer des tests approfondis dans l'environnement cible.
5. Planifier et exécuter le basculement final.
6. Optimiser l'application dans son nouvel environnement AWS.

Ce projet offre une excellente opportunité d'apprentissage sur les processus de migration vers le cloud et l'utilisation des services AWS pour améliorer l'architecture d'une application.
