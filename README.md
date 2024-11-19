# Brief Simpluedo

<!-- Main image  -->

![border](./assets/line/border_deco_rt.png)

# Sommaire

- [Objectif et Consignes](#objectif-et-consignes)
- [Modalités](#modalités-dévaluation)
- [Livrables](#livrables)
- [Critères de performance](#critères-de-performance)
- [Contexte du projet](#contexte-du-projet)
- [Modalités pédagogiques](#modalités-pédagogiques)
- [Règles de la base de données](#règles-de-la-base-de-données)
- [Peuplement des données](#peuplement-des-données)
- [Requêtes à réaliser](#requêtes-à-réaliser)
- [Procédures stockées](#procédures-stockées)
- [Trigger à réaliser](#trigger-à-réaliser)
- [Contraintes](#contraintes)

# Navigation

- [Veille](./doc/annexe/veille.md)

![border](./assets/line/line-pink-point_l.png)

## Modalités d'évaluation

- Correction entre pairs
- Les requêtes seront testées sur un environnement local après importation de l'environnement

## Livrables

Un dépôt GitHub contenant :

- [ ] Dictionnaire de données
- [ ] MCD
- [ ] MLD
- [ ] MPD
- [ ] Script SQL de génération de la BDD
- [ ] Script SQL permettant d'intégrer les données
- [ ] Requêtes SQL dans le README.md

- [ ] Optionnel : un environnement sous Docker

### Critères de performance

- [ ] Installation facile de l'environnement et sans erreur
- [ ] Exactitude des relations entre les tables
- [ ] Trigger mis en place
- [ ] Bonne présentation des requêtes sur le README.md
- [ ] Exécution des requêtes sans erreur

## Contexte du projet

En tant que développeur, , vous devez réaliser un système informatique permettant de gérer une partie de jeu de société que vous avez envie de réaliser avec vos avis

​

Ce jeu de société est basé sur le Cluedo avec des personnages que les joueurs déplacent au sein d'un manoir, dans les différentes pièces de celui-ci.

​

Vous devez donc créer un environnement permettant de stocker, pour une partie donnée d'un jeu, les déplacements des personnages de chaque joueur.

Comme Rome ne s'est pas construite en un jour, vous allez commencer par la mise en place d'un site web permettant de procéder à différentes opérations de recherches à propos de l'emplacement des différents personnages.

Sauf que la partie site web n'est pas pour tout de suite.

Avant cela, vous avez besoin d'une base de données pour le stockage. Et donc de la concevoir et de la mettre en place !

<a href="#sommaire">
<img src="assets/button/back_to_top.png" alt="Home page" style="width: 150px; height: auto;">
</a>

## Modalités pédagogiques

Activité individuelle en mode collaboratif.

## Règles de la base de données

- Les informations concernant chaque joueur de la partie doivent être enregistrées

- Un joueur aura un rôle au sein de la partie (Maître du jeu, utilisateur ou observateur)

- Il ne pourra y avoir qu'un seul maître du jeu dans la partie

- Chaque joueur aura un personne à l'exception des observateurs

- Un personnage pourra être présent dans une pièce sur une période donnée (toujours la même date mais stockage des heures différentes)

- Un personnage pourra visiter une pièce plusieurs fois

- Une pièce contiendra une liste d'objets

## Peuplement des données

- Les données concernant les personnages, les pièces et les objets doivent être remplies conformément à ceux présents dans le jeu original Cluedo
  ​

## Requêtes à réaliser

- Lister tous les personnages du jeu

- Lister chaque joueur et son personnage associé

- Afficher la liste des personnages présents dans la cuisine entre 08:00 et 09:00

- Afficher les pièces où aucun personnage n'est allé

- Compter le nombre d'objets par pièce

- Ajouter une pièce

- Modifier un objet

- Supprimer une pièce

​<a href="#sommaire">
<img src="assets/button/back_to_top.png" alt="Home page" style="width: 150px; height: auto;">
</a>

## Procédures stockées

Vous devez réaliser les procédures stockées suivantes :

- Lister tous les objets situés dans une pièce passée en paramètre

- Ajout d'un objet passé en paramètre et association avec la pièce concernée

​

## Trigger à réaliser

- Une table supplémentaire devra être créé pour savoir en temps réel où se trouvent chacun des personnages.

- Cette table sera mise à jour via un trigger à chaque fois qu'un personnage entre ou sort d'une pièce

​

## Contraintes

- Le NoSQL n'est pas autorisé

- Une gestion RBAC devra être mise en place

- Seul l'administrateur de la BDD pourra ajouter, modifier ou supprimer des données

<a href="#sommaire">
<img src="assets/button/back_to_top.png" alt="Home page" style="width: 150px; height: auto;">
</a>

![border](./assets/line/line-teal-point_l.png)

![border](./assets/line/border_deco_rt.png)
