-- Script SQL pour la création de la base de données PostgreSQL
-- Auteur : Justin DIDELOT
-- Date : 21/11/2024

-- ==============================================
-- 1. Création de la base de données
-- ==============================================
CREATE DATABASE simpluedo;
-- ==============================================
-- 2. Création de l'administrateur
-- ==============================================
CREATE USER simpluedo_admin;
-- ==============================================
-- 3. Ajout d'un mot de passe a l'adminisrateur
-- ==============================================
ALTER USER simpluedo_admin WITH PASSWORD 'admin';
-- ==============================================
-- 4. Création de la table 'utilisateur'
-- ==============================================
CREATE TABLE utilisateur(
 uuid_utilisateur UUID PRIMARY KEY DEFAULT gen_random_uuid(),
 pseudo_utilisateur VARCHAR(50) NOT NULL);