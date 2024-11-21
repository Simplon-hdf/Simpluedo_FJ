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
-- 2. Ajout d'un mot de passe a l'adminisrateur
-- ==============================================
ALTER USER simpluedo_admin WITH PASSWORD 'admin';