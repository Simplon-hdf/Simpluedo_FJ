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
-- 13. Création de la table 'position'
-- ==================================================================
CREATE TABLE position(
id_personnages INTEGER NOT NULL,
id_salles INTEGER NOT NULL,
heure_arrivee TIME NOT NULL,
PRIMARY KEY(id_personnages),
FOREIGN KEY(id_personnages) REFERENCES personnages(id_personnages),
FOREIGN KEY(id_salles) REFERENCES salles(id_salles));
-- ==================================================================
-- 14. Ajout de la clé étrangère 'id_roles' dans la table 'utilisateurs'
-- ==================================================================
ALTER TABLE utilisateurs
ADD COLUMN id_roles INTEGER,
ADD CONSTRAINT fk_utilisateurs_id_roles
FOREIGN KEY (id_roles) REFERENCES roles(id_roles);
-- ==================================================================
-- 15. Ajout de la clé étrangère 'id_personnage' dans la table 'utilisateur'
-- ==================================================================
ALTER TABLE utilisateurs
ADD COLUMN id_personnages INTEGER,
ADD CONSTRAINT fk_utilisateur_id_personnages
FOREIGN KEY (id_personnages) REFERENCES personnages(id_personnages);
-- ==================================================================
-- 16. Ajout de la clé étrangère 'id_salle' dans la table 'objet'
-- ==================================================================
ALTER TABLE objets
ADD COLUMN id_salles INTEGER,
ADD CONSTRAINT fk_objets_id_salles
FOREIGN KEY (id_salles) REFERENCES salles(id_salles);
-- ==================================================================
-- 17. Ajout des permissions pour l'administrateur 'simpluedo_admin'
-- ==================================================================
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO simpluedo_admin;
-- ==================================================================
-- 18. Trigger pour gérer les déplacements des personnages
-- ==================================================================
CREATE OR REPLACE FUNCTION trigger_update_position()
RETURNS TRIGGER AS $$
BEGIN
    -- Complète l'heure de sortie dans visiter
    UPDATE visiter
    SET heure_sortie = NEW.heure_arrivee
    WHERE id_personnages = NEW.id_personnages
      AND heure_sortie IS NULL;

    -- Mets à jour ou insère dans position
    INSERT INTO position (id_personnages, id_salles, heure_arrivee)
    VALUES (NEW.id_personnages, NEW.id_salles, NEW.heure_arrivee)
    ON CONFLICT (id_personnages)
    DO UPDATE SET id_salles = EXCLUDED.id_salles, heure_arrivee = EXCLUDED.heure_arrivee;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- ==================================================================
-- 19. Procédure pour ajouter un objet dans la table 'objets'
-- ==================================================================
CREATE OR REPLACE PROCEDURE ajout_objet(var_nom_objets VARCHAR, var_nom_salles VARCHAR)
 LANGUAGE plpgsql
 AS $$
 BEGIN
     -- Insérer directement l'objet en liant la salle par son nom
     INSERT INTO objets (nom_objets, id_salles)
     SELECT var_nom_objets, salles.id_salles
     FROM salles
     WHERE salles.nom_salles = var_nom_salles;
 
     -- Vérification si aucune salle ne correspond
     IF NOT FOUND THEN
         RAISE EXCEPTION 'La salle "%" n''existe pas.', var_nom_salles;
     END IF;
 END;
 $$;
-- ==================================================================
-- 20. Procédure pour lister tous les objets situés dans une salle
-- ==================================================================
 CREATE OR REPLACE FUNCTION lister_objet(nom_salle VARCHAR)
 RETURNS TABLE(nom_objets VARCHAR)
 LANGUAGE sql
 AS $$
    SELECT nom_objets
    FROM objets
    INNER JOIN salles ON salles.id_salles = objets.id_salles
    WHERE nom_salles = nom_salle;
 $$;