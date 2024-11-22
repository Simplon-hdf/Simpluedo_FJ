-- Script SQL pour la création de la base de données PostgreSQL
-- Auteur : Justin DIDELOT
-- Date : 21/11/2024

-- ==================================================================
-- 1. Connexion a la BDD 'postgres' avec le superadmin
-- ==================================================================
\c postgres
-- ==================================================================
-- 2. Vérification si la base de données existe ou non
-- ==================================================================
DROP DATABASE IF EXISTS simpluedo;
-- ==================================================================
-- 3. Création de la base de données
-- ==================================================================
CREATE DATABASE simpluedo;
-- ==================================================================
-- 4. Création de l'administrateur
-- ==================================================================
CREATE USER simpluedo_admin;
-- ==================================================================
-- 5. Ajout d'un mot de passe a l'adminisrateur
-- ==================================================================
ALTER USER simpluedo_admin WITH PASSWORD 'admin';
-- ==================================================================
-- 6. Connexion a la BDD 'simpluedo' avec le superadmin
-- ==================================================================
\c simpluedo
-- ==================================================================
-- 7. Création de la table 'utilisateur'
-- ==================================================================
CREATE TABLE utilisateurs(
uuid_utilisateurs UUID PRIMARY KEY DEFAULT gen_random_uuid(),
pseudo_utilisateurs VARCHAR(50) NOT NULL);
-- ==================================================================
-- 8. Création de la table 'roles'
-- ==================================================================
CREATE TABLE roles(
id_roles INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
nom_roles VARCHAR(50) NOT NULL);
-- ==================================================================
-- 9. Création de la table 'salles'
-- ==================================================================
CREATE TABLE salles(
id_salles INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
nom_salles VARCHAR(50) NOT NULL);
-- ==================================================================
-- 10. Création de la table 'personnages'
-- ==================================================================
CREATE TABLE personnages(
id_personnages INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
nom_personnages VARCHAR(50) NOT NULL);
-- ==================================================================
-- 11. Création de la table 'objets'
-- ==================================================================
CREATE TABLE objets(
id_objets INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
nom_objets VARCHAR(50) NOT NULL);
-- ==================================================================
-- 12. Création de la table 'visiter'
-- ==================================================================
CREATE TABLE visiter(
id_personnages INTEGER,
id_salles INTEGER,
heure_arrivee TIME,
heure_sortie TIME,
PRIMARY KEY(id_personnages, id_salles, heure_arrivee),
FOREIGN KEY(id_personnages) REFERENCES personnages(id_personnages),
FOREIGN KEY(id_salles) REFERENCES salles(id_salles));
-- ==================================================================
-- 13. Ajout de la clé étrangère 'id_roles' dans la table 'utilisateurs'
-- ==================================================================
ALTER TABLE utilisateurs
ADD COLUMN id_roles INTEGER,
ADD CONSTRAINT fk_utilisateurs_id_roles
FOREIGN KEY (id_roles) REFERENCES roles(id_roles);
-- ==================================================================
-- 14. Ajout de la clé étrangère 'id_personnage' dans la table 'utilisateur'
-- ==================================================================
ALTER TABLE utilisateurs
ADD COLUMN id_personnages INTEGER,
ADD CONSTRAINT fk_utilisateur_id_personnages
FOREIGN KEY (id_personnages) REFERENCES personnages(id_personnages);
-- ==================================================================
-- 15. Ajout de la clé étrangère 'id_salle' dans la table 'objet'
-- ==================================================================
ALTER TABLE objets
ADD COLUMN id_salles INTEGER,
ADD CONSTRAINT fk_objets_id_salles
FOREIGN KEY (id_salles) REFERENCES salles(id_salles);
-- ==================================================================
-- 16. Ajout des permissions pour l'administrateur 'simpluedo_admin'
-- ==================================================================
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO simpluedo_admin;