-- Script SQL pour l'injection des données dans la BDD 'simmpluedo'
-- Auteur : Justin DIDELOT
-- Date : 21/11/2024

-- ==================================================================
-- 1. Connexion a la BDD 'simpluedo' avec le superadmin
-- ==================================================================
\c simpluedo
-- ==================================================================
-- 2. Insertion des données dans la table 'roles'
-- ==================================================================
INSERT INTO roles (nom_roles) VALUES
('observateur'),
('utilisateur'),
('maitre du jeu');    
-- ==================================================================
-- 3. Insertion des données dans la table 'personnages'
-- ==================================================================
INSERT INTO personnages (nom_personnages) VALUES
('Colonel MOUTARDE'),
('Docteur OLIVE'),
('Professeur VIOLET'),
('Madame PERVENCHE'),
('Mademoiselle ROSE'),
('Madame LEBLANC');
-- ==================================================================
-- 4. Insertion des données dans la table 'salles'
-- ==================================================================
INSERT INTO salles (nom_salles) VALUES
('Cuisine'),
('Grand salon'),
('Petit salon'),
('Bureau'),
('Bibliothèque'),
('Studio'),
('Hall'),
('Véranda'),
('Salle à manger');
-- ==================================================================
-- 5. Insertion des données dans la table 'objets'
-- ==================================================================
INSERT INTO objets (nom_objets, id_salles) VALUES
('Poignard', 3),
('Revolver', 5),
('Chandelier', 1),
('Corde', 6),
('Clé anglaise', 4),
('Matraque', 2);
-- ==================================================================
-- 6. Insertion des données dans la table 'utilisateurs'
-- ==================================================================
INSERT INTO utilisateurs (pseudo_utilisateurs, id_roles, id_personnages) VALUES 
('Srekaens', 3, 2),
('MessaKami', 2, 1),
('GETGETR', 2, 3),
('Shotax', 2, 6),
('Nuage', 2, 5),
('Puduchlip', 2, 4);
-- ==================================================================
-- 7. Insertion des données dans la table 'utilisateurs'
-- ==================================================================
INSERT INTO utilisateurs (pseudo_utilisateurs, id_roles) VALUES 
('Martial', 1),
('Enguerran', 1),
('Boris', 1),
('Yohan', 1),
('Aurore', 1),
('Gabriel', 1);
